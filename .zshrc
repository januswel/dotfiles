# zsh RC file
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

# settings for Mac OS X
if [ "Darwin" = `uname` ]; then
    # for Android development
    export ANDROID_HOME=~/android-sdks
    export PATH=$PATH:$ANDROID_HOME/tools/:$ANDROID_HOME/platform-tools/

    # for MySQL
    export PATH=$PATH:/usr/local/mysql/bin

    # my utilities
    export PATH=~/bin:$PATH

    export MANPATH=/opt/local/share/man:$MANPATH
    export CPLUS_INCLUDE_PATH=/opt/local/include:$CPLUS_INCLUDE_PATH
    export LD_LIBRARY_PATH=/opt/local/lib:$LD_LIBRARY_PATH

    LS_COMMAND="gls"
    CP_COMMAND="gcp"
    MV_COMMAND="gmv"
    RM_COMMAND="grm"
    DIRCOLORS_COMMAND="gdircolors"
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
alias ls="$LS_COMMAND --color=auto"
alias cp="$CP_COMMAND -i"
alias mv="$MV_COMMAND -i"
alias rm="$RM_COMMAND -i"

# Japanize console if available
export LANG="C"

JA_JP_UTF8=`locale -a | grep ja_JP | grep -i utf`
if [ $JA_JP_UTF8 ] ; then
    export LANG=$JA_JP_UTF8
fi
unset JA_JP_UTF8

# for Java
if [ "Darwin" = `uname` ]; then
    alias java="java -Dfile.encoding=UTF-8"
    alias javac="javac -J-Dfile.encoding=UTF-8"
fi

# colors for "ls"
DIRCOLORS_SETTINGS=~/.dir_colors
if [ -f $DIRCOLORS_SETTINGS ]; then
    eval `$DIRCOLORS_COMMAND $DIRCOLORS_SETTINGS -b`
fi

# clean up
unset LS_COMMAND
unset CP_COMMAND
unset MV_COMMAND
unset RM_COMMAND
unset DIRCOLORS_COMMAND
unset DIRCOLORS_SETTINGS

# for Mac OS X bug
if [ "Darwin" = `uname` ]; then
    unset LD_LIBRARY_PATH
    unset DYLD_LIBRARY_PATH
fi

