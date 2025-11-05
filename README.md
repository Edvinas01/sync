# sync

[Rclone] wrapper which allows to conveniently pull and push files. The main purpose of this tool is to be a replacement for the horrible Google Drive client, however it should work with other storage providers as well.

## Setup

- Make sure [Rclone] is installed and setup using `rclone config` (set the name of your remote to `remote` when configuring).
- Clone this repo.
- Run `setup.sh`.

## Usage

Add paths which you'd like to be tracked into `sync-paths.txt`, for example:

```text
Documents/Work
Media/Wallpapers
Media/Music

# Override sync-dir configured in setup.sh just for this one dir
Media/Selfies:~/Desktop/Selfies
```

Check which files need to be updated locally:

```sh
sync pull
```

Update files locally:

```sh
sync pull --apply
```

Check which files need to be updated on the cloud:

```sh
sync push
```

Update files on the cloud:

```sh
sync push --apply
```

## Extras

If you're using [Git Bash] with Windows and want to automatically `sync` on startup, create `auto-sync.sh` file at `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup` with the following contents:

```sh
sync pull --apply
echo 'Sync complete...'
sleep 5
```

[Rclone]: https://github.com/rclone/rclone
[Git Bash]: https://git-scm.com/downloads
