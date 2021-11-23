
PACKAGES = backgrounds environment git gnupg gtk-3.0 nvim swaylock terminator waybar wayfire zsh

install:
	stow --no-folding -t ~/ ${PACKAGES}
