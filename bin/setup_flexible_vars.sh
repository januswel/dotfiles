# shellcheck disable=SC2139
# shellcheck disable=SC1090

# environment variables
export CPLUS_INCLUDE_PATH=/usr/local/include:$CPLUS_INCLUDE_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# settings for macOS
if [ "Darwin" = "$(uname)" ]; then
    # for HomeBrew
    export PATH=${PATH}:/usr/local/sbin
    export MANPATH=${MANPATH}:/usr/local/share/man
    export CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}:/usr/local/include

    # coreutils
    COREUTILS_PATH=$(brew --prefix coreutils)
    export PATH=${COREUTILS_PATH}/libexec/gnubin:${PATH}

    # for anyenv
    eval "$(anyenv init - zsh)"

    # for git
    GIT_PATH=$(brew --prefix git)
    export PATH=${PATH}:${GIT_PATH}/bin

    # for Java
    JAVA_HOME=$(/usr/libexec/java_home -v 17)
    export JAVA_HOME
    export PATH=${PATH}:${JAVA_HOME}/bin
    alias java="java -Dfile.encoding=UTF-8"
    alias javac="javac -J-Dfile.encoding=UTF-8"

    # for Rust
    if [ -d "${HOME}/.cargo/bin" ]; then
      export PATH=${PATH}:${HOME}/.cargo/bin
    fi

    # for Android development
    export ANDROID_HOME=${HOME}/Library/Android/sdk
    ANDROID_EMULATOR=${ANDROID_HOME}/emulator
    ANDROID_TOOLS=${ANDROID_HOME}/tools
    ANDROID_BIN=${ANDROID_HOME}/tools/bin
    ANDROID_PLATFORM_TOOLS=${ANDROID_HOME}/platform-tools
    export PATH=${PATH}:${ANDROID_EMULATOR}:${ANDROID_TOOLS}:${ANDROID_BIN}:${ANDROID_PLATFORM_TOOLS}

    # for Flutter
    export FLUTTER_HOME=${HOME}/lib/flutter
    export PATH=${PATH}:${FLUTTER_HOME}/bin

    # for google-cloud-sdk
    if [ -d "${HOME}/google-cloud-sdk/bin" ]; then
      export PATH=${PATH}:${HOME}/google-cloud-sdk/bin
    fi

    # MySQL
    MYSQL_PATH=$(brew --prefix mysql-client)
    export PATH=${PATH}:${MYSQL_PATH}/bin

    # editor
    VIM_COMMAND='/Applications/MacVim.app/Contents/MacOS/Vim'

    # my utilities
    export PATH=~/bin:$PATH
fi

if [ -x "${VIM_COMMAND}" ]; then
    alias vim="${VIM_COMMAND}"
fi

alias ls="ls --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
