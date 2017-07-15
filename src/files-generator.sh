
mkdir $WORKING_DIR/generator

while read fpath; do
    if [ -d $fpath ]; then
        echo "mkdir $fpath"
        echo
    elif [ -f $fpath ]; then
        hash=$(sha1sum $fpath | cut -b-40)
        charset=$(file -b --mime-encoding $fpath)
        if [ \( "$charset" = "us-ascii" -o "$charset" = "utf-8" \) -a $(grep '^' $fpath | wc -l) -eq $(cat $fpath | wc -l) ]; then
            echo "sed 's/^  //' <<\\EOF_$hash > $fpath"
            sed 's/^/  /' $fpath
            echo "EOF_$hash"
            echo
        else
            # 最後に改行がないファイル
            # またはバイナリファイル

            cat $fpath | gzip --to-stdout --no-name > $WORKING_DIR/generator/tmp.gz

            if [ $(wc -c < $WORKING_DIR/generator/tmp.gz) -ge $(wc -c < $fpath) ]; then
                # 圧縮しても小さくならない場合
                echo "sed 's/^  //' <<\\EOF_$hash | base64 -d > $fpath"
                base64 $fpath | sed 's/^/  /'
                echo "EOF_$hash"
                echo
            else
                # 圧縮すると小さくなる場合
                echo "sed 's/^  //' <<\\EOF_$hash | base64 -d | gunzip - > $fpath"
                cat $WORKING_DIR/generator/tmp.gz | base64 | sed 's/^/  /'
                echo "EOF_$hash"
                echo
            fi

        fi
    fi
done

