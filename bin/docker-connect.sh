#!/bin/sh

command="docker-machine"
action="env"

which ${command} > /dev/null
if [ "$?" -ne 0 ]; then
    echo "$command is not installed"
fi

if [ "$1" != "" ]; then
    eval "$(${command} ${action} $1)"
else
    unset DOCKER_MACHINE_NAME
    unset DOCKER_CERT_PATH
    unset DOCKER_HOST
    unset DOCKER_TLS_VERIFY
fi
