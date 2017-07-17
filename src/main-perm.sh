
PERM_UUID=
TARGET_DIR=

while [ $# -gt 0 ]; do
    if [ -z "$PERM_UUID" ]; then
        PERM_UUID=$1
    elif [ -z "$TARGET_DIR" ]; then
        TARGET_DIR=$1
    fi
    shift
done

if [ -z "$PERM_UUID" ]; then
    echo "No specified PERM_UUID" >&2
    exit 1
fi
if [ -z "$TARGET_DIR" ]; then
    echo "No specified TARGET_DIR" >&2
    exit 1
fi

if ! expr "$PERM_UUID" : '^[-0-9a-f]\+$' >/dev/null; then
    echo "Invalid PERM_UUID: $PERM_UUID" >&2
    exit 1
fi

if [ -e $TARGET_DIR ]; then
    echo "Already exists: $TARGET_DIR" >&2
    exit 1
fi

PERM_DIR=$HOME/.ichipack/perm-$PERM_UUID
mkdir -p $PERM_DIR
touch $PERM_DIR.touch
chmod 700 $HOME/.ichipack
mkdir -p $(dirname $TARGET_DIR)
ln -s $PERM_DIR $TARGET_DIR

