
_ichipack_read_real_path() {
    local cwd="$(pwd)"
    local path="$1"

    while [ -n "$path" ]; do
        if [ "${path%/*}" != "$path" ]; then
            cd "${path%/*}"
        fi
        local name="${path##*/}"
        path="$(readlink "$name" || true)"
    done

    echo $(pwd)/$name
    cd "$cwd"
}

_ICHIPACK_SCRIPT_PATH="$(_ichipack_read_real_path $0)"

####################################################################################################
