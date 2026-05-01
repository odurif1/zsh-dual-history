#!/bin/sh
sed -n 's/^: *[0-9]*:[0-9]*;\(.*\)/\1/p; t; p' "${HISTFILE:-$HOME/.zsh_history}" 2>/dev/null \
  | grep -v '^:'
