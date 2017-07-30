
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
