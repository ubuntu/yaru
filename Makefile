GETTEXT_DOMAIN=suru-icon-theme

build:
	echo "Nothing to build"

clean:
	echo "Nothing to clean"

install:
	find Suru/[1-9]* Suru/scalable Suru/index.theme -exec \
		install -D -m 644 '{}' /usr/share/icons/'{}' \;

uninstall:
	find /usr/share/icons/Suru -exec \
		rm -r '{}' \;

.PHONY: build clean install uninstall