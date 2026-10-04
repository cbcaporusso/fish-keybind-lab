# Fish Keybind Lab ⌨️🐟

Keybinding manager and testing laboratory for the **Fish** shell.

This project is designed to:
1. **Restore and verify** quick word-deletion shortcuts:
   - **<kbd>Ctrl</kbd> + <kbd>Backspace</kbd>** (`backward-kill-word`): deletes the word to the left of the cursor.
   - **<kbd>Ctrl</kbd> + <kbd>Delete</kbd>** (`kill-word`): deletes the word to the right of the cursor.
2. **Experiment in a Sandbox** with new Fish shortcuts and functions in an isolated session, without affecting your primary configuration (`~/.config/fish/config.fish`).
3. **Analyze and capture** ANSI escape sequences transmitted by the terminal emulator.

---

## ⚡ Quick Commands (`./manage.sh`)

You can interact with the lab using the [manage.sh](file:///mnt/data/projects/tools/fish-keybind-lab/manage.sh) script:

```bash
# 1. Check if word-deletion keybindings (Ctrl+Backspace and Ctrl+Delete) are active and persisted
./manage.sh status

# 2. Restore/install word-deletion bindings into your config.fish (automatically creates a backup)
./manage.sh restore

# 3. Force re-applying bindings if missing or corrupted
./manage.sh restore --force

# 4. Enter the isolated sandbox to test shortcuts safely
./manage.sh sandbox

# 5. Display a clean diff between Fish default bindings and active ones
./manage.sh diff

# 6. Launch the key reader to inspect the ANSI sequence of any key pressed
./manage.sh reader
```

---

## 📖 Keybinding Details: <kbd>Ctrl</kbd> + <kbd>Backspace</kbd> & <kbd>Ctrl</kbd> + <kbd>Delete</kbd>

In Linux terminal emulators, advanced text-editing key combinations like whole-word deletion do not send plain characters, but rather **ASCII control characters** or **ANSI escape sequences**:

| Key | Sequence / Code | Associated Fish Function | Description |
|---|---|---|---|
| <kbd>Ctrl</kbd> + <kbd>Backspace</kbd> | `\b` (0x08) or `\cH` | `backward-kill-word` | Deletes the word to the left of the cursor |
| <kbd>Ctrl</kbd> + <kbd>Delete</kbd> | `\e[3;5~` | `kill-word` | Deletes the word to the right of the cursor |

### Why are they necessary?
By default in Fish and across various terminal emulators, <kbd>Ctrl</kbd> + <kbd>Backspace</kbd> or <kbd>Ctrl</kbd> + <kbd>Delete</kbd> may be unmapped or produce unrecognized escape sequences. In addition, prompt customizers (such as Oh My Posh) and Vi keybindings mode can overwrite or fail to register standard bindings.

To inspect shell behavior and pinpoint the exact escape codes, two dump logs were evaluated:
* `bindings.txt`: list of bindings registered in a non-interactive shell (`fish -c "bind"`).
* `bindings_interactive.txt`: dump generated in an interactive shell (with user configuration, themes, and fastfetch banner loaded).

The preset [presets/word_deletion.fish](file:///mnt/data/projects/tools/fish-keybind-lab/presets/word_deletion.fish) standardizes and explicitly defines these shortcuts for Fish shell, covering both default mode and Vi mode (`insert mode`).

---

## 🧪 How the Sandbox Works

The sandbox leverages the `XDG_CONFIG_HOME` environment variable:
```bash
XDG_CONFIG_HOME="./sandbox_env" fish
```
This directs Fish to read `sandbox_env/fish/config.fish` instead of your personal `~/.config/fish/config.fish`.
You can customize the sandbox, experiment with complex functions, bind custom <kbd>Ctrl</kbd> combinations, and test configurations without any risk to your primary shell.

---

## 📂 Project Structure

```
tools/fish-keybind-lab/
├── README.md                   # Project documentation
├── manage.sh                   # Unified management CLI
├── presets/
│   └── word_deletion.fish      # Word-deletion presets (Ctrl+Backspace & Ctrl+Delete)
├── scripts/
│   ├── check_status.fish       # Diagnostic status check script
│   ├── restore_bindings.fish   # Safe restoration script with timestamped backup
│   ├── run_sandbox.sh          # Sandbox launcher script
│   └── diff_bindings.fish      # Binding diff analyzer against defaults
└── sandbox_env/                # Isolated testing environment (generated on first run)
```
