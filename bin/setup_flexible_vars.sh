# shellcheck disable=SC2139
# shellcheck disable=SC1090

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
if [ "Darwin" = "$(uname)" ]; then
    # for anyenv
    export PATH=${HOME}/.anyenv/bin:${PATH}
    eval "$(anyenv init -)"

    # for git
    PATH=$(brew --prefix git)/bin:${PATH}
    export PATH

    # my utilities
    export PATH=~/bin:$PATH

    # for HomeBrew
    export PATH=$PATH:/usr/local/sbin
    export MANPATH=/usr/local/share/man:$MANPATH
    export CPLUS_INCLUDE_PATH=/usr/local/include:$CPLUS_INCLUDE_PATH

    # for Java
    alias java="java -Dfile.encoding=UTF-8"
    alias javac="javac -J-Dfile.encoding=UTF-8"
    JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    export JAVA_HOME
    export PATH=${PATH}:${JAVA_HOME}/bin

    # for Rust
    source "${HOME}/.cargo/env"
    export PATH=$HOME/.cargo/bin:$PATH

    # golang
    export GOPATH=${HOME}/work/dev/lang/golang
    export PATH=${PATH}:${GOPATH}/bin

     # for Android development
     export ANDROID_HOME=${HOME}/Library/Android/sdk
     export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

    # for AWS
    export PATH=${PATH}:~/Library/Python/2.7/bin

    # for google-cloud-sdk
    if [ -d "${HOME}/google-cloud-sdk/bin" ]; then
      export PATH=${PATH}:~/google-cloud-sdk/bin
    fi

    VIM_COMMAND='/Applications/MacVim.app/Contents/MacOS/Vim'
    LS_COMMAND="gls"
    CP_COMMAND="gcp"
    MV_COMMAND="gmv"
    RM_COMMAND="grm"
    DIRCOLORS_COMMAND="gdircolors"
fi

if [ -x "${VIM_COMMAND}" ]; then
    alias vim=${VIM_COMMAND}
fi

alias ls="${LS_COMMAND} --color=auto"
alias cp="${CP_COMMAND} -i"
alias mv="${MV_COMMAND} -i"
alias rm="${RM_COMMAND} -i"
alias dircolors="${DIRCOLORS_COMMAND}"
