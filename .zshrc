# .zshrc file
# janus_wel <janus.wel.3@gmail.com>

source ~/bin/setup_flexible_vars.sh

# completions
FPATH=${HOME}/bin/zsh/site-functions:${FPATH}
FPATH=$(brew --prefix)/share/zsh/site-functions:${FPATH}
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:${FPATH}

  if [ "$(brew list | grep git | wc -l)" -ge 1 ]; then
    FPATH=$(brew --prefix git)/share/zsh/site-functions:${FPATH}
  fi
fi

autoload -U compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle :compinstall filename '/home/janus/.zshrc'

# use vi like keybind
# press <Esc> to enter normal mode
bindkey -v

# prompts
setopt prompt_subst
autoload -U colors
colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
    if [ ${DOCKER_MACHINE_NAME} ]; then
        psvar[2]="{${DOCKER_MACHINE_NAME}}"
    fi
}

PROMPT="%B%{$fg[green]%}${USER}@%m${WINDOW:+"[$WINDOW]"}%(!.#.$) %{$reset_color%}%b"
RPROMPT="%B%{$fg[cyan]%}[%~%1v%2v]%{$reset_color%}%b"
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

# aliases
alias g="git"
alias gs="find . -type d -depth 1 ! -name '.*' -exec zsh -c 'cd \"{}\"; pwd; git status -s;' \;"
alias d="docker"
alias node="node --use_strict"
alias y="yarn"

# Japanize console if available
export LANG="C"

JA_JP_UTF8=$(locale -a | grep ja_JP | grep -i utf)
if [ $JA_JP_UTF8 ] ; then
    export LANG=$JA_JP_UTF8
fi
unset JA_JP_UTF8

# colors for "ls"
DIRCOLORS_SETTINGS=".dir_colors"
if [ "$TERM" != "dumb" ]; then
    if [ -r "$DIRCOLORS_SETTINGS" ]; then
        eval $(dircolors $DIRCOLORS_SETTINGS -b)
    fi
fi

# openssl
OPENSSL_HOME=/usr/local/opt/openssl@1.1
if [ -d ${OPENSSL_HOME} ]; then
    export PATH=${OPENSSL_HOME}/bin${PATH:+:}${PATH}
    export LD_LIBRARY_PATH=${OPENSSL_HOME}/lib${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}
    export CPATH=${OPENSSL_HOME}/include:${CPATH:+:}${CPATH}
fi

# suppress suspend by ctrl-s
stty stop undef

# history operations
bindkey '^R' history-beginning-search-backward
bindkey '^S' history-beginning-search-forward

# direnv
eval "$(direnv hook zsh)"

# history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt extended_history

# unique
typeset -U PATH
typeset -U MANPATH
typeset -U CPLUS_INCLUDE_PATH
typeset -U JAVA_HOME
typeset -U GOPATH
typeset -U ANDROID_HOME

GCP_SDK_PATH_FILE=~/lib/google-cloud-sdk/path.zsh.inc
if [ -f ${GCP_SDK_PATH_FILE} ]; then
  . ${GCP_SDK_PATH_FILE}
fi
GCP_SDK_COMPLETE_FILE=~/lib/google-cloud-sdk/completion.zsh.inc
if [ -f ${GCP_SDK_COMPLETE_FILE} ]; then
  . ${GCP_SDK_COMPLETE_FILE}
fi
