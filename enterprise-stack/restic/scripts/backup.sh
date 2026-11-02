#!/bin/sh
set -e

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting backup..."

restic snapshots >/dev/null 2>&1 || restic init

restic backup /backup \
  --tag automated \
  --exclude-caches \
  --exclude '*.tmp' \
  --exclude '*.log'

restic forget \
  --keep-daily 7 \
  --keep-weekly 4 \
  --keep-monthly 6 \
  --prune

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup completed successfully."