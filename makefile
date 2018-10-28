.PHONY: link unlink

link:
	ln -s $(PWD)/awesome $(HOME)/.config/awesome

unlink:
	unlink $(HOME)/.config/awesome
