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
.zshenv
.editorconfig
bin
.config/zsh
.config/tmux
.config/vim
.config/dircolors
.config/npm
.config/git
.config/karabiner
.config/nvim
.config/mise
.config/gh/config.yml
.claude/CLAUDE.md
'

# symlinks that pointed into this repository before files were moved
stale='
.zprofile
.zshrc
.dir_colors
.tmux.conf
.vim
.vimrc
.gvimrc
.npmrc
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

unlink_stale() {
    rel=$1
    dst="$HOME/$rel"

    if [ ! -L "$dst" ]; then
        return
    fi

    case "$(readlink "$dst")" in
        "$dotfiles"/*)
            rm -f "$dst"
            echo "unlink: $dst"
            ;;
    esac
}

for rel in $stale; do
    unlink_stale "$rel"
done

for rel in $items; do
    link "$rel"
done

echo "done"
