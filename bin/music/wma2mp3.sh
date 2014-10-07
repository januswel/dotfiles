#!/bin/sh

# default settings
BITRATE=128k
SAMPLING_RATE=44100
CHANNEL=2

# environments
COMMAND_NAME=$(basename $0)

# functions
wma2mp3()
{
    INPUT=$1

    if [ "" == ${INPUT} ]; then
        echo "Specify input file." 1>&2
        exit 1;
    fi

    INPUT_EXTENSION=${INPUT##*.}

    if [ "wma" != ${INPUT_EXTENSION} ]; then
        echo "Specify wma file." 1>&2
        exit 1;
    fi

    MP3_EXTENSION=.mp3
    INPUT_DIR=$(dirname ${INPUT})
    INPUT_FILE=$(basename ${INPUT})
    INPUT_FILEBASE=${INPUT_FILE%.*}
    OUTPUT=${INPUT_DIR}/${INPUT_FILEBASE}${MP3_EXTENSION}

    ${FFMPEG} -y -i ${INPUT} -ab ${BITRATE} -ac ${CHANNEL} -ar ${SAMPLING_RATE} ${OUTPUT}
}

# search tool
FFMPEG=$(which ffmpeg)

if [ "" == ${FFMPEG} ]; then
    echo "Install ffmpeg and make a path to ffmpeg." 1>&2
    exit 2;
fi

# options
while getopts b:r:ms OPT
do
    case ${OPT} in
        "b" ) BITRATE=${OPTARG} ;;
        "r" ) SAMPLING_RATE=${OPTARG} ;;
        "m" ) CHANNEL=1 ;;
        "s" ) CHANNEL=2 ;;
          * ) echo "Usage: ${COMMAND_NAME} [-b <bitrate>] [-r <sampling_rate>] [-m] [-s] <input>"
              exit 3 ;;
    esac
done

shift $(expr $OPTIND - 1)

# execute
for SRC in "$@"
do
    wma2mp3 "${SRC}"
done
