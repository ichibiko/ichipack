
if [ -e .ichipackignore ]; then
    # .ichipackignore を .gitignore にして git check-ignore で対象ファイルを判定するために
    # 対象ディレクトリをコピー
    mkdir -p $WORKING_DIR/var/ls
    curr=$(pwd)
    find . | grep -v -E '^\.($|/\.git$|/\.git/|/\.gitignore$)' | cut -b3- | while read fpath; do
        if [ -d $fpath ]; then
            mkdir $WORKING_DIR/var/ls/$fpath
        elif [ -f $fpath ]; then
            ln -s $curr/$fpath $WORKING_DIR/var/ls/$fpath
        fi
    done
    cd $WORKING_DIR/var/ls
    git init >/dev/null
    mv .ichipackignore .gitignore
fi

if [ ! -e .git ]; then
    find .
else
    find . | grep -v -E '^\.($|/\.git$|/\.git/|/\.gitignore$)' | while read fpath; do
        if git check-ignore -q "$fpath"; then
            continue
        fi
        echo "$fpath"
    done
fi | cut -b3- | LC_ALL=C sort | while read fpath; do
    if [ -z "$fpath" ]; then
        continue
    fi
    echo $fpath
done

