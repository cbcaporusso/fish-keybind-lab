# @name: line-editing
# @description: Standardize Home, End, Ctrl+U (kill line left), and Ctrl+K (kill line right)

status is-interactive; or exit

# --- Home / End (beginning and end of line across xterm, VTE, rxvt, tmux) ---
bind \e\[H beginning-of-line
bind \eOH beginning-of-line
bind \e\[1~ beginning-of-line

bind \e\[F end-of-line
bind \eOF end-of-line
bind \e\[4~ end-of-line

# --- Line Deletion ---
bind \cu backward-kill-line
bind \ck kill-line

# Vi-mode support (insert mode)
if bind -M insert >/dev/null 2>&1
    bind -M insert \e\[H beginning-of-line
    bind -M insert \eOH beginning-of-line
    bind -M insert \e\[1~ beginning-of-line
    bind -M insert \e\[F end-of-line
    bind -M insert \eOF end-of-line
    bind -M insert \e\[4~ end-of-line
    bind -M insert \cu backward-kill-line
    bind -M insert \ck kill-line
end
