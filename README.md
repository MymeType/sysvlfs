# SYSVinit Linux From Scratch

This book aims to be a community-maintained continuation effort of the SysVinit version of the Linux From Scratch book after [the recent announcement on support being dropped for SysVinit in the next version of the book](https://discord.com/channels/282675835964620800/282677788035514370/1467006939975254201). **WORK IN PROGRESS!**

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

On 2026-02-02, the following email was sent to the LFS mailing lists:

> With some regret, LFS/BLFS will no longer be developing the System V versions
of the books.
>
> There are two reasons for this decision. The first reason is workload. No one working on LFS is paid. We rely completely on volunteers. In LFS there are 88 packages. In BLFS there are over 1000. The volume of changes from upstream is overwhelming the editors.  In this release cycle that started on the 1st of September until now, there have been 70 commits to LFS and 1155 commits to BLFS (and counting). When making package updates, many packages need to be checked for both System V and systemd. When preparing for release, all packages need to be checked for each init system.
>
> The second reason for dropping System V is that packages like GNOME and soon KDE's Plasma are building in requirements that require capabilities in systemd that are not in System V. This could potentially be worked around with another init system like OpenRC, but beyond the transition process it still does not address the ongoing workload problem.
>
> In the future, the LFS/BLFS 12.4 System V books will continue to be available. For the most part newer versions of packages in those books will be able to be built with the instructions from there, but will not be tested by the LFS editors.
>
> The next version of LFS/BLFS will be version 13.0 and is currently has a target release data of March 1st.
>
> As a personal note, I do not like this decision. To me LFS is about learning how a system works. Understanding the boot process is a big part of that. systemd is about 1678 "C" files plus many data files.  System V is "22" C files plus about 50 short bash scripts and data files. Yes, systemd provides a lot of capabilities, but we will be losing some things I consider important.
>
> However, the decision needs to be made.

As of now, support for building the SysVinit version of the book hasn't been removed from the development branch yet, but when the time comes, this repository will aim to be a soft-fork of the book, pulling in changes from upstream and adapting any needed instructions to work with SysVinit.

## Building

Install the needed packages as detailed in [INSTALL.md](INSTALL.md), then run the following commands:

```bash
make
make install INSTALLDIR=/path/to/output/location
```

## Support

Contact me (@mymetype) on the [Linux From Scratch Discord server](https://discordservers.com/server/282675835964620800/view) if you have any questions about the book.

## Licensing

The text in this book is licensed under [CC BY-NC-SA 2.0](LICENSE.TEXT).

Code snippets in this book are licensed under the [MIT license](LICENSE).
