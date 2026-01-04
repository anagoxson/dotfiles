#
# Additional settings
#

# History settings
HISTSIZE=100000
HISTFILESIZE=200000

# Custom PS1 prompt
# Check if color prompt is supported
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # Color prompt: date/time in yellow, \u@\h in green, \w in blue
    PS1="\n[ \[\033[01;33m\]\D{%Y-%m-%d %H:%M:%S}\[\033[00m\] \[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \!(\$?) ]\n\$ "
else
    # No color prompt
    PS1="\n[ \D{%Y-%m-%d %H:%M:%S} \u@\h \w \!(\$?) ]\n\$ "
fi
unset color_prompt force_color_prompt

# Create tmux log directory if it doesn't exist
mkdir -p ~/.tmux/log

# tmux auto-start (only if not already in tmux and not from VSCode/Cursor)
if [ -z "$TMUX" ]; then
    # Check if running from VSCode or Cursor
    if [ "$TERM_PROGRAM" != "vscode" ] && [ "$TERM_PROGRAM" != "cursor" ]; then
        # Attach to existing session or create new one
        if command -v tmux >/dev/null 2>&1; then
            tmux new-session -A -s default 2>/dev/null || tmux attach 2>/dev/null
        fi
    fi
fi

# SSH agent setup (only on terminal startup)
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" >/dev/null 2>&1
    # Add default SSH keys if they exist
    if [ -f ~/.ssh/id_rsa ]; then
        ssh-add ~/.ssh/id_rsa 2>/dev/null
    elif [ -f ~/.ssh/id_ed25519 ]; then
        ssh-add ~/.ssh/id_ed25519 2>/dev/null
    elif [ -f ~/.ssh/id_ecdsa ]; then
        ssh-add ~/.ssh/id_ecdsa 2>/dev/null
    fi
fi

