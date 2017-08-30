dnl Process this file with autoconf to produce a configure script.
AC_PREREQ(2.53)

AC_INIT([suru-icon-theme], [0.1], [https://snwh.org/suru])
AC_CONFIG_SRCDIR([index.theme.in.in])

AM_INIT_AUTOMAKE([1.9 tar-ustar dist-xz no-dist-gzip foreign check-news])

PKG_PROG_PKG_CONFIG([0.19])
IT_PROG_INTLTOOL([0.40.0])

GETTEXT_PACKAGE="${PACKAGE}"
AC_SUBST(GETTEXT_PACKAGE)
localedir='$(datadir)/locale'
AC_SUBST(localedir)

# Workaround to make aclocal get the right flags
AC_SUBST(ACLOCAL_AMFLAGS, "\${ACLOCAL_FLAGS}")

# Define the toplevel path here
AC_SUBST(themedir, "\${datadir}/icons/Suru")

# Input and Output dirs for the rendering
AC_SUBST(THEME, "Suru")

# Icon sizes we want to install
AC_SUBST([ICON_SIZES], ["16x16 24x24 32x32 48x48 256x256"])
AC_SUBST([HIDPI_ICON_SIZES], ["16x16@2x 24x24@2x 32x32@2x 48x48@2x 256x256@2x"])

# Allow icon mapping to be disabled
AC_ARG_ENABLE([icon-mapping], AC_HELP_STRING([--enable-icon-mapping],[Enable compatibility symlinks [default=auto]]),[enable_mapping=$enableval],[enable_mapping=yes])

ICONMAP="true"
if test "x$enable_mapping" != "xno"; then
	UTILS_REQUIRED=0.8.7

	AC_MSG_CHECKING([icon-naming-utils >= $UTILS_REQUIRED])
	PKG_CHECK_EXISTS(icon-naming-utils >= $UTILS_REQUIRED,
					have_utils=yes, have_utils=no)
	if test "x$have_utils" = "xyes"; then
		UTILS_PATH="`$PKG_CONFIG --variable=program_path icon-naming-utils`"
		ICONMAP="$UTILS_PATH/icon-name-mapping"
		AC_MSG_RESULT([yes])
	else
		AC_MSG_RESULT([no])
		AC_MSG_ERROR([icon-naming-utils >= $UTILS_REQUIRED is required to buildand install suru-icon-theme])
	fi
else
	ICONMAP="false"
fi

AC_SUBST(ICONMAP)

AC_CONFIG_FILES([
Makefile
src/Makefile
Suru/Makefile
Suru/scalable/Makefile
])

AC_OUTPUT
