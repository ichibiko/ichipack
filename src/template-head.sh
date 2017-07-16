#!/bin/sh

####################################################################################################

if [ -z "$WORKING_DIR" ]; then
    if [ -z "$UID" ]; then
        UID=$(id -u)
    fi
    if [ -d /run/user/$UID ]; then
        export WORKING_DIR=$(mktemp -d /run/user/$UID/ichipack-XXXXXXXX)
    elif [ -d /dev/shm ]; then
        export WORKING_DIR=$(mktemp -d /dev/shm/ichipack-XXXXXXXX)
    else
        export WORKING_DIR=$(mktemp -d)
    fi
else
    export WORKING_DIR=$WORKING_DIR/.ttr/child-$$
    mkdir $WORKING_DIR
fi

trap "rm -rf $WORKING_DIR" EXIT

####################################################################################################
