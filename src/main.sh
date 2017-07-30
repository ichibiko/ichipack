#!/bin/sh

TARGET_DIR=
OUTPUT_FILEPATH=/dev/stdout
OPTION_SELF_BUILD=
OPTION_BIN_ICHIPACK="--bin-ichipack"
OPTION_SOURCE="--source"

while [ $# -gt 0 ]; do
    if [ "$1" = "-d" ]; then
        TARGET_DIR=$2
        shift
    elif [ "$1" = "-o" ]; then
        OUTPUT_FILEPATH=$2
        shift
    elif [ "$1" = "--self-build" ]; then
        OPTION_SELF_BUILD=$1
    elif [ "$1" = "--bin-ichipack" ]; then
        OPTION_BIN_ICHIPACK=$1
    elif [ "$1" = "--no-bin-ichipack" ]; then
        OPTION_BIN_ICHIPACK=
    elif [ "$1" = "--source" ]; then
        OPTION_SOURCE=$1
    elif [ "$1" = "--sources" ]; then
        OPTION_SOURCE="--source"
    elif [ "$1" = "--no-source" ]; then
        OPTION_SOURCE=
    elif [ "$1" = "--no-sources" ]; then
        OPTION_SOURCE=
    fi
    shift
done

if [ -z "$TARGET_DIR" ]; then
    TARGET_DIR=.
fi

mkdir -p $WORKING_DIR/var

if [ -f "$TARGET_DIR" ]; then
    mkdir $WORKING_DIR/var/target
    cp $TARGET_DIR $WORKING_DIR/var/target/main.sh
    TARGET_DIR=$WORKING_DIR/var/target
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

export SEPARATOR=$(head -c 100 /dev/zero | sed -e 's/\x00/#/g')

(

    (
        cd $TARGET_DIR

        echo "ichipack_generate_targets() {"
        sh $WORKING_DIR/src/ls-target.sh > $WORKING_DIR/var/targets.txt
        cat $WORKING_DIR/var/targets.txt | sh $WORKING_DIR/src/files-generator.sh
        echo "}"
    )

    echo "("
    echo "    cd \$WORKING_DIR"
    echo "    ichipack_generate_targets"
    echo ")"
    echo
    echo $SEPARATOR
    echo
    echo "("
    echo "    cd \$WORKING_DIR"
    echo
    sh $WORKING_DIR/src/meta-files-generator.sh $OPTION_SELF_BUILD $OPTION_BIN_ICHIPACK
    echo
    echo ")"
    echo 'PATH="$WORKING_DIR/.ichipack/bin:$PATH"'
    echo
    echo $SEPARATOR

    (
        cd $TARGET_DIR
        perl $WORKING_DIR/src/switch-action.pl
    )

) > $WORKING_DIR/var/output.sh

if [ -z "$OPTION_SOURCE" ]; then
    (
        cat $WORKING_DIR/src/template-head.sh
        cat $WORKING_DIR/src/template-head-func.sh
        echo

        cat $WORKING_DIR/var/output.sh

        echo $SEPARATOR
    ) > $OUTPUT_FILEPATH
else
    output_hash=$(sha1sum $WORKING_DIR/var/output.sh | cut -b-40)

    (
        cat $WORKING_DIR/src/template-head.sh
        cat $WORKING_DIR/src/template-head-func.sh
        echo
        cat $WORKING_DIR/src/template-head-sources.sh | sed "s/%%%%HASH%%%%/$output_hash/g"
        echo
        cat $WORKING_DIR/var/output.sh
        echo
        echo "exit $?"
        echo $SEPARATOR
        echo "#$output_hash"

        (
            cd $TARGET_DIR

            (
                cat $WORKING_DIR/var/targets.txt
                sh $WORKING_DIR/src/ls-source.sh
            ) | LC_ALL=C sort | LC_ALL=C uniq | while read fpath; do
                if [ -f $fpath ]; then
                    echo "$fpath"
                fi
            done > $WORKING_DIR/var/sources.txt
            tar cz --to-stdout --files-from $WORKING_DIR/var/sources.txt | cat
        )
    ) > $OUTPUT_FILEPATH
fi

