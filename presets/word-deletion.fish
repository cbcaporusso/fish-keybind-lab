# @name: word-deletion
# @description: Delete whole words with Ctrl+Backspace (left) and Ctrl+Delete (right)

status is-interactive; or exit

# --- Ctrl + Backspace (delete word to the left) ---
# Standard terminals send \b (0x08 / BS) or \cH; CSI-u terminals may send \e[127;5u
bind \b backward-kill-word
bind \cH backward-kill-word
bind \e\[127\;5u backward-kill-word

# --- Ctrl + Delete (delete word to the right) ---
# Standard xterm/VTE escape sequence is \e[3;5~
bind \e\[3\;5~ kill-word

# Vi-mode support (insert mode)
if bind -M insert >/dev/null 2>&1
    bind -M insert \b backward-kill-word
    bind -M insert \cH backward-kill-word
    bind -M insert \e\[127\;5u backward-kill-word
    bind -M insert \e\[3\;5~ kill-word
end
