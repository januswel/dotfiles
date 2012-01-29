# .zprofile
# janus_wel <janus.wel.3@gmail.com>

# environment variables
export EDITOR="/usr/bin/vim"
export SHELL="/bin/zsh"
export LESS="-gj5"

if [ "Darwin" = `uname` ]; then
    export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
fi

# available my utility tools
export PATH=~/bin:$PATH

# vim: ts=4 sw=4 sts=0 et
