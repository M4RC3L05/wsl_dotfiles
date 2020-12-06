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

if not type -q starship
    printf "⌛ Install starship\n"
    curl -fsSL https://starship.rs/install.sh | bash > /dev/null
    printf "\033[A\33[2K\r✅ Install starship\n"
end

if not type -q fisher
    printf "⌛ Install fisher\n"
    curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher > /dev/null
    printf "\033[A\33[2K\r✅ Install fisher\n"
end

printf "⌛ Install fish packages\n"
cat "$rootDir/fisher-plugins" | fisher install > /dev/null
printf "\033[A\33[2K\r✅ Install fish packages\n"

printf "⌛ Install nodejs lts\n"
nvm install lts > /dev/null
printf "\033[A\33[2K\r✅ Install nodejs\n"

printf "⌛ Placing dot files\n"
_placeFiles $files ~
printf "\033[A\33[2K\r✅ Placing dot files\n"

set_color yellow
echo "⚠ Please dot source config file like: . ~/.config/fish/config.fish"
set_color normal
