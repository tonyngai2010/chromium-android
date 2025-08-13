#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MANIFEST="$ROOT/manifest.json"

linux_root=$(grep -oP '"linux_root"\s*:\s*"\K[^"]+' "$MANIFEST")
windows_root=$(grep -oP '"windows_root"\s*:\s*"\K[^"]+' "$MANIFEST")

if [[ "$OS" == "Windows_NT" || "$(uname -s)" =~ MINGW|MSYS|CYGWIN ]]; then
  TARGET_ROOT="$windows_root"
else
  TARGET_ROOT="$linux_root"
fi
TARGET_ROOT="${TARGET_ROOT/#\~/$HOME}"

FILES=(
  "third_party/blink/renderer/core/frame/screen.cc"
)

for f in "${FILES[@]}"; do
  dst="$TARGET_ROOT/$f"
  if git -C "$TARGET_ROOT" ls-files --error-unmatch "$f" >/dev/null 2>&1; then
    echo "[restore] $f"
    git -C "$TARGET_ROOT" checkout -- "$f"
  else
    echo "[skip] $f not tracked by git"
  fi
done

echo "[done]"
