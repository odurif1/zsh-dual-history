#!/bin/sh
_DIR="$1"
_STATE="/tmp/fzf-dual-history-${PPID}"
state=$(cat "$_STATE" 2>/dev/null || echo 0)
next=$(( (state + 1) % 3 ))
echo "$next" > "$_STATE"
case $next in
  0) printf 'reload(%s/reload-all.sh)+change-header(All history)' "$_DIR" ;;
  1) printf 'reload(%s/reload-human.sh)+change-header(Human commands)' "$_DIR" ;;
  2) printf 'reload(%s/reload-ai.sh)+change-header(AI instructions)' "$_DIR" ;;
esac
