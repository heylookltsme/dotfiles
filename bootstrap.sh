#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {

    # load libs
    source ./lib/utils.sh
    source ./lib/npm.sh

    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude ".osx" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "LICENSE-MIT.txt" \
        -avh --no-perms . ~;

    # Install vim plugins
    vim +PlugInstall +qall!

    # Install global node modules
    run_npm

    # Fix italics
    tic -o ~/.terminfo ./lib/xterm-256color.terminfo.txt

    # Change default shell to zsh
    chsh -s /bin/zsh
    exec zsh
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;
unset doIt;
