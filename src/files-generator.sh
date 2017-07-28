
mkdir $WORKING_DIR/generator

while read fpath; do
    if [ -d $fpath ]; then
        echo "mkdir $fpath"
        echo
    elif [ -f $fpath ]; then
        sh $WORKING_DIR/src/file-writer.sh $fpath $fpath
    fi
done

