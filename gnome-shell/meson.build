gnomeshell_use_gresource = get_option('gnome-shell-gresource')
gnomeshell_user_themes_suport = get_option('gnome-shell-user-themes-support')
gnomeshell_user_themes_suport = gnomeshell_user_themes_suport.disable_auto_if(
    gnomeshell_use_gresource)
gnomeshell_default_theme_dir = join_paths(get_option('datadir'), 'gnome-shell', 'theme')
gnomeshell_alt_themes_dir = join_paths(get_option('datadir'), 'themes')
gresources_xml_parser = find_program('gresources-xml-parser.py')

subdir('src')
