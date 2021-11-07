
PACKAGES = backgrounds environment git gnupg gtk-3.0 nvim terminator user-dirs waybar wayfire zsh

install:
	stow --no-folding -t ~/ ${PACKAGES}
