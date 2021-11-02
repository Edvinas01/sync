#!/usr/bin/env bash

syncPaths='sync-paths.txt'
syncDir="$(pwd)"

echo 'Where would you like to store your files?'
read syncDir

echo 'Cleaning up old sync setup...'
sed -i '/SYNC_WORKDIR/d' ~/.bashrc
sed -i '/SYNC_DIR/d' ~/.bashrc
sed -i '/SYNC_PATHS/d' ~/.bashrc
sed -i '/sync()/d' ~/.bashrc

echo 'Exporting environment variables...'
echo "export SYNC_WORKDIR='$(pwd)'" >>~/.bashrc
echo "export SYNC_DIR='${syncDir}'" >>~/.bashrc
echo "export SYNC_PATHS='$(pwd)/${syncPaths}'" >>~/.bashrc

echo 'Setting up sync command...'
echo "sync() { (cd \"\${SYNC_WORKDIR}\" && ./sync.sh \"\$@\") }" >>~/.bashrc

if [ ! -f "${syncPaths}" ]; then
  echo "Creating ${syncPaths}..."
  echo '# Add paths of directories which should be synced, for example:' >"${syncPaths}"
  echo '# Documents/Work' >>"${syncPaths}"
  echo '# Media/Wallpapers' >>"${syncPaths}"
  echo '# Media/Music' >>"${syncPaths}"
else
  echo "${syncPaths} already exists, skipping..."
fi

source ~/.bashrc
