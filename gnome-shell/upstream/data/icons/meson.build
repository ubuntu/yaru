excluded_icons=[]
if not have_portal_helper
  excluded_icons += [
    'scalable/apps/org.gnome.Shell.CaptivePortal.svg',
    'symbolic/apps/org.gnome.Shell.CaptivePortal-symbolic.svg',
  ]
endif
install_subdir('hicolor',
  install_dir: icondir, exclude_files: excluded_icons)
