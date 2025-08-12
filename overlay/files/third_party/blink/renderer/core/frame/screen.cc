// overlay: minimal spoof for JS-facing Screen getters only.
// This file replaces the original screen.cc so that JS `screen.*`
// returns spoofed values without touching layout viewport.
//
// IMPORTANT: Does NOT modify innerWidth/innerHeight or ScreenInfo.
// Only Blink::Screen getters for JS are overridden.

#include "third_party/blink/renderer/core/frame/screen.h"

namespace blink {

int Screen::width() const {
  return 1776;  // spoofed
}

int Screen::height() const {
  return 1776;  // spoofed
}

int Screen::availWidth() const {
  return 888;   // spoofed
}

int Screen::availHeight() const {
  return 840;   // spoofed
}

int Screen::colorDepth() const {
  return 24;    // spoofed
}

int Screen::pixelDepth() const {
  return 24;    // spoofed
}

}  // namespace blink