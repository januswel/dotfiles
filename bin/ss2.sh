#!/bin/sh

# change location to save screenshots in Darwin

if [ "Darwin" != $(uname) ]; then
    exit 1
fi

PLIST="com.apple.screencapture"
KEY="location"

if [ $1 != "" ]; then
    defaults write ${PLIST} ${KEY} $1
else
    defaults delete ${PLIST} ${KEY}
fi

killall SystemUIServer
