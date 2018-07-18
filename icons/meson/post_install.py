#!/usr/bin/env python3

from contextlib import suppress
from os import environ, path
from subprocess import call
import sys

project_name = 'Suru'
with suppress(IndexError):
    project_name = sys.argv[1]

if not environ.get('DESTDIR', ''):
    PREFIX = environ.get('MESON_INSTALL_PREFIX', '/usr')
    print('Updating icon cache...')
    call(['gtk-update-icon-cache', '-qtf', path.join(PREFIX, 'share/icons', project_name)])
