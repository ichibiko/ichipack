ICHIPACK_SOURCE_ACTION=
while [ $# -gt 0 ]; do
    if [ "$1" = "--ichipack-write-source" -o "$1" = "--ichipack-write-sources" ]; then
        if [ $# -lt 2 ]; then
            echo "--ichipack-write-sources needs argument" >&2
            exit 1
        fi
        ICHIPACK_SOURCE_ACTION="--ichipack-write-source"
        ICHIPACK_OUTPUT_DIR=$2
        shift
        shift
        break
    fi
    break
done

if [ "$ICHIPACK_SOURCE_ACTION" = "--ichipack-write-source" ]; then
    cat $0 | (
        mkdir -p $ICHIPACK_OUTPUT_DIR
        cd $ICHIPACK_OUTPUT_DIR
        if [ $(ls -a | wc -l) -gt 2 ]; then
            echo "Not empty directory: $ICHIPACK_OUTPUT_DIR" >&2
            exit 1
        fi
        perl -ne 'print $_ if $f; $f=1 if /^#%%%%HASH%%%%$/' | tar xzf -
    ) || exit $?
    exit
fi

####################################################################################################
