#!/bin/bash
# Yazi wrapper - cd to last directory on quit
# Source this file or add to your shell config:
#   source ~/.config/yazi/yazi.sh

function yazi() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}
