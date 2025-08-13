// overlay/files/third_party/blink/renderer/core/frame/screen.cc

#include "third_party/blink/renderer/core/frame/screen.h"

#include "base/numerics/safe_conversions.h"
#include "services/network/public/mojom/permissions_policy/permissions_policy_feature.mojom-blink.h"
// #include "third_party/blink/renderer/core/dom/cached_permission_status.h"
#include "third_party/blink/renderer/core/event_target_names.h"
#include "third_party/blink/renderer/core/frame/local_dom_window.h"
#include "third_party/blink/renderer/core/frame/local_frame.h"
#include "third_party/blink/renderer/core/frame/settings.h"
#include "third_party/blink/renderer/core/page/chrome_client.h"
#include "third_party/blink/renderer/platform/runtime_enabled_features.h"
#include "ui/display/screen_info.h"
#include "ui/display/screen_infos.h"

namespace blink {

// —— 仅伪装 Web 暴露的 screen 信息；不改动真实渲染与系统显示 —— //
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

// 保留：仅用于判断“真实屏幕信息是否变化”，与伪装无冲突。
bool Screen::AreWebExposedScreenPropertiesEqual(
    const display::ScreenInfo& prev,
    const display::ScreenInfo& current) {
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

// ========== Web 暴露属性：写死 ==========
int Screen::width() const { return kSpoofedWidth; }
int Screen::height() const { return kSpoofedHeight; }
int Screen::availWidth() const { return kSpoofedWidth; }
int Screen::availHeight() const { return kSpoofedHeight; }
int Screen::availLeft() const { return 0; }
int Screen::availTop() const { return 0; }
unsigned Screen::colorDepth() const { return kSpoofedColorDepth; }
unsigned Screen::pixelDepth() const { return kSpoofedColorDepth; }

// ========== 内部方法：保留，但在 GetRect 上做“对外伪装” ==========
// 说明：不少检测站点显示的“屏幕分辨率”其实来自 Screen::GetRect(false)
// 或其绑定层生成代码的读取结果。因此这里直接返回伪装矩形，
// 以确保所有路径都拿到 888x888。
// 这不会影响页面布局与渲染（它们走的是视口尺寸）。
gfx::Rect Screen::GetRect(bool /*available*/) const {
  // 统一对外伪装：返回固定矩形 (0,0,888,888)
  return gfx::Rect(0, 0, kSpoofedWidth, kSpoofedHeight);
}

// 保留：真实 ScreenInfo 仍可供其它非 Web 暴露逻辑使用
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

// 其它保持原样
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
  // 按真实值返回是否“扩展屏”；与分辨率伪装无关
  return GetScreenInfo().is_extended;
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
