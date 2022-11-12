copy:
	cp -ar home/* ${HOME}/
	sudo cp -ar root/* /

symlink:
	stow -t ${HOME} home
	sudo stow -t / root
