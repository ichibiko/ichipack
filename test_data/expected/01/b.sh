#!/bin/sh

####################################################################################################

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

trap "rm -rf $WORKING_DIR" EXIT

####################################################################################################

ichipack_generate_targets() {
mkdir etc

sed 's/^  //' <<\EOF_ebee610aeea08f14165bfc526009d948074fbda0 > etc/data.txt
  data1
  data2
EOF_ebee610aeea08f14165bfc526009d948074fbda0

sed 's/^  //' <<\EOF_7a68fbba1b87cf150c9cdfecf0641b259e87b6f2 > main.sh
  
  echo "test"
  
  cat $WORKING_DIR/etc/data.txt
  
EOF_7a68fbba1b87cf150c9cdfecf0641b259e87b6f2

}
(
    cd $WORKING_DIR
    ichipack_generate_targets
)

####################################################################################################

echo "test"

cat $WORKING_DIR/etc/data.txt

####################################################################################################
