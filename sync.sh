#!/usr/bin/env bash

COMMAND="$1"
COMMAND_FLAG="$2"

rcloneSync() {
  local fromPath="$1"
  local toPath="$2"

  echo "Sync from: ${fromPath}, to: ${toPath}"
  if [ "${COMMAND_FLAG}" = '--apply' ]; then
    rclone sync --progress "${fromPath}" "${toPath}" --exclude desktop.ini
  else
    rclone sync --dry-run "${fromPath}" "${toPath}" --exclude desktop.ini
  fi
}

pull() {
  while IFS='' read -r path; do
    [[ "${path}" =~ ^#.*$ ]] && continue

    rcloneSync "remote:${path}" "${SYNC_DIR}/${path}"
  done <"${SYNC_PATHS}"
}

push() {
  while IFS='' read -r path; do
    [[ "${path}" =~ ^#.*$ ]] && continue

    rcloneSync "${SYNC_DIR}/${path}" "remote:${path}"
  done <"${SYNC_PATHS}"
}

case "${COMMAND}" in
'pull')
  pull
  ;;

'push')
  push
  ;;

*)
  echo 'Usage:'
  echo 'sync pull [--apply]'
  echo 'sync push [--apply]'
  ;;
esac
