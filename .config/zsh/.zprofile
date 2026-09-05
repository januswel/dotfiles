# .zprofile
# janus_wel <janus.wel.3@gmail.com>

source ~/bin/setup_flexible_vars.sh
source ~/bin/utils.sh

# environment variables
export EDITOR="/usr/bin/vim"
export SHELL="/bin/zsh"
export LESS="-gj5"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"

if [ "Darwin" = `uname` ]; then
    export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
fi

# vim: ts=4 sw=4 sts=0 et
