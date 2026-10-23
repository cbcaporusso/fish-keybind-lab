# @name: word-navigation
# @description: Jump across words with Ctrl+Left and Ctrl+Right across terminal emulators

status is-interactive; or exit

# --- Ctrl + Left Arrow (jump word left) ---
bind \e\[1\;5D backward-word
bind \e\[5D backward-word
bind \eOd backward-word

# --- Ctrl + Right Arrow (jump word right) ---
bind \e\[1\;5C forward-word
bind \e\[5C forward-word
bind \eOc forward-word

# Vi-mode support (insert mode)
if bind -M insert >/dev/null 2>&1
    bind -M insert \e\[1\;5D backward-word
    bind -M insert \e\[5D backward-word
    bind -M insert \eOd backward-word
    bind -M insert \e\[1\;5C forward-word
    bind -M insert \e\[5C forward-word
    bind -M insert \eOc forward-word
end
