build:

clean:

install:
	find Suru/[1-9]* Suru/scalable Suru/index.theme -exec \
		install -D -m 644 '{}' /usr/share/icons/'{}' \;

install-local:
	find Suru/[1-9]* Suru/scalable Suru/index.theme -exec \
		install -D '{}' ~/.local/share/icons/'{}' \;

uninstall:
	rm -r /usr/share/icons/Suru

uninstall-local:
	rm -r ~/.local/share/icons/Suru

.PHONY: build clean install install-local uninstall uninstall-local