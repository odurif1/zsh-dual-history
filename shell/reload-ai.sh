#!/bin/sh
exec cat "${DUAL_HISTORY_AI_FILE:-$HOME/.zsh_ai_history}" 2>/dev/null
