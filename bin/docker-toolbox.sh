#!/bin/sh

which docker-machine > /dev/null
if [ "$?" -eq 0 ]; then
    eval "$(docker-machine env default)"
fi
