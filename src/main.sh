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

if [ -e $TARGET_DIR/.git ]; then
    if ! which git >/dev/null; then
        echo "git not found" >&2
        exit 1
    fi
fi

if [ -n "$OUTPUT_FILEPATH" ]; then
    exec > $OUTPUT_FILEPATH
fi

cat <<\EOF
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

EOF

(
    cd $TARGET_DIR

    sh $WORKING_DIR/src/ls-target.sh | while read fpath; do
        if [ -d $fpath ]; then
            echo "mkdir \$WORKING_DIR/$fpath"
        elif [ -f $fpath ]; then
            hash=$(sha1sum $fpath | cut -b-40)

            if [ $(grep '^' $fpath | wc -l) -eq $(cat $fpath | wc -l) ]; then
                echo "sed 's/^  //' <<\\EOF_$hash > \$WORKING_DIR/$fpath"
                sed 's/^/  /' $fpath
                echo "EOF_$hash"
                echo
            else
                # 最後に改行がないファイル
                echo "sed 's/^  //'  <<\\EOF_$hash | base64 -d > \$WORKING_DIR/$fpath"
                base64 $fpath | sed 's/^/  /'
                echo "EOF_$hash"
                echo
            fi
        fi
    done
)

cat $TARGET_DIR/main.sh

