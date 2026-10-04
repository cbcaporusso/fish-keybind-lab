#!/usr/bin/env fish

set_color --bold cyan
echo "=== Restoring Word Deletion Keybindings (Ctrl+Backspace / Ctrl+Delete) ==="
set_color normal

set -l script_dir (cd (dirname (status filename)); and pwd)
set -l project_dir (cd "$script_dir/.."; and pwd)
set -l preset_file "$project_dir/presets/word_deletion.fish"
set -l config_file "$HOME/.config/fish/config.fish"

if not test -f "$preset_file"
    set_color red
    echo "Error: preset file $preset_file not found!"
    set_color normal
    exit 1
end

# Ensure configuration directory exists
mkdir -p (dirname "$config_file")
touch "$config_file"

# Check if bindings are already present
set -l has_b (grep -E "bind.*\\\\b.*backward-kill-word" "$config_file" 2>/dev/null)
set -l has_del (grep -E "bind.*kill-word" "$config_file" 2>/dev/null)

set -l force 0
if contains -- "--force" $argv; or contains -- "-f" $argv
    set force 1
end

if test -n "$has_b" -a -n "$has_del" -a $force -eq 0
    set_color yellow
    echo "Bindings are already present in $config_file."
    echo "Use '--force' to re-apply forcefully."
    set_color normal
else
    # Create backup
    set -l timestamp (date +%Y%m%d_%H%M%S)
    set -l backup_file "$config_file.bak.$timestamp"
    cp "$config_file" "$backup_file"
    set_color green
    echo "Backup created at: $backup_file"
    set_color normal

    # Clean up old/partial lines if in force mode
    if test $force -eq 1
        sed -i '/# Bindings for word deletion/d' "$config_file"
        sed -i '/bind \\\\b backward-kill-word/d' "$config_file"
        sed -i '/bind \\\\cH backward-kill-word/d' "$config_file"
        sed -i '/bind \\\\e\\\[3\\\\;5~ kill-word/d' "$config_file"
    end

    # Append preset to config.fish
    echo "" >> "$config_file"
    echo "# Bindings for word deletion (Restored by fish-keybind-lab)" >> "$config_file"
    cat "$preset_file" >> "$config_file"

    set_color green
    echo "Bindings successfully added to $config_file!"
    set_color normal
end

# Apply immediately to current session
bind \b backward-kill-word
bind \cH backward-kill-word
bind \e\[3\;5~ kill-word
if bind -M insert >/dev/null 2>&1
    bind -M insert \b backward-kill-word 2>/dev/null
    bind -M insert \cH backward-kill-word 2>/dev/null
    bind -M insert \e\[3\;5~ kill-word 2>/dev/null
end

set_color green
echo "Bindings applied to active session."
set_color normal
echo ""
