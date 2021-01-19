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

if not type -q oh-my-posh
    printf "⌛ Install oh-my-posh\n"
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh3/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh

    mkdir ~/.poshthemes
    wget https://github.com/JanDeDobbeleer/oh-my-posh3/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
    unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
    chmod u+rw ~/.poshthemes/*.json
    rm ~/.poshthemes/themes.zip
    printf "✅ Install oh-my-posh\n"
end

if not type -q fisher
    printf "⌛ Install fisher\n"
    curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
    printf "✅ Install fisher\n"
end

printf "⌛ Install fish packages\n"
cat "$rootDir/fisher-plugins" | fisher install
printf "✅ Install fish packages\n"

printf "⌛ Install nodejs lts\n"
nvm install lts
nvm use lts
printf "✅ Install nodejs\n"

printf "⌛ Placing dot files\n"
_placeFiles $files ~
printf "✅ Placing dot files\n"

set_color yellow
echo "⚠ Please restart the terminal."
set_color normal
