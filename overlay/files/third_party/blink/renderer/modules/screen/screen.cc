// Copyright 2007 Apple Inc. All rights reserved.
// Copyright (C) 2007 David Smith (catfish.man@gmail.com)
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
// 1.  Redistributions of source code must retain the above copyright
//     notice, this list of conditions and the following disclaimer.
// 2.  Redistributions in binary form must reproduce the above copyright
//     notice, this list of conditions and the following disclaimer in the
//     documentation and/or other materials provided with the distribution.
// 3.  Neither the name of Apple Computer, Inc. ("Apple") nor the names of
//     its contributors may be used to endorse or promote products derived
//     from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY APPLE AND ITS CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL APPLE OR ITS CONTRIBUTORS BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
// THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include "third_party/blink/renderer/modules/screen/screen.h"

#include <optional>

#include "third_party/blink/renderer/core/frame/local_dom_window.h"
#include "third_party/blink/renderer/core/frame/local_frame.h"
#include "third_party/blink/renderer/core/frame/settings.h"
#include "third_party/blink/renderer/core/page/chrome_client.h"
#include "third_party/blink/renderer/core/probe/core_probes.h"
#include "ui/display/screen_info.h"

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

Screen::Screen(LocalDOMWindow* window, int64_t display_id)
    : ExecutionContextClient(window), display_id_(display_id) {}

int Screen::height() const {
  // ===== SPOOF-RES: 伪装 screen.height =====
  static SpoofParams sp = ParseSpoofParams();
  if (sp.enabled) {
    const int inset_px = static_cast<int>(24 * sp.dpr);  // Status bar
    return sp.h - inset_px;
  }
  
  if (!DomWindow()) {
    return 0;
  }
  LocalFrame* frame = DomWindow()->GetFrame();
  if (!frame) {
    return 0;
  }
  long height = static_cast<long>(lroundf(
      GetScreenInfo().available_rect.height() / GetDevicePixelRatio()));
  return static_cast<int>(height);
}

int Screen::width() const {
  // ===== SPOOF-RES: 伪装 screen.width =====
  static SpoofParams sp = ParseSpoofParams();
  if (sp.enabled) {
    return sp.w;
  }
  
  if (!DomWindow()) {
    return 0;
  }
  LocalFrame* frame = DomWindow()->GetFrame();
  if (!frame) {
    return 0;
  }
  long width = static_cast<long>(lroundf(
      GetScreenInfo().available_rect.width() / GetDevicePixelRatio()));
  return static_cast<int>(width);
}

// ... existing code ...

int Screen::availHeight() const {
  // ===== SPOOF-RES: 伪装 screen.availHeight =====
  static SpoofParams sp = ParseSpoofParams();
  if (sp.enabled) {
    const int inset_px = static_cast<int>(24 * sp.dpr);  // Status bar
    return sp.h - inset_px;
  }
  
  if (!DomWindow()) {
    return 0;
  }
  LocalFrame* frame = DomWindow()->GetFrame();
  if (!frame) {
    return 0;
  }
  long avail_height = static_cast<long>(lroundf(
      GetScreenInfo().available_rect.height() / GetDevicePixelRatio()));
  return static_cast<int>(avail_height);
}

int Screen::availWidth() const {
  // ===== SPOOF-RES: 伪装 screen.availWidth =====
  static SpoofParams sp = ParseSpoofParams();
  if (sp.enabled) {
    return sp.w;
  }
  
  if (!DomWindow()) {
    return 0;
  }
  LocalFrame* frame = DomWindow()->GetFrame();
  if (!frame) {
    return 0;
  }
  long avail_width = static_cast<long>(lroundf(
      GetScreenInfo().available_rect.width() / GetDevicePixelRatio()));
  return static_cast<int>(avail_width);
}

// ... existing code ...

const display::ScreenInfo& Screen::GetScreenInfo() const {
  DCHECK(DomWindow());
  LocalFrame* frame = DomWindow()->GetFrame();
  const display::ScreenInfo& screen_info =
      frame->GetChromeClient().GetScreenInfo(*frame);
  return screen_info;
}

float Screen::GetDevicePixelRatio() const {
  DCHECK(DomWindow());
  LocalFrame* frame = DomWindow()->GetFrame();
  if (!frame) {
    return 1.0f;
  }
  return frame->DevicePixelRatio();
}

void Screen::Trace(Visitor* visitor) const {
  EventTarget::Trace(visitor);
  ExecutionContextClient::Trace(visitor);
  Supplementable<Screen>::Trace(visitor);
}

}  // namespace blink