// Copyright 2010 The Chromium Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "third_party/blink/renderer/core/frame/local_dom_window.h"

#include <memory>
#include <utility>

#include "base/feature_list.h"
#include "base/logging.h"
#include "base/metrics/histogram_macros.h"
#include "third_party/blink/renderer/bindings/core/v8/to_v8_traits.h"
#include "third_party/blink/renderer/bindings/core/v8/v8_binding_for_core.h"
#include "third_party/blink/renderer/bindings/core/v8/window_proxy.h"
#include "third_party/blink/renderer/core/css/css_computed_style_declaration.h"
#include "third_party/blink/renderer/core/css/css_rule_list.h"
#include "third_party/blink/renderer/core/css/css_style_declaration.h"
#include "third_party/blink/renderer/core/css/dom_window_css.h"
#include "third_party/blink/renderer/core/css/media_query_list.h"
#include "third_party/blink/renderer/core/css/media_query_matcher.h"
#include "third_party/blink/renderer/core/css/resolver/style_resolver.h"
#include "third_party/blink/renderer/core/css/style_media.h"
#include "third_party/blink/renderer/core/dom/document.h"
#include "third_party/blink/renderer/core/dom/document_init.h"
#include "third_party/blink/renderer/core/dom/frame_request_callback_collection.h"
#include "third_party/blink/renderer/core/events/hash_change_event.h"
#include "third_party/blink/renderer/core/events/message_event.h"
#include "third_party/blink/renderer/core/events/page_transition_event.h"
#include "third_party/blink/renderer/core/events/pop_state_event.h"
#include "third_party/blink/renderer/core/frame/bar_prop.h"
#include "third_party/blink/renderer/core/frame/dom_visual_viewport.h"
#include "third_party/blink/renderer/core/frame/external.h"
#include "third_party/blink/renderer/core/frame/frame_console.h"
#include "third_party/blink/renderer/core/frame/history.h"
#include "third_party/blink/renderer/core/frame/local_frame.h"
#include "third_party/blink/renderer/core/frame/location.h"
#include "third_party/blink/renderer/core/frame/navigator.h"
#include "third_party/blink/renderer/core/frame/screen.h"
#include "third_party/blink/renderer/core/frame/settings.h"
#include "third_party/blink/renderer/core/html/custom/custom_element_registry.h"
#include "third_party/blink/renderer/core/html/html_frame_owner_element.h"
#include "third_party/blink/renderer/core/input/event_handler.h"
#include "third_party/blink/renderer/core/inspector/console_message.h"
#include "third_party/blink/renderer/core/loader/document_loader.h"
#include "third_party/blink/renderer/core/page/chrome_client.h"
#include "third_party/blink/renderer/core/page/create_window.h"
#include "third_party/blink/renderer/core/page/page.h"
#include "third_party/blink/renderer/core/page/scrolling/top_document_root_scroller_controller.h"
#include "third_party/blink/renderer/platform/heap/garbage_collected.h"
#include "third_party/blink/renderer/platform/instrumentation/use_counter.h"
#include "third_party/blink/renderer/platform/timer.h"
#include "third_party/blink/renderer/platform/weborigin/security_origin.h"
#include "third_party/blink/renderer/platform/widget/frame_widget.h"

// ===== SPOOF-RES: 命令行解析 =====
#include "base/command_line.h"
#include "content/public/common/content_switches.h"
#include <cstdio>

namespace {
struct SpoofParams {
  bool enabled = false;
  int w = 0;
  int h = 0;
  float dpr = 0.0f;
};

static bool ParseWxH_DPR(const std::string& s, int* w, int* h, float* dpr) {
  int iw = 0, ih = 0;
  double id = 0.0;
  if (sscanf(s.c_str(), "%dx%d@%lf", &iw, &ih, &id) == 3 && iw > 0 && ih > 0 && id > 0.0) {
    *w = iw;
    *h = ih;
    *dpr = static_cast<float>(id);
    return true;
  }
  return false;
}

static SpoofParams ParseSpoofParams() {
  SpoofParams sp;
  const base::CommandLine* cmd = base::CommandLine::ForCurrentProcess();
  if (cmd->HasSwitch(switches::kSpoofResolution)) {
    std::string v = cmd->GetSwitchValueASCII(switches::kSpoofResolution);
    if (ParseWxH_DPR(v, &sp.w, &sp.h, &sp.dpr)) {
      sp.enabled = true;
      return sp;
    }
  }
  return sp;
}
}  // namespace

namespace blink {

// ... existing code ...

double LocalDOMWindow::devicePixelRatio() const {
  // ===== SPOOF-RES: 伪装 window.devicePixelRatio =====
  static SpoofParams sp = ParseSpoofParams();
  if (sp.enabled) {
    return static_cast<double>(sp.dpr);
  }
  
  if (!GetFrame()) {
    return 0.0;
  }
  return GetFrame()->DevicePixelRatio();
}

int LocalDOMWindow::innerHeight() const {
  // ===== SPOOF-RES: 伪装 window.innerHeight =====
  static SpoofParams sp = ParseSpoofParams();
  if (sp.enabled) {
    const int css_h = static_cast<int>(sp.h / sp.dpr);
    const int inset_css = static_cast<int>(24);  // Status bar in CSS pixels
    return css_h - inset_css;
  }
  
  if (!GetFrame()) {
    return 0;
  }
  LocalFrameView* view = GetFrame()->View();
  if (!view) {
    return 0;
  }
  return AdjustForAbsoluteZoom::AdjustInt(view->Height(), GetFrame()->GetDocument());
}

int LocalDOMWindow::innerWidth() const {
  // ===== SPOOF-RES: 伪装 window.innerWidth =====
  static SpoofParams sp = ParseSpoofParams();
  if (sp.enabled) {
    return static_cast<int>(sp.w / sp.dpr);
  }
  
  if (!GetFrame()) {
    return 0;
  }
  LocalFrameView* view = GetFrame()->View();
  if (!view) {
    return 0;
  }
  return AdjustForAbsoluteZoom::AdjustInt(view->Width(), GetFrame()->GetDocument());
}

int LocalDOMWindow::outerHeight() const {
  // ===== SPOOF-RES: 伪装 window.outerHeight =====
  static SpoofParams sp = ParseSpoofParams();
  if (sp.enabled) {
    return sp.h;
  }
  
  if (!GetFrame()) {
    return 0;
  }
  LocalFrameView* view = GetFrame()->View();
  if (!view) {
    return 0;
  }
  return AdjustForAbsoluteZoom::AdjustInt(view->Height(), GetFrame()->GetDocument());
}

int LocalDOMWindow::outerWidth() const {
  // ===== SPOOF-RES: 伪装 window.outerWidth =====
  static SpoofParams sp = ParseSpoofParams();
  if (sp.enabled) {
    return sp.w;
  }
  
  if (!GetFrame()) {
    return 0;
  }
  LocalFrameView* view = GetFrame()->View();
  if (!view) {
    return 0;
  }
  return AdjustForAbsoluteZoom::AdjustInt(view->Width(), GetFrame()->GetDocument());
}

// ... existing code ...

}  // namespace blink