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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# completions
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# colors
DIRCOLORS_SETTINGS=".dir_colors"
if [ "$TERM" != "dumb" ]; then
    if [ -r $DIRCOLORS_SETTINGS ]; then
        eval "`dircolors $DIRCOLORS_SETTINGS -b`"
    fi
fi
