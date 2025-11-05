#!/usr/bin/env bash

COMMAND="$1"
COMMAND_FLAG="$2"

rcloneSync() {
  local fromPath="$1"
  local toPath="$2"

  if [ "${COMMAND_FLAG}" = '--apply' ]; then
    echo "Sync: '${fromPath}' -> '${toPath}'"
    rclone sync --progress "${fromPath}" "${toPath}" --exclude desktop.ini
  else
    echo "Sync (dry-run): '${fromPath}' -> '${toPath}'"
    rclone sync --dry-run "${fromPath}" "${toPath}" --exclude desktop.ini
  fi
}

pull() {
  while IFS='' read -r path; do
    [[ "${path}" =~ ^#.*$ || -z "${path}" ]] && continue

    IFS=':' read -r remotePath localPath <<<"${path}"
    local localPath="${localPath/#\~/$HOME}"
    local localPath="${localPath:-${SYNC_DIR}/${remotePath}}"

    rcloneSync "remote:${remotePath}" "${localPath}"
  done <"${SYNC_PATHS}"
}

push() {
  while IFS='' read -r path; do
    [[ "${path}" =~ ^#.*$ || -z "${path}" ]] && continue

    IFS=':' read -r remotePath localPath <<<"${path}"
    local localPath="${localPath/#\~/$HOME}"
    local localPath="${localPath:-${SYNC_DIR}/${remotePath}}"

    if [ ! -e "${localPath}" ]; then
      echo "Skipping missing path: '${localPath}'"
      continue
    fi

    rcloneSync "${localPath}" "remote:${remotePath}"
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
