#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MANIFEST="$ROOT/manifest.json"

# 解析 manifest（保持你现有的 grep -oP 写法）
linux_root=$(grep -oP '"linux_root"\s*:\s*"\K[^"]+' "$MANIFEST")
windows_root=$(grep -oP '"windows_root"\s*:\s*"\K[^"]+' "$MANIFEST")
dry_run_flag=$(grep -oP '"dry_run"\s*:\s*\K(true|false)' "$MANIFEST")

# 选择目标根路径
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

# 占位保护：若仍是占位文件则退出
if grep -q "OVERLAY_PLACEHOLDER_DO_NOT_APPLY" \
  "$SRC_DIR/third_party/blink/renderer/core/frame/screen.cc" 2>/dev/null; then
  echo "[guard] screen.cc is placeholder. Replace with branch-matched implementation before applying."
  exit 1
fi

# 覆盖复制
for f in "${FILES[@]}"; do
  src="$SRC_DIR/$f"
  dst="$TARGET_ROOT/$f"
  [[ -f "$src" ]] || { echo "[err] missing: $src"; exit 2; }
  echo "[copy] $f"
  if [[ "$dry_run_flag" == "false" ]]; then
    mkdir -p "$(dirname "$dst")"
    cp -f "$src" "$dst"
  fi
done

echo "[done]"