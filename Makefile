
PACKAGES = backgrounds environment git nvim terminator user-dirs waybar wayfire zsh

install:
	stow --no-folding -t ~/ ${PACKAGES}
