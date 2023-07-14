symlink:
	stow --verbose --no-folding --restow -t ~ */

clean:
	stow --verbose --delete -t ~ */
	find ~/.config -type d -empty -delete
