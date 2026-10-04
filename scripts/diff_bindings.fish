#!/usr/bin/env fish

set_color --bold cyan
echo "=== Differences Between Default and Current Keybindings ==="
set_color normal
echo ""

set -l tmp_default (mktemp)
set -l tmp_current (mktemp)

# Dump clean factory default bindings (without user configuration)
fish --no-config -c "bind" | sort > $tmp_default

# Dump current bindings with active configuration
fish -c "bind" | sort > $tmp_current

# Compute differences
set -l added (comm -13 $tmp_default $tmp_current)
set -l removed (comm -23 $tmp_default $tmp_current)

if test -n "$added"
    set_color green
    echo "--- Added or Modified Bindings compared to defaults ---"
    set_color normal
    for line in $added
        echo "+ $line"
    end
    echo ""
end

if test -n "$removed"
    set_color yellow
    echo "--- Removed or Overridden Bindings compared to defaults ---"
    set_color normal
    for line in $removed
        echo "- $line"
    end
    echo ""
end

if test -z "$added" -a -z "$removed"
    echo "No differences found compared to Fish factory defaults."
end

rm -f $tmp_default $tmp_current
