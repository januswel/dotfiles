#!/bin/sh

set -eux

# default settings
BAR="buz"

# environments
COMMAND_NAME=$(basename $0)

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

# options
while getopts fb: OPT
do
    case ${OPT} in
        "f" ) FLAG=1 ;;
        "b" ) BAR=${OPTARG} ;;
          * ) echo "Usage: ${COMMAND_NAME} [-f] [-b <arg>] <input>"
              exit 2 ;;
    esac
done

shift $(expr $OPTIND - 1)

# execute
ABSOLUTE_PATH=$(absolute_path "$1")
echo $ABSOLUTE_PATH
