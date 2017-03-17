# gopro-video-backup
Basic ruby script for backing up video from one directory to another

This ruby script uses `fileutils` to check which video files need to be copied to the backup directory, it is also currently set to limit the source directory size to 53gb, if the backup directory does not have space for the new files, old files are deleted until there is space.

#Warning
This is a destructive script, and will delete old files when needed without prompt!

# usage
`ruby brap.rb /Volumes/from/directory/ /Volumes/to/directory/`

#output
```
## Backing up videos from /Volumes/from/directory/ to /Volumes/to/directory/
## Figuring out which files need copying
GOPR5478.MP4 needs copying
GOPR5479.MP4 needs copying
GOPR5480.MP4 needs copying
GOPR5481.MP4 needs copying
## Seeing if there is enough space in the source directory
We need to make space for new files
## Deleting oldest files until there is enough space
Deleting GOPR5288.MP4
Deleting GP015288.MP4
Deleting GOPR5289.MP4
Deleting GP015289.MP4
Deleting GOPR5290.MP4
Deleting GP015290.MP4
Deleting GOPR5291.MP4
Deleting GP015291.MP4
Deleting GOPR5292.MP4
Deleting GOPR5293.MP4
Deleting GOPR5294.MP4
Deleting GOPR5295.MP4
Deleting GOPR5296.MP4
Deleting GOPR5297.MP4
## Copying new files to source directory
Copying GOPR5478.MP4
Copying GOPR5479.MP4
Copying GOPR5480.MP4
Copying GOPR5481.MP4
## DONE
```
