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
sed 's/^  //' <<\EOF_15da8006a8a6a7a3022639c048e1d1742f2b3f9c > $WORKING_DIR/etc/exists-lf.txt
  exists new line
  at end of file
EOF_15da8006a8a6a7a3022639c048e1d1742f2b3f9c

sed 's/^  //'  <<\EOF_d4e1aebe6d7e4db0fc3c176f947a51b5e28a89ca | base64 -d > $WORKING_DIR/etc/no-lf.txt
  bm8gbmV3IGxpbmUKYXQgZW5kIG9mIGZpbGU=
EOF_d4e1aebe6d7e4db0fc3c176f947a51b5e28a89ca

sed 's/^  //' <<\EOF_3f14f062ed11d6580e72ef115e37288159a560f4 > $WORKING_DIR/main.sh
  cat $WORKING_DIR/etc/no-lf.txt
  cat $WORKING_DIR/etc/exists-lf.txt
EOF_3f14f062ed11d6580e72ef115e37288159a560f4

cat $WORKING_DIR/etc/no-lf.txt
cat $WORKING_DIR/etc/exists-lf.txt
