DISTCHECK_CONFIGURE_FLAGS = --disable-icon-mapping

SUBDIRS = Suru

theme_in_files = index.theme.in.in
theme_DATA = $(theme_in_files:.theme.in.in=.theme)

THEME_DIRS=$(shell \
			SIZES="$(ICON_SIZES)"; \
			for size in $$SIZES; \
				do for dir in `find $(SRCDIR)/$(THEME)/$$size/* -type d`; do \
					printf "$$dir,"; \
				done; \
			done; \
			SIZES="$(HIDPI_ICON_SIZES)"; \
			for size in $$SIZES; \
				do for dir in `find $(SRCDIR)/$(THEME)/$$size/* -type d`; do \
					printf "$$dir,"; \
				done; \
			done; \
			echo "scalable/actions,scalable/animations,scalable/apps,scalable/categories,scalable/devices,scalable/emblems,scalable/emotes,scalable/mimetypes,scalable/places,scalable/status")

%.theme.in: %.theme.in.in $(THEME) Makefile
	dirs="`echo $(THEME_DIRS) | sed -e 's#$(SRCDIR)/$(THEME)/##g'`"; \
	sed -e "s|\@THEME_DIRS\@|$$dirs|g" < $< > $@; \
	for dir in `echo $$dirs | sed -e "s/,/ /g"`; do \
		sizefull="`dirname $$dir`"; \
		if test "$$sizefull" = "scalable"; then \
			size="16"; \
		else \
			size="`echo $$sizefull | sed -e 's/x.*$$//g'`"; \
		fi; \
		context="`basename $$dir`"; \
		echo "[$$dir]" >> $@; \
		if test "$$context" = "actions"; then \
			echo "Context=Actions" >> $@; \
		fi; \
		if test "$$context" = "animations"; then \
			echo "Context=Animations" >> $@; \
		fi; \
		if test "$$context" = "apps"; then \
			echo "Context=Applications" >> $@; \
		fi; \
		if test "$$context" = "categories"; then \
			echo "Context=Categories" >> $@; \
		fi; \
		if test "$$context" = "devices"; then \
			echo "Context=Devices" >> $@; \
		fi; \
		if test "$$context" = "emblems"; then \
			echo "Context=Emblems" >> $@; \
		fi; \
		if test "$$context" = "emotes"; then \
			echo "Context=Emotes" >> $@; \
		fi; \
		if test "$$context" = "mimetypes"; then \
			echo "Context=MimeTypes" >> $@; \
		fi; \
		if test "$$context" = "places"; then \
			echo "Context=Places" >> $@; \
		fi; \
		if test "$$context" = "status"; then \
			echo "Context=Status" >> $@; \
		fi; \
		echo "Size=$$size" >> $@; \
		if test "$$sizefull" = "scalable"; then \
			echo "MinSize=8" >> $@; \
			echo "MaxSize=512" >> $@; \
			echo "Type=Scalable" >> $@; \
		elif test "$$size" = "256"; then \
			echo "MinSize=56" >> $@; \
			echo "MaxSize=512" >> $@; \
			echo "Type=Scalable" >> $@; \
		else \
			echo "Type=Fixed" >> $@; \
		fi; \
		echo "" >> $@; \
	done

@INTLTOOL_THEME_RULE@

# we don't want to install mo files, all translations are already stored
# in theme files
install-data-local:
	$(MAKE) -C po uninstall
	if [ -h $(DESTDIR)$(themedir) ]; then \
		rm -f $(DESTDIR)$(themedir); \
	fi
	if [ -d $(DESTDIR)$(themedir) ]; then \
		touch $(DESTDIR)$(themedir); \
	fi

EXTRA_DIST = \
	autogen.sh \
	mate \
	menta \
	$(theme_in_files)

CLEANFILES = \
	$(theme_DATA)

MAINTAINERCLEANFILES = \
	Makefile.in \
	aclocal.m4 \
	config.guess \
	config.h.in \
	config.sub \
	configure \
	depcomp \
	install-sh \
	intltool-*.in \
	libtool \
	ltmain.sh \
	missing \
	mkinstalldirs \
	po/Makefile.in.in \
	po/$(GETTEXT_PACKAGE).pot

# Build ChangeLog from GIT  history
ChangeLog:
	$(AM_V_GEN) if test -d $(top_SRCDIR)/.git; then \
		GIT_DIR="$(top_SRCDIR)/.git" git log --stat > $@; \
	fi

dist: ChangeLog

.PHONY: ChangeLog

