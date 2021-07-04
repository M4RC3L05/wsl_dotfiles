#!/bin/fish

set -l rootDir (cd (dirname (status -f)); and pwd)
set -l realFishDir "~/.config/fish"
set -l files "$rootDir/files"

function _placeFiles
    # Sets source root dir
    set -l root $argv[1]
    # Sets destination dir
    set -l to $argv[2]

    for file in $root/.* $root/*
        # If source file if a directory call _placeFiles recursivly with new source, and destination root
        if test -d $file
            set -l bn (basename $file)
            _placeFiles "$root/$bn" "$to/$bn"
        else
            # Path of potentialy already existting file
            set -l replaced (string replace -a "$root" "$to" "$file")
            # Gets folder name of containing existing file
            set -l dn (dirname $replaced)
            # Gets file name of already existsing file
            set -l bn (basename $replaced)

            # If the folder name do not exists, create it
            if not test -d $dn
                mkdir -p $dn
            end

            # If potentialy already existting file exists remove it in order to update with new version
            if test -e $replaced
                rm -rf $replaced
            end

            # Symlink local file with path of potentialy already existting file
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
