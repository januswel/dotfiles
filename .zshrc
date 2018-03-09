# .zshrc file
# janus_wel <janus.wel.3@gmail.com>

# environment variables
export CPLUS_INCLUDE_PATH=/usr/local/include:$CPLUS_INCLUDE_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# for aliases
LS_COMMAND="ls"
CP_COMMAND="cp"
MV_COMMAND="mv"
RM_COMMAND="rm"
DIRCOLORS_COMMAND="dircolors"
CTAGS_COMMAND="ctags"

# settings for Mac OS X
if [ "Darwin" = $(uname) ]; then
    # for anyenv
    export PATH=${HOME}/.anyenv/bin:${PATH}
    eval "$(anyenv init -)"

    # for git
    export PATH=$(brew --prefix git)/bin:${PATH}

    # for Android development
    export ANDROID_HOME=${HOME}/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

    # my utilities
    export PATH=~/bin:$PATH

    # for HomeBrew
    export PATH=$PATH:/usr/local/sbin
    export MANPATH=/usr/local/share/man:$MANPATH
    export CPLUS_INCLUDE_PATH=/usr/local/include:$CPLUS_INCLUDE_PATH

    # for Mac OS X bug
    #unset LD_LIBRARY_PATH
    #unset DYLD_LIBRARY_PATH

    # for Java
    alias java="java -Dfile.encoding=UTF-8"
    alias javac="javac -J-Dfile.encoding=UTF-8"
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH=${PATH}:${JAVA_HOME}/bin

    # for Rust
    source ${HOME}/.cargo/env

    # for AWS
    export PATH=${PATH}:~/Library/Python/2.7/bin

    LS_COMMAND="gls"
    CP_COMMAND="gcp"
    MV_COMMAND="gmv"
    RM_COMMAND="grm"
    DIRCOLORS_COMMAND="gdircolors"
    VIM_COMMAND='/Applications/MacVim.app/Contents/MacOS/Vim'
    CTAGS_COMMAND=$(brew --prefix)"/bin/ctags"
fi

# completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
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
alias ls="$LS_COMMAND --color=auto"
alias cp="$CP_COMMAND -i"
alias mv="$MV_COMMAND -i"
alias rm="$RM_COMMAND -i"
alias dircolors="$DIRCOLORS_COMMAND"
alias ctags="${CTAGS_COMMAND}"
alias g="git"
alias gs="find . -type d -depth 1 ! -name '.*' -exec zsh -c 'cd \"{}\"; pwd; git status -s;' \;"
alias d="docker"
alias node="node --use_strict"
alias y="yarn"

if [ -x "${VIM_COMMAND}" ]; then
    alias vim="${VIM_COMMAND}"
fi

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

# golang
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=${HOME}/work/dev/lang/golang
export PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin
