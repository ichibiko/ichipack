
if [ ! -e .git ]; then
    find .
else
    find . | while read fpath; do
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

