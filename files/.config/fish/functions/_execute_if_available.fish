
function _execute_if_available
    if type -q $argv[1]
        eval $argv[1] $argv[2..-1]
    else
        echo "Command \"$argv[1]\" not found."
    end
end
