#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_help() {
    cat << EOF
Fish Keybind Lab - Fish Shell Keybinding Manager & Lab

Usage:
  ./manage.sh <command> [options]

Available commands:
  status     Check if word-deletion keybindings (Ctrl+Backspace & Ctrl+Delete)
             are active in the current session and saved in ~/.config/fish/config.fish
  restore    Restore/install word-deletion keybindings into ~/.config/fish/config.fish
             (automatically creates a timestamped backup copy)
             Use '--force' to overwrite or force re-application
  sandbox    Launch an isolated Fish shell (XDG_CONFIG_HOME) to test shortcuts
             freely without modifying your actual configuration files
  diff       Show differences between default Fish bindings and active bindings
  reader     Launch 'fish_key_reader' to inspect the ANSI sequence of any key pressed
  help       Display this help message

Examples:
  ./manage.sh status
  ./manage.sh restore --force
  ./manage.sh sandbox
  ./manage.sh reader
EOF
}

cmd="${1:-help}"

case "$cmd" in
    status)
        fish "$SCRIPT_DIR/scripts/check_status.fish"
        ;;
    restore)
        shift
        fish "$SCRIPT_DIR/scripts/restore_bindings.fish" "$@"
        ;;
    sandbox)
        "$SCRIPT_DIR/scripts/run_sandbox.sh"
        ;;
    diff)
        fish "$SCRIPT_DIR/scripts/diff_bindings.fish"
        ;;
    reader)
        echo "Press any key or combination (e.g. Ctrl+Backspace or Ctrl+Delete)."
        echo "Press Ctrl+C to exit."
        echo ""
        fish_key_reader
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: '$cmd'"
        echo ""
        show_help
        exit 1
        ;;
esac
