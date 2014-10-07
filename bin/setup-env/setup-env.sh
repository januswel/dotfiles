#!/bin/sh

# targets
targets=( \
    "bin" \
    ".bash_aliases" \
    ".bash_profile" \
    ".bashrc" \
    ".dir_colors" \
    ".gitconfig" \
    ".gitignore" \
    ".gvimrc" \
    ".tidyrc" \
    ".tmux.conf" \
    ".vim" \
    ".vimperator" \
    ".vimperatorrc" \
    ".vimrc" \
    ".zprofile" \
    ".zshrc" \
)

# functions
function get_script_dir() {
    echo "$(dirname "${BASH_SOURCE:-$0}")"
    return 0
}

function absolute_dir() {
    if [ $# -ne 1 ]; then
        echo 'Usage: absolute_dir DIR' 1>&2
        return 1
    fi

    echo "$(cd "$1"; pwd)"
    return 0
}

function absolute_leaf() {
    if [ $# -ne 1 ]; then
        echo 'Usage: absolute_dir FILE' 1>&2
        return 1
    fi

    echo ""$(absolute_dir "$(dirname "$1")")"/"$(basename "$1")""
    return 0
}


# main
script_dir="$(absolute_dir "$(get_script_dir)")"
cd $script_dir

src_dir="$(absolute_dir "$script_dir/..")"
dst_dir="$(absolute_dir "${HOME}")"

for target in "${targets[@]}"; do
    src="$src_dir/$target"
    dst="$dst_dir/$target"
    #echo $src
    #echo $dst

    if [ ! -e $src ]; then
        echo "The source path does'nt exist: $target" 1>&2
        continue
    fi
    if [ -e $dst ]; then
        echo "The destination path already exists: $target" 1>&2
        continue
    fi

    command="ln -s "$src" "$dst""
    echo $command
    $($command)
done

exit 0
