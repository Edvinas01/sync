# sync
[Rclone] wrapper which allows to conveniently pull and push files. The main purpose of this tool is to be a replacement for the horrible Google Drive client, however it should work with other storage providers as well.

## Setup
- Make sure [Rclone] is installed and setup using `rclone config`.
- Clone this repo.
- Run `setup.sh`.

## Usage
Add paths which you'd like to be tracked into `sync-paths.txt`, for example:
```text
Documents/Work
Media/Wallpapers
Media/Music
```

Check which files need to be updated locally:
```bash
sync pull
```

Update files locally:
```bash
sync pull --apply
```

Check which files need to be updated on the cloud:
```bash
sync push
```

Update files on the cloud:
```bash
sync push --apply
```

## Extras

If you're using [Git Bash] with Windows and want to automatically `sync` on startup, create `auto-sync.sh` file at `C:\Users\YOUR_USER\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup` (replace `YOUR_USER` with your username) with the following contents:
```bash
sync pull --apply
echo 'Sync complete...'
sleep 5
```

[Rclone]: https://github.com/rclone/rclone
[Git Bash]: https://git-scm.com/downloads
