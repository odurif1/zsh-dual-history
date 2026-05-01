# fzf-dual-history

Separate human shell commands from AI instructions in fzf's Ctrl+R history search.
Designed for Forge with Oh My Zsh.

## The problem

Forge (with Oh My Zsh) sends instructions to AI models by prefixing them with
`:` (a zsh no-op builtin). These instructions pollute your `Ctrl+R` and `history`
output, mixing with your day-to-day shell commands.

## The solution

`fzf-dual-history` intercepts every command via `zshaddhistory`:

- `:` prefixed commands → `~/.zsh_ai_history`
- Everything else → `~/.zsh_history`

Both histories are preserved and independently searchable.

## Installation

### Oh My Zsh

```bash
git clone https://github.com/odurif1/fzf-dual-history.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-dual-history
```

Then in `~/.zshrc` (**after** `fzf`):

```zsh
plugins=(... fzf fzf-dual-history)
```

### Standalone (without Oh My Zsh)

```bash
git clone https://github.com/odurif1/fzf-dual-history.git ~/.fzf-dual-history
echo 'source ~/.fzf-dual-history/fzf-dual-history.plugin.zsh' >> ~/.zshrc
```

**Requirements:** zsh 5.0+, fzf 0.52.0+

## Usage

| Shortcut  | Action                                       |
|-----------|----------------------------------------------|
| `Ctrl+R`  | Open fzf with **all** history (human + AI)   |
| `Tab`     | Cycle through: All → Human → AI → All        |
| `Alt+H`   | Switch to human commands only                |
| `Alt+I`   | Switch to AI instructions only               |
| `Alt+A`   | Switch back to all history                   |
| `history` | Display human shell history only (clean)     |
| `cat ~/.zsh_ai_history` | View raw AI instruction history   |

The fzf header always shows the current active view.

## How it works

```
Command typed → zshaddhistory hook → starts with ":"?
                                      ├─ Yes → ~/.zsh_ai_history
                                      └─ No  → ~/.zsh_history
```

The Ctrl+R widget opens fzf with all history by default. Tab/Alt keys use
fzf's `reload` and `transform` actions to switch data sources dynamically.
Tab state is keyed on the fzf PID so multiple fzf instances don't interfere.

## Configuration

| Variable               | Default               | Description                  |
|------------------------|-----------------------|------------------------------|
| `DUAL_HISTORY_AI_FILE` | `~/.zsh_ai_history`   | Path to AI history file      |

Set **before** the plugin is sourced:

```zsh
export DUAL_HISTORY_AI_FILE="$HOME/sync/ai-instructions.zsh"
```

## License

MIT
