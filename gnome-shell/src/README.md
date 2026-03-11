## Summary

Do not edit the CSS directly, edit the source SCSS files and the CSS files
will be generated automatically when building with meson + ninja and left
inside the build directory to be incorporated into the gresource XML (you'll
need to have sassc installed).

## Architecture

Yaru's GNOME Shell theme is built on top of upstream GNOME Shell (Adwaita)
by **symlinking upstream SCSS files** and layering minimal Yaru overrides on
top. This approach minimizes maintenance burden across GNOME releases while
preserving Yaru's distinct visual identity.

### Import order (`gnome-shell.scss.in`)

| Import                     | Description                                                        |
| -------------------------- | ------------------------------------------------------------------ |
| `_@Colors@`                | Upstream color definitions (symlinked)                             |
| `_color-overrides`         | **Yaru** color overrides (accent, success, warning, contrast etc.) |
| `_drawing`                 | Upstream drawing helpers (symlinked)                               |
| `_common`                  | Upstream widget definitions (symlinked)                            |
| `_widgets`                 | Upstream widget partials index (symlinked)                         |
| `widgets/_authd`           | **Yaru/Ubuntu** authd styles (web login, QR code, auth menu)      |
| `_dock`                    | **Yaru** Ubuntu Dock / Dash-to-Dock styling                       |
| `_tweaks`                  | **Yaru** final overrides (loaded last)                             |

### Where to make changes

- **Yaru colors**: Edit `_color-overrides.scss`
- **Yaru visual tweaks**: Edit `_tweaks.scss` (typography, panel, lockscreen, menus)
- **Ubuntu Dock**: Edit `_dock.scss`
- **Ubuntu authd** (web login, QR code): Edit `widgets/_authd.scss`
- **Do NOT edit** symlinked files — those track upstream and are synced periodically

## Design principles

Yaru is different from Adwaita in that it is **sharper and more elegant**:
thinner text, sharper corners, and distinct color choices. The theme should
maintain a good balance between inheriting upstream improvements for reduced
maintenance and preserving Yaru's visual identity.

Key distinctions from Adwaita:
- **Contrast optimization**: Yaru adjusts warning/error/success colors for
  better contrast against their backgrounds
- **Typography**: Thinner font weights referencing Ubuntu/Vanilla Framework
- **Dark panel**: Top panel uses a consistent dark appearance
- **Accent-colored running dots**: App running indicators use the system
  accent color

## Building

You can read about SASS on its [web page][sass-web]. Edit the relevant
`.scss` file, then run `ninja` in your build directory to generate the
final CSS files.

[sass-web]: http://sass-lang.com/documentation/
