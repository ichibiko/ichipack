
while read fpath; do
    if [ -d $fpath ]; then
        echo "mkdir $fpath"
    elif [ -f $fpath ]; then
        hash=$(sha1sum $fpath | cut -b-40)
         if [ $(grep '^' $fpath | wc -l) -eq $(cat $fpath | wc -l) ]; then
            echo "sed 's/^  //' <<\\EOF_$hash > $fpath"
            sed 's/^/  /' $fpath
            echo "EOF_$hash"
            echo
        else
            # 最後に改行がないファイル
            echo "sed 's/^  //'  <<\\EOF_$hash | base64 -d > $fpath"
            base64 $fpath | sed 's/^/  /'
            echo "EOF_$hash"
            echo
        fi
    fi
done

