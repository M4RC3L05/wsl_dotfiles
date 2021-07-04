#!/bin/fish

set -l rootDir (cd (dirname (status -f)); and pwd)
set -l realFishDir "~/.config/fish"
set -l files "$rootDir/files"

function _placeFiles
    set -l root $argv[1]
    set -l to $argv[2]

    for file in $root/.* $root/*
        if test -d $file
            set -l bn (basename $file)
            _placeFiles "$root/$bn" "$to/$bn"
        else
            set -l replaced (string replace -a "$root" "$to" "$file")
            set -l dn (dirname $replaced)
            set -l bn (basename $replaced)

            if not test -d $dn
                mkdir -p $dn
            end

            if test -e $replaced
                rm -rf $replaced
            end

            ln -s $file $replaced
        end
    end
end

if not type -q fisher
    printf "⌛ Install fisher\n"
    curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
    printf "✅ Install fisher\n"
end

printf "⌛ Placing dot files\n"
_placeFiles $files ~
printf "✅ Placing dot files\n"

printf "⌛ Install fish packages\n"
fisher update
printf "✅ Install fish packages\n"

set_color yellow
echo "⚠ Please restart the terminal."
set_color normal
