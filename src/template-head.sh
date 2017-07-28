#!/bin/sh

####################################################################################################

if [ -z "$UID" ]; then
    UID=$(id -u)
fi
if [ -d /run/user/$UID ]; then
    export WORKING_DIR=$(mktemp -d /run/user/$UID/ichipack-XXXXXXXX)
    export HARD_WORKING_DIR=$(mktemp -d /tmp/ichipack-XXXXXXXX)
elif [ -d /dev/shm ]; then
    export WORKING_DIR=$(mktemp -d /dev/shm/ichipack-XXXXXXXX)
    export HARD_WORKING_DIR=$(mktemp -d /tmp/ichipack-XXXXXXXX)
else
    export WORKING_DIR=$(mktemp -d /tmp/ichipack-soft-XXXXXXXX)
    export HARD_WORKING_DIR=$(mktemp -d /tmp/ichipack-hard-XXXXXXXX)
fi

trap "rm -rf $WORKING_DIR $HARD_WORKING_DIR" EXIT

####################################################################################################
