#!/bin/sh

TARGET_DIR=
OUTPUT_FILEPATH=

while [ $# -gt 0 ]; do
    if [ "$1" = "-d" ]; then
        TARGET_DIR=$2
        shift
    elif [ "$1" = "-o" ]; then
        OUTPUT_FILEPATH=$2
        shift
    fi
    shift
done

if [ -z "$TARGET_DIR" ]; then
    TARGET_DIR=.
fi

if [ ! -e $TARGET_DIR/main.sh ]; then
    echo "Not found: $TARGET_DIR/main.sh" >&2
    exit 1
fi

if [ -e $TARGET_DIR/.git -o -e $TARGET_DIR/.ichipackignore ]; then
    if ! which git >/dev/null; then
        echo "git not found" >&2
        exit 1
    fi
fi

if [ -n "$OUTPUT_FILEPATH" ]; then
    exec > $OUTPUT_FILEPATH
fi

cat $WORKING_DIR/src/template-head.sh

(
    cd $TARGET_DIR

    echo "ichipack_generate_targets() {"
    sh $WORKING_DIR/src/ls-target.sh | sh $WORKING_DIR/src/files-generator.sh
    echo "}"
)

echo "("
echo "    cd \$WORKING_DIR"
echo "    ichipack_generate_targets"
echo ")"

cat $TARGET_DIR/main.sh

