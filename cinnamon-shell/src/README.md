# Cinnamon Shell Theme – Source Module (`cinnamon-shell/src`)

## 1. Module Identity
This directory contains everything needed to **build and install the Cinnamon‑shell variant of the Yaru theme**:
- **SCSS source files** (`_colors.scss`, `_common.scss`, `_drawing.scss`, `_palette.scss`, `_tweaks.scss`) that are compiled into CSS by the Meson + Ninja build chain.
- **Asset collections** (SVGs) under `assets/colorable‑assets/` and `assets/common‑assets/` that are packaged into the theme’s gresource.
- A **post‑install helper script** (`post_install.py`) that finalises the installation layout by renaming the generated CSS file to the name expected by Cinnamon.

The module does **not** contain runtime code for the desktop environment; it only prepares static theme resources.

---

## 2. Interface Contract
### `post_install.py` – Command‑line contract
```text
Usage: post_install.py <data_dir> <project_name> [flavour …]
```
| Parameter | Description |
|-----------|-------------|
| `data_dir` | Relative path inside the installation prefix where theme data are placed (e.g. `share` for `/usr/share`). |
| `project_name` | Base name of the theme package (normally `yaru`). |
| `flavour` (optional, repeatable) | Additional flavour identifiers (e.g. `dark`, `light`). The special value `default` maps to the base project name. |

**Behaviour**
1. Resolve the installation prefix from the environment variable `MESON_INSTALL_DESTDIR_PREFIX` (defaults to `/usr`).
2. Build the absolute path to the themes directory: `<PREFIX>/<data_dir>/themes`.
3. For each flavour:
   - Determine the directory name: `project_name` for `default`, otherwise `<project_name>-<flavour>`.
   - Construct the path `<themes_dir>/<flavour_dir>/cinnamon`.
   - If a file named `<flavour_dir>.css` exists inside that directory, rename it to `cinnamon.css`.
4. The script exits silently; any missing files are simply ignored.

**Exported symbols** – The script is executed as a module (`__main__`). No Python functions or classes are intended for import by other code.

---

## 3. Logic Flow Within the Folder
1. **SCSS compilation** (handled by Meson/Ninja, not part of the source code shown):
   - The `_*.scss` files are concatenated and processed by `sassc` to produce `cinnamon.css` inside a temporary build directory.
2. **Asset packaging**:
   - All SVG files under `assets/` are copied into the theme’s directory structure and later compiled into a GResource binary by the build system.
3. **Installation layout** (performed by `post_install.py` after `meson install`):
   - The build system installs the generated CSS as `<flavour>.css` (e.g., `yaru.css`, `yaru-dark.css`).
   - `post_install.py` renames each of those files to the canonical name `cinnamon.css` expected by the Cinnamon shell at runtime.
4. **Result**:
   - After the script runs, the final layout under `<PREFIX>/<data_dir>/themes/<theme‑name>/cinnamon/` contains:
     - `cinnamon.css` (the compiled stylesheet)
     - The full set of SVG assets referenced by the stylesheet.

---

## 4. Dependencies
| Dependency | Reason / Role |
|------------|---------------|
| **Python 3 (standard library)** | Used by `post_install.py` for path manipulation (`os.path`), environment access (`os.environ`), and file moving (`shutil.move`). |
| **MESON build system** | Drives the SCSS compilation, asset copying, and invokes `post_install.py` as a post‑install step. |
| **sassc** | Compiles the SCSS source files into CSS. |
| **Cinnamon shell** (runtime) | Consumes the generated `cinnamon.css` and the packaged SVG assets. |
| **Filesystem layout** (`/usr` prefix by default) | The script relies on the conventional theme directory hierarchy (`share/themes/<name>/cinnamon`). |

No external Python packages are required; the script is deliberately lightweight to run in any standard Ubuntu build environment.

---

*This README is generated automatically to keep documentation in sync with the actual implementation of the `cinnamon-shell/src` module.*