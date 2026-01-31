# SYSVinit Linux From Scratch

This book is a continuation effort of the sysvinit version of the Linux From Scratch book after [the recent announcement on support being dropped for sysvinit in the next version of the book](https://discord.com/channels/282675835964620800/282677788035514370/1467006939975254201).

## Building

### XML to XHTML:

`make BASEDIR=/path/to/output/location`

### XML to single file XHTML (nochunks):

`make BASEDIR=/path/to/output/location nochunks`

### XML to TXT

Follow the instructions for nochunks and then run:
`lynx -dump /path/to/nochunks > /path/to/output`

### XML to PDF

`make BASEDIR=/path/to/output/location pdf`
