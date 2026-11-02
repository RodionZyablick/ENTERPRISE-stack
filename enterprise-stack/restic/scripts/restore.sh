#!/bin/sh
set -e

echo "Available snapshots:"
restic snapshots

echo "Enter snapshot ID to restore (or 'latest'):"
read SNAPSHOT_ID

restic restore "${SNAPSHOT_ID}" --target /restore

echo "Restore completed to /restore"