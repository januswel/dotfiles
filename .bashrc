# .bashrc
# janus_wel <janus.wel.3@gmail.com>

# if not running interactively, don't do anything
if [ -z "$PS1" ]; then
    return
fi

# don't put lines that is duplicated and starts with spaces in the history
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

if [ "Darwin" = "$(uname)" ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi

# prompt
case "$TERM" in
screen|xterm-256color)
    PS1='\[\033]0;\w$(__git_ps1)\007\]\[\033[1;36m\][\w$(__git_ps1)]\n\[\033[1;32m\]\u@\h\[\033[00m\]$ '
    ;;
cygwin)
    PS1='\[\033]0;\w$(__git_ps1)\007\]\[\033[1;32m\]\u@\h\[\033[00m\]$ '
    ;;
*)
    PS1='\[\033]0;\w\007\]\[\033[1;32m\]\u@\h\[\033[00m\]$ '
    ;;
esac

# completions
if [ -f /etc/bash_completion ]; then
    # shellcheck source=/dev/null
    . /etc/bash_completion
fi

# aliases
if [ -f "$HOME"/.bash_aliases ]; then
    . "$HOME"/.bash_aliases
fi

# colors
DIRCOLORS_SETTINGS=".dir_colors"
if [ "$TERM" != "dumb" ]; then
    if [ -r $DIRCOLORS_SETTINGS ]; then
      eval "$(dircolors $DIRCOLORS_SETTINGS -b)"
    fi
fi

. "$HOME/.cargo/env"
