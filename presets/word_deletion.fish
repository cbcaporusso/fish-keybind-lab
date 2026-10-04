# ==============================================================================
# Word Deletion Presets (Ctrl+Backspace & Ctrl+Delete)
# ==============================================================================
# These bindings restore standard GUI/editor word-deletion behavior:
# - Ctrl + Backspace -> delete word to the left  (backward-kill-word)
# - Ctrl + Delete    -> delete word to the right (kill-word)
# ==============================================================================

# Ctrl + Backspace
# Most terminal emulators send \b (0x08) or \cH (Ctrl+H)
bind \b backward-kill-word
bind \cH backward-kill-word

# Ctrl + Delete
# Standard ANSI escape sequence for Ctrl+Delete (\e[3;5~)
bind \e\[3\;5~ kill-word

# Vi-mode support (insert mode)
if bind -M insert >/dev/null 2>&1
    bind -M insert \b backward-kill-word
    bind -M insert \cH backward-kill-word
    bind -M insert \e\[3\;5~ kill-word
end
