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

[Rclone]: https://github.com/rclone/rclone
