#!/bin/sh

# default settings
BAR="buz"

# environments
COMMAND_NAME=$(basename $0)

# functions
absolute_path()
{
    CURRENT=$(dirname ".")
    echo $(cd $(dirname "$1") && pwd)/$(basename "$1")
    cd $CURRENT
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
