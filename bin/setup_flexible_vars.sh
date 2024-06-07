#!/bin/sh

# shellcheck disable=SC2139
# shellcheck disable=SC1090

# environment variables
export CPLUS_INCLUDE_PATH=/usr/local/include:"${CPLUS_INCLUDE_PATH}"
export LD_LIBRARY_PATH=/usr/local/lib:"${LD_LIBRARY_PATH}"

# settings for macOS
if [ "Darwin" = "$(uname)" ]; then
    # for HomeBrew
    export PATH="${PATH}":/usr/local/sbin
    export MANPATH="${MANPATH}":/usr/local/share/man
    export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}":/usr/local/include

    # coreutils
    COREUTILS_PATH=$(brew --prefix coreutils)
    export PATH="${COREUTILS_PATH}/libexec/gnubin":"${PATH}"

    # for git
    GIT_PATH=$(brew --prefix git)
    export PATH="${GIT_PATH}/bin":"${PATH}"

    # for Java
    JAVA_HOME=$(/usr/libexec/java_home -v 21)
    export JAVA_HOME
    export PATH="${JAVA_HOME}/bin":"${PATH}"
    alias java="java -Dfile.encoding=UTF-8"
    alias javac="javac -J-Dfile.encoding=UTF-8"

    # for Rust
    if [ -d "${HOME}/.cargo/bin" ]; then
      export PATH="${HOME}/.cargo/bin":"${PATH}"
    fi

    # for Android development
    export ANDROID_HOME="${HOME}/Library/Android/sdk"
    ANDROID_EMULATOR=${ANDROID_HOME}/emulator
    ANDROID_TOOLS=${ANDROID_HOME}/tools
    ANDROID_BIN=${ANDROID_HOME}/tools/bin
    ANDROID_PLATFORM_TOOLS=${ANDROID_HOME}/platform-tools
    export PATH="${ANDROID_EMULATOR}":"${ANDROID_TOOLS}":"${ANDROID_BIN}":"${ANDROID_PLATFORM_TOOLS}":"${PATH}"

    # for google-cloud-sdk
    if [ -d "${HOME}/google-cloud-sdk/bin" ]; then
      export PATH="${HOME}/google-cloud-sdk/bin":"${PATH}"
    fi

    # MySQL
    MYSQL_PATH=$(brew --prefix mysql-client)
    export PATH="${MYSQL_PATH}/bin":"${PATH}"

    # PostgreSQL
    LIBPQ_PATH=$(brew --prefix libpq)
    export PATH="${LIBPQ_PATH}/bin:${PATH}"

    # Python binaries
    PYTHON_BINARIES=~/.local/bin
    export PATH="${PYTHON_BINARIES}:${PATH}"

    VSCODE_BIN=/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/
    export PATH="${VSCODE_BIN}:${PATH}"


    # my utilities
    export PATH=~/bin:"${PATH}"

    # for anyenv
    eval "$(anyenv init - zsh)"
fi

if [ -x nvim ]; then
    alias vim=nvim
fi

alias ls="ls --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
