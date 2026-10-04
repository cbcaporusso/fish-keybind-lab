#!/usr/bin/env fish

set_color --bold cyan
echo "=== Fish Keybinding Status Check ==="
set_color normal

set -l config_file "$HOME/.config/fish/config.fish"
set -l func_file "$HOME/.config/fish/functions/fish_user_key_bindings.fish"

# 1. Runtime status check
echo ""
echo "Active keybindings in current session:"

# Check backward-kill-word (\b or \cH)
set -l b_bind (bind \b 2>/dev/null)
set -l ch_bind (bind \cH 2>/dev/null)
if string match -q "*backward-kill-word*" "$b_bind"
    set_color green
    echo "  [OK] Ctrl + Backspace: active -> backward-kill-word"
else if string match -q "*backward-kill-word*" "$ch_bind"
    set_color green
    echo "  [OK] Ctrl + Backspace: active -> backward-kill-word (via \cH)"
else
    set_color red
    echo "  [MISSING] Ctrl + Backspace NOT bound to backward-kill-word"
end
set_color normal

# Check kill-word (\e[3;5~)
set -l del_bind (bind \e\[3\;5~ 2>/dev/null)
if string match -q "*kill-word*" "$del_bind"
    set_color green
    echo "  [OK] Ctrl + Delete: active -> kill-word (\e[3;5~)"
else
    set_color red
    echo "  [MISSING] Ctrl + Delete (\e[3;5~) NOT bound to kill-word"
end
set_color normal

# 2. Configuration file persistence check
echo ""
echo "Configuration file persistence:"

if test -f "$config_file"
    set -l has_b (grep -E "bind.*\\\\b.*backward-kill-word" "$config_file" 2>/dev/null)
    set -l has_del (grep -E "bind.*kill-word" "$config_file" 2>/dev/null)
    if test -n "$has_b" -a -n "$has_del"
        set_color green
        echo "  [OK] Present in $config_file"
    else
        set_color yellow
        echo "  [WARNING] Incomplete or missing in $config_file"
    end
else
    set_color red
    echo "  [ERROR] File $config_file not found"
end
set_color normal

if test -f "$func_file"
    set_color blue
    echo "  [INFO] Also detected $func_file"
    set_color normal
end

echo ""
