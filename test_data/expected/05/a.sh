#!/bin/bash

####################################################################################################

_ICHIPACK_CLEAN=1

while [ $# -gt 0 ]; do
    if [ "$1" = "--ichipack-no-clean" ]; then
        _ICHIPACK_CLEAN=
        shift
    else
        break
    fi
done

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

mkdir $WORKING_DIR/.ichipack
touch $WORKING_DIR/.ichipack/create.touch
touch $WORKING_DIR/.ichipack/use.touch

if [ -n "$_ICHIPACK_CLEAN" ]; then
    trap "rm -rf $WORKING_DIR $HARD_WORKING_DIR" EXIT
else
    echo "WORKING_DIR:      $WORKING_DIR" >&2
    echo "HARD_WORKING_DIR: $HARD_WORKING_DIR" >&2
fi

####################################################################################################

_ichipack_read_real_path() {
    local cwd="$(pwd)"
    local path="$1"

    while [ -n "$path" ]; do
        if [ "${path%/*}" != "$path" ]; then
            cd "${path%/*}"
        fi
        local name="${path##*/}"
        path="$(readlink "$name" || true)"
    done

    echo $(pwd)/$name
    cd "$cwd"
}

_ICHIPACK_SCRIPT_PATH="$(_ichipack_read_real_path $0)"

####################################################################################################

ichipack_generate_targets() {
sed 's/^  //' <<\EOF_0094413a37b8d8788a890c696de4cf79c0b091b2 > main.sh
  
  echo "TEST '$1' '$2'"
  
  cat $WORKING_DIR/data.txt
  
EOF_0094413a37b8d8788a890c696de4cf79c0b091b2

sed 's/^  //' <<\EOF_4e1243bd22c66e76c2ba9eddc1f91394e57f9f83 > data.txt
  test
EOF_4e1243bd22c66e76c2ba9eddc1f91394e57f9f83

}
(
    cd $WORKING_DIR
    ichipack_generate_targets
)

####################################################################################################

(
    cd $WORKING_DIR

    mkdir -p .ichipack/bin


)
PATH="$WORKING_DIR/.ichipack/bin:$PATH"

####################################################################################################
. $WORKING_DIR/main.sh
####################################################################################################
