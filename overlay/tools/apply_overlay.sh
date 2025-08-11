#!/usr/bin/env bash
set -euo pipefail
SRC_ROOT="${SRC_ROOT:-$PWD}"
OVERLAY_DIR="${OVERLAY_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"

echo ">>> Using SRC_ROOT=$SRC_ROOT"
test -d "$SRC_ROOT/ui" || { echo "Please set SRC_ROOT to chromium/src"; exit 1; }

# copy files with backup
BACKUP_DIR="$SRC_ROOT/.overlay_backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
python3 - <<'PY'
import os,shutil,hashlib,json,sys
src=os.environ["SRC_ROOT"]
ovl=os.path.realpath(os.path.join(os.path.dirname(__file__),".."))
mf=os.path.join(ovl,"manifest.json")
data=json.load(open(mf,"r",encoding="utf-8"))
files=data.get("files",[])
bkp=os.path.join(src, ".overlay_backups", os.popen("date +%Y%m%d_%H%M%S").read().strip())
for it in files:
    rel=it["path"]
    dst=os.path.join(src,rel)
    src_new=os.path.join(ovl,"files",rel)
    os.makedirs(os.path.dirname(dst),exist_ok=True)
    if os.path.exists(dst):
        os.makedirs(os.path.join(bkp,os.path.dirname(rel)),exist_ok=True)
        shutil.copy2(dst, os.path.join(bkp,rel))
    shutil.copy2(src_new, dst)
    print("[OK]", rel)
print("[BACKUP]", bkp)
PY

echo ">>> Files overlay completed (no build)"
echo ">>> DONE"

