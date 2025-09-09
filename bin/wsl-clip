#!/bin/bash

# This script is a wrapper to use Windows clip.exe under WSL when xclip/xsel is called.

# Check if we are running under WSL
if ! grep -qEi "(microsoft|WSL)" /proc/version &> /dev/null; then
    # If NOT running under WSL, try to use the real xclip first, then xsel as a fallback.
    if command -v xclip &> /dev/null; then
        exec xclip "$@"
    elif command -v xsel &> /dev/null; then
        exec xsel "$@"

    else
        echo "Error: Neither xclip nor xsel is available." >&2
        exit 1
    fi
fi

# If we ARE running under WSL, use Windows clip.exe
# Check if the input is coming from stdin (like when yanking from Neovim)
if [ -t 0 ]; then
    # Input is from the command line arguments (e.g., -selection c, -i, -o)
    # This simple wrapper mainly handles stdin. For complex usage, you might need more logic.
    # We'll just pass it to clip.exe which only handles stdin.
    echo "wsl-clipboard: For WSL, input must be piped in (from stdin)." >&2
    exit 1
else
    # Input is from stdin (this is how Neovim communicates when yanking)
    # Read the stdin and pipe it to clip.exe on the Windows side
    /mnt/c/Windows/System32/clip.exe
    exit $?
fi
