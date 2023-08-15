sync: symlink clean-bogus clean-dirs

delete: clean-links clean-bogus clean-dirs

symlink:
	stow --verbose --no-folding --restow -t ~ */

clean-links:
	stow --verbose --delete -t ~ */

clean-bogus:
	chkstow -b -t ~/.config/ | sed 's/\Bogus link: //' | xargs -n 1 unlink

clean-dirs:
	find ~/.config -type d -empty -delete
