#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX_DIR="$PROJECT_DIR/sandbox_env"
SANDBOX_CONFIG_DIR="$SANDBOX_DIR/fish"

mkdir -p "$SANDBOX_CONFIG_DIR"

# If config.fish doesn't exist in the sandbox yet, generate a default one with presets
if [ ! -f "$SANDBOX_CONFIG_DIR/config.fish" ]; then
    cat << EOF > "$SANDBOX_CONFIG_DIR/config.fish"
# Fish Keybind Lab - Sandbox Configuration

function fish_greeting
    set_color cyan
    echo "================================================================="
    echo "  Welcome to Fish Keybind Lab Sandbox!"
    echo "  - This session is isolated from your ~/.config/fish/config.fish"
    echo "  - Try typing text and pressing Ctrl+Backspace / Ctrl+Delete"
    echo "  - To exit: type 'exit'"
    echo "================================================================="
    set_color normal
end

# Load word-deletion presets
source "$PROJECT_DIR/presets/word_deletion.fish"

# Feel free to add and test new bindings here:
# bind \cg "git status"
EOF
fi

echo "Launching isolated Fish sandbox (XDG_CONFIG_HOME=$SANDBOX_DIR)..."
XDG_CONFIG_HOME="$SANDBOX_DIR" fish
