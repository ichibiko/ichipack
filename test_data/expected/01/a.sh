#!/bin/sh

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

mkdir $WORKING_DIR/etc
cat <<\EOF_ebee610aeea08f14165bfc526009d948074fbda0 > $WORKING_DIR/etc/data.txt
data1
data2
EOF_ebee610aeea08f14165bfc526009d948074fbda0

cat <<\EOF_7a68fbba1b87cf150c9cdfecf0641b259e87b6f2 > $WORKING_DIR/main.sh

echo "test"

cat $WORKING_DIR/etc/data.txt

EOF_7a68fbba1b87cf150c9cdfecf0641b259e87b6f2


echo "test"

cat $WORKING_DIR/etc/data.txt

