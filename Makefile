
PACKAGES = backgrounds environment git nvim user-dirs waybar wayfire zsh

install:
	stow --no-folding -t ~/ ${PACKAGES}
