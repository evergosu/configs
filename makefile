all:
	stow --verbose --no-folding --restow -t ~ */

delete:
	stow --verbose --delete -t ~ */ && find ~/.config -type d -empty -delete
