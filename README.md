# Dotfiles

Nothing special, simply my dotfiles for everyday use.

## Structure

The structure and placement of all files is heavily inspired by the mighty and
awesome [Ayekat](https://github.com/ayekat/dotfiles)!

Basically the main goal is to keep the home directory as clean as possible. I
would **not recommend** to use it as a plug'n play setup!

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

Also the `PATH` is extended by the below paths:

| Path               | Purpose                     |
| ------------------ | --------------------------- |
| `$HOME/.local/bin` | Custom scripts and wrappers |

## Dependencies

Due to the deprecation of
[pam\_env](https://github.com/linux-pam/linux-pam/releases/tag/v1.5.0) it
heavily depends on the chosen login flow (i.e. headless, Wayland-based, etc.)
how to ideally inject the necessary environment variables. There is often a
chicken and egg problem related to `XDG_CONFIG_HOME` as its customization must
be injected as early as possible otherwise the systemd user variables are not
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

## Components

Whenever possible only GTK-based (3.0+) applications are used and the overall
application bloat should be kept at a minimum. Also when configurable the
awesome [Nord theme](https://www.nordtheme.com/) is applied.

Below is an incomplete list of the covered main components:

* User
  - [Environment & XDG](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
  - [Neovim](https://github.com/neovim/neovim)
  - [Terminator](https://github.com/gnome-terminator/terminator)
  - [ZSH](https://www.zsh.org/)
* Desktop
  - [Greetd-gtkgreet](https://git.sr.ht/~kennylevinsen/gtkgreet)
  - [Wayfire](https://github.com/WayfireWM/wayfire)
  - [Waybar](https://github.com/Alexays/Waybar)
  - [Swaylock](https://github.com/swaywm/swaylock)
  - [Swaybg](https://github.com/swaywm/swaybg)
  - [Swayidle](https://github.com/swaywm/swayidle)

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
