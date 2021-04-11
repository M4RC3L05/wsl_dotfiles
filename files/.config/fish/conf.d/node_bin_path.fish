function _node_binpath_cwd --on-variable PWD
    status --is-command-substitution; and return

    set -l node_modules_path "$PWD/node_modules/.bin"
    if test -e "$node_modules_path"
        if not contains "$node_modules_path" $PATH
            set -g __node_binpath "$node_modules_path"
            set -x PATH $PATH $__node_binpath
        end
    else
        set -q __node_binpath
        and set -l index (contains -i -- $__node_binpath $PATH)
        and set -e PATH[$index]
        and set -e __node_binpath
    end
end
