#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MANIFEST="$ROOT/manifest.json"

linux_root=$(grep -oP '"linux_root"\s*:\s*"\K[^"]+' "$MANIFEST")
windows_root=$(grep -oP '"windows_root"\s*:\s*"\K[^"]+' "$MANIFEST")
dry_run_flag=$(grep -oP '"dry_run"\s*:\s*\K(true|false)' "$MANIFEST")

if [[ "$OS" == "Windows_NT" || "$(uname -s)" =~ MINGW|MSYS|CYGWIN ]]; then
  TARGET_ROOT="$windows_root"
else
  TARGET_ROOT="$linux_root"
fi
TARGET_ROOT="${TARGET_ROOT/#\~/$HOME}"

echo "[overlay] target root: $TARGET_ROOT"
echo "[overlay] dry_run: $dry_run_flag"

SRC_DIR="$ROOT/files"
FILES=(
  "third_party/blink/renderer/core/frame/screen.cc"
)

# 安全保护：若 screen.cc 仍是占位版，则拒绝复制，避免误编译失败
if grep -q "OVERLAY_PLACEHOLDER_DO_NOT_APPLY" "$SRC_DIR/third_party/blink/renderer/core/frame/screen.cc"; then
  echo "[guard] screen.cc is placeholder. Replace with branch-matched implementation before applying."
  exit 1
fi

for f in "${FILES[@]}"; do
  src="$SRC_DIR/$f"
  dst="$TARGET_ROOT/$f"
  echo "[copy] $f"
  if [[ "$dry_run_flag" == "false" ]]; then
    mkdir -p "$(dirname "$dst")"
    install -m 0644 "$src" "$dst"
  fi
done

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi

echo "[done]"
if [[ "${1:-}" == "--build" ]]; then
  echo "[build] autoninja -C \"$TARGET_ROOT/out/Default\" chrome_public_apk"
  autoninja -C "$TARGET_ROOT/out/Default" chrome_public_apk
fi