
fpath=
target=
OPTION_PERM=

while [ $# -gt 0 ]; do
    if [ "$1" = "--perm" ]; then
        OPTION_PERM=$1
    elif [ -z "$fpath" ]; then
        fpath=$1
    elif [ -z "$target" ]; then
        target=$1
    fi
    shift
done

hash=$(sha1sum $fpath | cut -b-40)
charset=$(file -b --mime-encoding $fpath)

if [ -n "$OPTION_PERM" ]; then
    target_ln="$target"
    target="\$HOME/.ichipack/file-$hash/content"
    echo "mkdir -p \$HOME/.ichipack/file-$hash"
    echo "chmod 700 \$HOME/.ichipack"
    echo "if [ ! -e \"$target\" ]; then"
    echo "    touch \$HOME/.ichipack/file-$hash/create.touch"
fi

if [ \( "$charset" = "us-ascii" -o "$charset" = "utf-8" \) -a $(grep '^' $fpath | wc -l) -eq $(cat $fpath | wc -l) ]; then
    echo "sed 's/^  //' <<\\EOF_$hash > $target"
    sed 's/^/  /' $fpath
    echo "EOF_$hash"
    echo
else
    # 最後に改行がないファイル
    # またはバイナリファイル

    cat $fpath | gzip --to-stdout --no-name > $WORKING_DIR/generator/tmp.gz

    if [ $(wc -c < $WORKING_DIR/generator/tmp.gz) -ge $(wc -c < $fpath) ]; then
        # 圧縮しても小さくならない場合
        echo "sed 's/^  //' <<\\EOF_$hash | base64 -d > $target"
        base64 $fpath | sed 's/^/  /'
        echo "EOF_$hash"
        echo
    else
        # 圧縮すると小さくなる場合
        echo "sed 's/^  //' <<\\EOF_$hash | base64 -d | gunzip - > $target"
        cat $WORKING_DIR/generator/tmp.gz | base64 | sed 's/^/  /'
        echo "EOF_$hash"
        echo
    fi
fi

if [ -n "$OPTION_PERM" ]; then
    echo "fi"
    echo "touch \$HOME/.ichipack/file-$hash/use.touch"
    echo "ln -s $target $target_ln"
fi
