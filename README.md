# Dotfiles

Nothing special, simply my dotfiles for everyday use.

## Features

The following configurations are covered:

* Background images
* Environment variables
* Git
* GNUPG
* Greetd
* GTK 3.0
* Neovim
* Swaylock
* Terminator
* Waybar
* Wayfire
* XDG user directories
* ZSH

## Structure

The structure and placement of all files is heavily inspired by [Ayekat's
dotfiles approach](https://github.com/ayekat/dotfiles), kudos to him!

### XDG Paths

| Variable          | Location                 |
| ----------------- | ------------------------ |
| `XDG_CACHE_HOME`  | `$HOME/.local/var/cache` |
| `XDG_CONFIG_HOME` | `$HOME/.local/etc`       |
| `XDG_DATA_HOME`   | `$HOME/.local/share`     |
| `XDG_STATE_HOME`  | `$HOME/.local/var/lib`   |

## Styling

Whenever possible the [Nord theme](https://www.nordtheme.com/) is applied.

## Installation

* Clone this repository to the destination of your choice (e.g.
  `~/git/dotfiles`)

* Install all dotfiles, make sure the `~/.local` directory is removed first:

  ```sh
  cd ~
  ln -s /path/to/this/repo .local
  ```
