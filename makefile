.PHONY: link unlink

link:
	ln -s $(CURDIR)/awesome $(HOME)/.config/awesome

unlink:
	unlink $(HOME)/.config/awesome
