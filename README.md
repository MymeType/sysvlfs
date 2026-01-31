# SYSVinit Linux From Scratch

This book aims to be a community-maintained continuation effort of the SysVinit version of the Linux From Scratch book after [the recent announcement on support being dropped for SysVinit in the next version of the book](https://discord.com/channels/282675835964620800/282677788035514370/1467006939975254201).

## Motive

On 2026-01-31, the following [announcement](https://discord.com/channels/282675835964620800/282677788035514370/1467006939975254201) was posted on the [Linux From Scratch Discord server](https://discordservers.com/server/282675835964620800/view):

> @everyone, there will be a more formal post on the mailing lists about this, but the short of it is for this upcoming stable release, 13.0 (we will not be releasing 12.5), the books will be Systemd-only.
> 
> The original plan was to drop SysVinit in favor of OpenRC, as the main version of LFS, and keep Systemd. We had asked for some feedback earlier about this. We value feedback and the opinions of the community a ton, but as editors, we are stretched thin. Having another init system besides Systemd has been estimated to lead to 300+ hours being spent on the extra revision alone, and this could be an underestimate.
> 
> Because we encounter enough issues that come in the books, we lack proper time, energy, and resources to make another init system alongside Systemd happen. It's not feasible, and will only lead to burnout.
> 
> That being said, we heavily encourage users who want SysVinit or OpenRC to carry the effort, and potentially make forks that are up to date. This support may not be dropped forever. But until we have more helping hands, we are unable to provide the support like we have in the past.
> 
> For security, we will still build packages with security vulnerabilities on SysVinit systems to verify things are in a sane state until 13.1 releases. The architecture of the books are in an uncertain state and what this change will mean for the books. But in time, things will be more clear.
> 
> We're sorry we're cutting support for init systems other than Systemd, but it's something we must do.

As of now, support for building the SysVinit version of the book hasn't been removed from the development branch yet, but when the time comes, this repository will aim to be a soft-fork of the book, pulling in changes from upstream and adapting any needed instructions to work with SysVinit.

## Building

Install the needed packages as detailed in [INSTALL](INSTALL), then run any of the following commands:

### XML to XHTML:

`make BASEDIR=/path/to/output/location`

### XML to single file XHTML (nochunks):

`make BASEDIR=/path/to/output/location nochunks`

### XML to TXT

Follow the instructions for nochunks and then run:
`lynx -dump /path/to/nochunks > /path/to/output`

### XML to PDF

`make BASEDIR=/path/to/output/location pdf`
