/*
 * Copyright (C) 2007 Apple Inc.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1.  Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 * 2.  Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 * 3.  Neither the name of Apple Computer, Inc. ("Apple") nor the names of
 *     its contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE AND ITS CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL APPLE OR ITS CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "third_party/blink/renderer/core/frame/screen.h"

#include "base/numerics/safe_conversions.h"
#include "services/network/public/mojom/permissions_policy/permissions_policy_feature.mojom-blink.h"
#include "third_party/blink/renderer/core/event_target_names.h"
#include "third_party/blink/renderer/core/frame/local_dom_window.h"
#include "third_party/blink/renderer/core/frame/local_frame.h"
#include "third_party/blink/renderer/core/frame/settings.h"
#include "third_party/blink/renderer/core/page/chrome_client.h"
#include "ui/display/screen_info.h"
#include "ui/display/screen_infos.h"

namespace blink {

// ====== 重要说明 ======
// 本覆写版仅伪装 web 暴露的 screen 信息，
// 不改动底层显示/布局逻辑，不影响设备真实渲染区域。
// =====================

namespace {
constexpr int kSpoofedWidth = 888;
constexpr int kSpoofedHeight = 888;
constexpr unsigned kSpoofedColorDepth = 24u;
}  // namespace

Screen::Screen(LocalDOMWindow* window, int64_t display_id)
    : ExecutionContextClient(window), display_id_(display_id) {
  if (RuntimeEnabledFeatures::ReduceScreenSizeEnabled() && DomWindow() &&
      DomWindow()->IsFeatureEnabled(
          network::mojom::PermissionsPolicyFeature::kWindowManagement)) {
    auto descriptor = mojom::blink::PermissionDescriptor::New();
    descriptor->name = mojom::blink::PermissionName::WINDOW_MANAGEMENT;
    Vector<mojom::blink::PermissionDescriptorPtr> descriptors;
    descriptors.push_back(std::move(descriptor));
    CachedPermissionStatus::From(DomWindow())
        ->RegisterClient(this, std::move(descriptors));
  }
}

// static
bool Screen::AreWebExposedScreenPropertiesEqual(
    const display::ScreenInfo& prev,
    const display::ScreenInfo& current) {
  // 下方保持原逻辑，不影响伪装（我们不再依赖这些真实值）
  if (prev.rect.size() != current.rect.size())
    return false;
  if (prev.device_scale_factor != current.device_scale_factor)
    return false;
  if (prev.available_rect != current.available_rect)
    return false;
  if (prev.depth != current.depth)
    return false;
  if (prev.is_extended != current.is_extended)
    return false;
  return true;
}

// ====== Web 可见属性：全部写死 ======

int Screen::height() const { return kSpoofedHeight; }
int Screen::width() const { return kSpoofedWidth; }
unsigned Screen::colorDepth() const { return kSpoofedColorDepth; }
unsigned Screen::pixelDepth() const { return kSpoofedColorDepth; }

int Screen::availHeight() const { return kSpoofedHeight; }
int Screen::availWidth() const { return kSpoofedWidth; }

// 这两个方法是 V8 绑定会强制调用的，如果不实现会导致链接报
// undefined symbol（你之前的链接错误即由此产生）。
int Screen::availLeft() const { return 0; }
int Screen::availTop() const { return 0; }

// ====== 其余与生命周期/权限/追踪相关的方法保持原样 ======

void Screen::Trace(Visitor* visitor) const {
  EventTarget::Trace(visitor);
  ExecutionContextClient::Trace(visitor);
  Supplementable<Screen>::Trace(visitor);
}

const AtomicString& Screen::InterfaceName() const {
  return event_target_names::kScreen;
}

ExecutionContext* Screen::GetExecutionContext() const {
  return ExecutionContextClient::GetExecutionContext();
}

bool Screen::ShouldReduceScreenSize() const {
  return RuntimeEnabledFeatures::ReduceScreenSizeEnabled() &&
         !window_management_permission_granted_;
}

bool Screen::isExtended() const {
  if (!DomWindow() || ShouldReduceScreenSize())
    return false;
  auto* context = GetExecutionContext();
  if (!context->IsFeatureEnabled(
          network::mojom::PermissionsPolicyFeature::kWindowManagement)) {
    return false;
  }
  // 这里返回真实 is_extended，不会影响分辨率伪装
  return GetScreenInfo().is_extended;
}

// 注意：GetRect / GetScreenInfo 依旧保留，用于内部逻辑；
// 但 web 暴露的属性已被上面方法写死，不会再使用这些真实值。
gfx::Rect Screen::GetRect(bool available) const {
  if (!DomWindow())
    return gfx::Rect();
  LocalFrame* frame = DomWindow()->GetFrame();
  const display::ScreenInfo& screen_info = GetScreenInfo();
  gfx::Rect rect = available ? screen_info.available_rect : screen_info.rect;
  if (frame->GetSettings()->GetReportScreenSizeInPhysicalPixelsQuirk())
    return gfx::ScaleToRoundedRect(rect, screen_info.device_scale_factor);
  return rect;
}

const display::ScreenInfo& Screen::GetScreenInfo() const {
  DCHECK(DomWindow());
  LocalFrame* frame = DomWindow()->GetFrame();

  const auto& screen_infos = frame->GetChromeClient().GetScreenInfos(*frame);
  for (const auto& screen : screen_infos.screen_infos) {
    if (screen.display_id == display_id_)
      return screen;
  }
  DEFINE_STATIC_LOCAL(display::ScreenInfo, kEmptyScreenInfo, ());
  return kEmptyScreenInfo;
}

void Screen::OnPermissionStatusChange(mojom::blink::PermissionName name,
                                      mojom::blink::PermissionStatus status) {
  CHECK(name == mojom::blink::PermissionName::WINDOW_MANAGEMENT);
  window_management_permission_granted_ =
      status == mojom::blink::PermissionStatus::GRANTED;
}

void Screen::OnPermissionStatusInitialized(
    CachedPermissionStatus::PermissionStatusMap map) {
  window_management_permission_granted_ =
      map.size() > 0U && std::ranges::all_of(map, [](const auto& status) {
        return status.value == mojom::blink::PermissionStatus::GRANTED;
      });
  CHECK(!window_management_permission_granted_ || map.size() == 1U);
}

}  // namespace blink
