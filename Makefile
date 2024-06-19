sync: symlink-manual symlink-stow clean-bogus clean-dirs

delete: clean-links clean-bogus clean-dirs

symlink-stow:
	stow --verbose --no-folding --restow -t ~ */ --ignore=fzf_key_bindings\.fish

symlink-manual: clean-manual copy-manual

copy-manual:
	cp -P ~/projects/configs/fish/.config/fish/functions/fzf_key_bindings.fish ~/.config/fish/functions/

clean-links: clean-manual clean-stow

clean-stow:
	stow --verbose --delete -t ~ */

clean-manual:
	rm -f ~/.config/fish/functions/fzf_key_bindings.fish

clean-bogus:
	chkstow -b -t ~/.config/ | sed 's/\Bogus link: //' | xargs -n 1 unlink

clean-dirs:
	find ~/.config -type d -empty -delete
