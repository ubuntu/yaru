# Create a Yaru GTK Variant

As step 0 you should decide which base to use. Using the Light variant as base will generate a gtk flavour with bright headerbars, using the Default variant a gtk flavour with dark headerbars, and using the Dark variant a dark flavour.

Let's say we want a Blue Yaru variant from Default.

1. Clone gtk/src/default folder into gtk/src/blue
    ```
    $ cp -r gtk/src/default gtk/src/blue
    ```
2. Adjust some colors to show a minimal difference from the Base variant used. As example change `$accent_bg_color` and `$accent_fg_color` to `$blue` and `$inkstone`
3. Configure the build
    1. Add a new option in `meson_options.txt`. If value is "true", it will be built automatically
        ```
        diff --git a/meson_options.txt b/meson_options.txt
        index 4412c2f3..c1e84234 100644
        --- a/meson_options.txt
        +++ b/meson_options.txt
        @@ -11,3 +11,6 @@
        option('default', type: 'boolean', value: true, description:'build Yaru gtk default flavour')
        option('dark', type: 'boolean', value: true, description:'build Yaru gtk dark flavour')
        option('ubuntu-unity', type: 'boolean', value: false, description:'build Yaru with Unity assets')
        +option('blue', type: 'boolean', value: true, description:'build Yaru gtk blue flavour')
        ```
    2. Add the new variant name to `gtk/meson.build`
        ```
        diff --git a/gtk/meson.build b/gtk/meson.build
        index cc51bf0d..9c66fa99 100644
        --- a/gtk/meson.build
        +++ b/gtk/meson.build
        @@ -1,5 +1,5 @@
        flavours = []
        -foreach flavour: ['default', 'dark']
        +foreach flavour: ['default', 'dark', 'blue']
        if not get_option(flavour)
            message('skip flavour ' + flavour)
            continue
        ```
4. Build Yaru. If a build directory already exists, run first `$ meson build --reconfigure` or simply remove the old build directory.
    ```
    $ meson builddir
    $ meson compile -C builddir
    $ meson install -C builddir
    ```

Note that this process creates both the `gtk-3.0/gtk.css` and  `gtk-3.0/gtk-dark.css` files, the latter is needed for Applications that have "prefer dark" option set.
