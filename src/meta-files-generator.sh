
OPTION_SELF_BUILD=
OPTION_BIN_ICHIPACK=

while [ $# -gt 0 ]; do
    if [ "$1" = "--self-build" ]; then
        OPTION_SELF_BUILD=$1
    elif [ "$1" = "--bin-ichipack" ]; then
        OPTION_BIN_ICHIPACK=$1
    fi
    shift
done

echo '    mkdir -p .ichipack/bin'
echo

if [ -n "$OPTION_BIN_ICHIPACK" ]; then
    if [ -z "$OPTION_SELF_BUILD" ]; then
        sh $WORKING_DIR/src/file-writer.sh $_ICHIPACK_SCRIPT_PATH .ichipack/bin/ichipack
        echo "chmod 700 .ichipack/bin/ichipack"
    else
        # ichipackセルフビルド

        echo 'ln -s $_ICHIPACK_SCRIPT_PATH .ichipack/bin/ichipack'
    fi
fi

