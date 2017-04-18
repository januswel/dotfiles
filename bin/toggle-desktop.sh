#!/bin/sh

# toggle showing files or not on desktop in Darwin

if [ "Darwin" != $(uname) ]; then
    exit 1
fi

PLIST="com.apple.finder"
KEY="CreateDesktop"

STATUS=$(defaults read ${PLIST} ${KEY})

if [ ${STATUS} -eq 0 ]; then
    defaults write ${PLIST} ${KEY} -boolean true
else
    defaults write ${PLIST} ${KEY} -boolean false
fi

killall Finder
