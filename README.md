# fish-keybind-lab (`fkl`)

A pure-Fish CLI tool and isolated sandbox for fixing, diagnosing, and testing **text-editing keybindings** in the [Fish shell](https://fishshell.com/).

## Why this tool exists

In many Linux terminal emulators (VTE/GNOME Terminal, Alacritty, Kitty, WezTerm, Konsole, xterm) and prompt setups (such as Oh My Posh or Fish Vi mode), standard text-editing shortcuts like **<kbd>Ctrl</kbd>+<kbd>Backspace</kbd>** or **<kbd>Ctrl</kbd>+<kbd>Delete</kbd>** either emit non-standard escape sequences or remain unmapped.

`fish-keybind-lab` (`fkl`) solves this without polluting your `~/.config/fish/config.fish`:
- **Fixes editing shortcuts** via modular presets installed cleanly into `~/.config/fish/conf.d/fish-keybind-lab.fish` (covering both default Emacs mode and Vi `insert` mode).
- **Diagnoses active bindings** in a real interactive Fish session (`fkl status` and `fkl diff`), distinguishing Fish factory defaults from custom user/plugin bindings.
- **Tests bindings safely** in an isolated `XDG_CONFIG_HOME` sandbox (`fkl sandbox`) before you touch your personal configuration.

---

## Quick Start

Run `./fkl` directly from the repository (or symlink `bin/fkl` into `~/.local/bin/fkl`):

```bash
# 1. Diagnose current interactive editing keybindings and configuration status
./fkl status

# 2. List available editing presets and see which ones are installed
./fkl list

# 3. Install the default word-deletion preset (Ctrl+Backspace & Ctrl+Delete) to conf.d/
./fkl install

# 4. Install all editing presets (word-deletion, word-navigation, line-editing)
./fkl install --all

# 5. Migrate/remove legacy inline bindings from ~/.config/fish/config.fish
./fkl install --all --clean-legacy

# 6. Test presets in an isolated Fish session without modifying ~/.config/fish
./fkl sandbox

# 7. Compare your active interactive bindings against Fish factory defaults
./fkl diff

# 8. Inspect raw escape sequences sent by your terminal emulator
./fkl reader
```

---

## Included Presets

| Preset | Keys Covered | Escape Sequences Bound | Target Fish Action |
| :--- | :--- | :--- | :--- |
| **`word-deletion`** *(default)* | <kbd>Ctrl</kbd>+<kbd>Backspace</kbd><br><kbd>Ctrl</kbd>+<kbd>Delete</kbd> | `\b`, `\cH`, `\e[127;5u`<br>`\e[3;5~` | `backward-kill-word`<br>`kill-word` |
| **`word-navigation`** | <kbd>Ctrl</kbd>+<kbd>Left</kbd><br><kbd>Ctrl</kbd>+<kbd>Right</kbd> | `\e[1;5D`, `\e[5D`, `\eOd`<br>`\e[1;5C`, `\e[5C`, `\eOc` | `backward-word`<br>`forward-word` |
| **`line-editing`** | <kbd>Home</kbd><br><kbd>End</kbd><br><kbd>Ctrl</kbd>+<kbd>U</kbd> / <kbd>Ctrl</kbd>+<kbd>K</kbd> | `\e[H`, `\eOH`, `\e[1~`<br>`\e[F`, `\eOF`, `\e[4~`<br>`\cu` / `\ck` | `beginning-of-line`<br>`end-of-line`<br>`backward-kill-line` / `kill-line` |

All presets automatically guard on `status is-interactive` and register bindings for both `default` mode and Vi `insert` mode (`bind -M insert`).

---

## Project Structure

```text
fish-keybind-lab/
├── fkl                         # Root symlink to bin/fkl
├── bin/
│   └── fkl                     # Main CLI executable (pure Fish)
├── presets/
│   ├── word-deletion.fish      # Ctrl+Backspace & Ctrl+Delete
│   ├── word-navigation.fish    # Ctrl+Left & Ctrl+Right across terminals
│   └── line-editing.fish       # Home, End, Ctrl+U, Ctrl+K
└── README.md
```
