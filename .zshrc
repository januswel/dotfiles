# zsh RC file
# Maintainer:   janus_wel <janus.wel.3@gmail.com>
# Last Change:  2009/12/02 16:14:27.

# Add MacPorts path when OS is Mac
if [ "Darwin" = `uname` ]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:$MANPATH
fi

# completions
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle :compinstall filename '/home/janus/.zshrc'

autoload -U compinit
compinit
zstyle ':completion:*' list-colors ''

# use vi like keybind
# press <Esc> to enter normal mode
bindkey -v

# prompts
setopt prompt_subst
autoload -U colors
colors

PROMPT="%B%{$fg[yellow]%}${USER}@%m${WINDOW:+"[$WINDOW]"}%(!.#.$) %{$reset_color%}%b"
RPROMPT="%B%{$fg[cyan]%}[%~]%{$reset_color%}%b"
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

# aliases
alias ls="ls --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Japanize console if available
export LANG="C"

JA_JP_UTF8=`locale -a | grep ja_JP | grep -i utf`
if [ $JA_JP_UTF8 ] ; then
    export LANG=$JA_JP_UTF8
fi
unset JA_JP_UTF8
