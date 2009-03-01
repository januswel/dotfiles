# zsh RC file
# Maintainer:   janus_wel <janus.wel.3@gmail.com>
# Last Change:  2009/03/01 15:52:31.

# completions
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle :compinstall filename '/home/janus/.zshrc'

autoload -U compinit
compinit
zstyle ':completion:*' list-colors ''

bindkey -v

# prompts
#setopt prompt_subst
#autoload -U colors
#colors

#PROMPT="%{$fg[green]%}${USER}@${HOST}${WINDOW:+"[$WINDOW]"}%(!.#.$) %{$reset_color%}"
#RPROMPT="%{$fg[green]%}[%~]%{$reset_color%}"
PROMPT="${USER}@${HOST}${WINDOW:+"[$WINDOW]"}%(!.#.$) "
RPROMPT="[%~]"
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

# aliases
alias ls="ls --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
