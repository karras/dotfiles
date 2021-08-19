
PACKAGES = backgrounds environment git nvim user-dirs waybar wayfire

install:
	stow --no-folding -t ~/ ${PACKAGES}
