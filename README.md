# Dotfiles

Nothing special, simply my dotfiles for everyday use.

## Structure

The main goal is to keep the home directory as clean as possible by forcing
*everything* to be stored in `~/.local`. I would **not recommend** to use it as
a plug'n play setup!

The structure and placement of all files is heavily inspired by the awesome
[Ayekat](https://github.com/ayekat/localdir)!

### XDG Paths

The [XDG base
directories](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
are customized as follows:

| Variable          | Location                 |
| ----------------- | ------------------------ |
| `XDG_CACHE_HOME`  | `$HOME/.local/var/cache` |
| `XDG_CONFIG_HOME` | `$HOME/.local/etc`       |
| `XDG_DATA_HOME`   | `$HOME/.local/share`     |
| `XDG_STATE_HOME`  | `$HOME/.local/var/lib`   |

Also `PATH` is extended by the below paths:

| Path               | Purpose                     |
| ------------------ | --------------------------- |
| `$HOME/.local/bin` | Custom scripts and wrappers |

Most [wrapper scripts](./local/bin) are required for those applications which
do not support custom XDG paths (e.g. Ansible or Firefox).

### Private Configs

Files and configs that may differ between work and home devices and should not
be published are located in `$HOME/.local/var/lib/private`.

Tools like git or ZSH will fetch additional settings from there as needed.

## Dependencies

Due to the deprecation of
[pam\_env](https://github.com/linux-pam/linux-pam/releases/tag/v1.5.0) it
heavily depends on the chosen login flow (i.e. headless, Wayland-based, etc.)
how to ideally inject the necessary environment variables. There is often a
chicken and egg problem related to `XDG_CONFIG_HOME` as its customization must
be injected as early as possible, otherwise the systemd user variables are not
loaded either.

In this case the problem is solved (read "glued and hacked together") via a
separate `wayfire-run` wrapper script which loads all environment variables and
then finally starts Wayfire. The login flow looks like this:

```text
Boot
--> greetd
    --> greetd-gtkgreet
        --> wayfire-run
            --> wayfire
```

The [wayfire-run
script](https://github.com/karras/ansible-collection-workstation/tree/main/roles/wayfire)
is deployed and managed via Ansible.

## Components

Whenever possible only GTK-based (3.0+) applications are used and the overall
application bloat should be kept at a minimum. Also, when configurable, the
awesome [Nord theme](https://www.nordtheme.com/) is applied.

Below is an incomplete list of the covered main components:

* User
  - [Environment & XDG](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
  - [Neovim](https://github.com/neovim/neovim)
  - [Terminator](https://github.com/gnome-terminator/terminator)
  - [ZSH](https://www.zsh.org/)
* Desktop
  - [bemenu](https://github.com/Cloudef/bemenu)
  - [greetd-gtkgreet](https://git.sr.ht/~kennylevinsen/gtkgreet)
  - [mako](https://github.com/emersion/mako)
  - [Wayfire](https://github.com/WayfireWM/wayfire)
  - [Waybar](https://github.com/Alexays/Waybar)
  - [swaylock](https://github.com/swaywm/swaylock)
  - [swaybg](https://github.com/swaywm/swaybg)
  - [swayidle](https://github.com/swaywm/swayidle)

## Installation

* Clone this repository to the destination of your choice (e.g.
  `~/git/dotfiles`)

* Ensure you have injected at least the above mentioned XDG variables into the
  environment

* Install all dotfiles, make sure the `~/.local` directory is removed first:

  ```sh
  cd ~
  ln -s /path/to/this/repo .local
  ```

* Copy your desktop wallpaper to `~/.local/share/backgrounds/wallpaper.png`,
  which will be used by `swaybg`

* Copy your lock screen wallpaper to
  `~/.local/share/backgrounds/wallpaper_lockscreen.png`, which will be used by
  `swaylock`
