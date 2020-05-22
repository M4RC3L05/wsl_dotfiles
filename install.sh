#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REAL_FISH_DIR=~/.config/fish
 
([ -L ~/.gitconfig ] || [ -e ~/.gitconfig ]) && rm -rf ~/.gitconfig
ln -s $ROOT/gitconfig ~/.gitconfig 

[ ! -d "$REAL_FISH_DIR" ] && {
    echo "Fish may not be installed skiping..."
    exit
}

[ ! -x  /usr/local/bin/starship ] && {
    echo "Install starship"
    curl -fsSL https://starship.rs/install.sh | bash
}

echo "Symlink $ROOT/starship.toml to ~/.config/starship.toml"
[ ! -d ~/.config ] && mkdir ~/.config
([ -L ~/.config/starship.toml ] || [ -e ~/.config/starship.toml ]) && rm -rf ~/.config/starship.toml
ln -s $ROOT/starship.toml ~/.config/starship.toml

[ ! -d "$REAL_FISH_DIR/functions" ] && mkdir -p $REAL_FISH_DIR/functions

echo "Placing config.fish..."
([ -L "$REAL_FISH_DIR/config.fish" ] || [ -e "$REAL_FISH_DIR/config.fish" ]) && rm -rf $REAL_FISH_DIR/config.fish
ln -s $ROOT/fish/config.fish $REAL_FISH_DIR/config.fish

echo "Placing functions..."
for fish_function in $ROOT/fish/functions/*; do
    filename=$(basename $fish_function)
    ([ -L "$REAL_FISH_DIR/functions/$filename" ] || [ -e "$REAL_FISH_DIR/functions/$filename" ]) && rm -rf $REAL_FISH_DIR/functions/$filename
    ln -s $fish_function $REAL_FISH_DIR/functions/$filename
done

echo "Install fisher..."
fish -c "curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher"

echo "Install fish packages"
[ ! $(fish -c "fisher list jorgebucaran/fish-nvm") ] && {
    echo "Install jorgebucaran/fish-nvm"
    fish -c "fisher install jorgebucaran/fish-nvm"
}
[ ! $(fish -c "fisher list edc/bass") ] && {
    echo "Install edc/bass"
    fish -c "fisher install edc/bass"
}
[ ! $(fish -c "fisher list oh-my-fish/plugin-node-binpath") ] && {
    echo "Install oh-my-fish/plugin-node-binpath"
    fish -c "fisher install oh-my-fish/plugin-node-binpath"
}
[ ! $(fish -c "fisher list danhper/fish-ssh-agent") ] && {
    echo "Install danhper/fish-ssh-agent"
    fish -c "fisher install danhper/fish-ssh-agent"
}

echo "Install nodejs lts"
fish -c "nvm use lts"
