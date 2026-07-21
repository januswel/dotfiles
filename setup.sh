#!/bin/sh

# This script creates symlinks from `$HOME` to this repository
# It is idempotent; existing real files are kept with a warning.

set -eu

dotfiles=$(cd "$(dirname "$0")" && pwd)

# creating symlinks
items='
.bash_aliases
.bash_profile
.bashrc
.zprofile
.zshrc
.dir_colors
.tmux.conf
bin
.vim
.vimrc
.gvimrc
.npmrc
.editorconfig
.config/git
.config/karabiner
.config/nvim
.config/mise
.config/gh/config.yml
.claude/CLAUDE.md
'

link() {
    rel=$1
    src="$dotfiles/$rel"
    dst="$HOME/$rel"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        if [ "$(readlink "$dst")" = "$src" ]; then
            return
        fi
        rm -f "$dst"
    elif [ -e "$dst" ]; then
        echo "warn: $dst already exists, skipped" >&2
        return
    fi

    ln -s "$src" "$dst"
    echo "link: $dst -> $src"
}

for rel in $items; do
    link "$rel"
done

echo "done"
