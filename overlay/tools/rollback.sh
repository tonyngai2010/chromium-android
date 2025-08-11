#!/usr/bin/env bash
set -euo pipefail
SRC_ROOT="${SRC_ROOT:-$PWD}"
BACKUP_DIR="${1:-$SRC_ROOT/.overlay_backups/latest}"
test -d "$BACKUP_DIR" || { echo "Backup dir not found: $BACKUP_DIR"; exit 1; }
rsync -a "$BACKUP_DIR"/ "$SRC_ROOT"/
echo ">>> Rolled back to $BACKUP_DIR"