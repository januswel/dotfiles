#!/bin/sh

# shellcheck disable=SC2139
# shellcheck disable=SC1090

# environment variables
export CPLUS_INCLUDE_PATH=/usr/local/include:"${CPLUS_INCLUDE_PATH}"
export LD_LIBRARY_PATH=/usr/local/lib:"${LD_LIBRARY_PATH}"

# settings for macOS
if [ "Darwin" = "$(uname)" ]; then
  # HomeBrew
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # coreutils
  COREUTILS_PATH=$(brew --prefix coreutils)
  export PATH="${COREUTILS_PATH}/libexec/gnubin":"${PATH}"

  # mise
  eval "$(mise activate zsh)"

  # Git
  GIT_PATH=$(brew --prefix git)
  export PATH="${GIT_PATH}/bin":"${PATH}"

  # Java
  JAVA_HOME=$(/usr/libexec/java_home -v 25)
  export JAVA_HOME
  export PATH="${JAVA_HOME}/bin":"${PATH}"
  alias java="java -Dfile.encoding=UTF-8"
  alias javac="javac -J-Dfile.encoding=UTF-8"

  # Android development
  export ANDROID_HOME="${HOME}/Library/Android/sdk"
  ANDROID_EMULATOR=${ANDROID_HOME}/emulator
  ANDROID_TOOLS=${ANDROID_HOME}/tools
  ANDROID_BIN=${ANDROID_HOME}/tools/bin
  ANDROID_PLATFORM_TOOLS=${ANDROID_HOME}/platform-tools
  export PATH="${ANDROID_EMULATOR}":"${ANDROID_TOOLS}":"${ANDROID_BIN}":"${ANDROID_PLATFORM_TOOLS}":"${PATH}"

  # VSCode
  VSCODE_BIN=/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/
  export PATH="${VSCODE_BIN}:${PATH}"

  # Google Cloud
  GCP_SDK_PATH_FILE=~/lib/google-cloud-sdk/path.zsh.inc
  if [ -f ${GCP_SDK_PATH_FILE} ]; then
    . ${GCP_SDK_PATH_FILE}
  fi
  GCP_SDK_COMPLETE_FILE=~/lib/google-cloud-sdk/completion.zsh.inc
  if [ -f ${GCP_SDK_COMPLETE_FILE} ]; then
    . ${GCP_SDK_COMPLETE_FILE}
  fi

  # my utilities
  export PATH=~/bin:"${PATH}"
fi

if [ -x nvim ]; then
  alias vim=nvim
fi

alias ls="ls --color=auto"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
