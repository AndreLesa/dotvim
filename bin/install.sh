#!/bin/bash
VIM_DIRECTORY=~/.vim

cd ~
git clone https://github.com/moljac024/dotvim.git $VIM_DIRECTORY
ln -s $VIM_DIRECTORY/vimrc ~/.vimrc
cd $VIM_DIRECTORY
git submodule init
git submodule update

if [[ ! -f $HOME/.local/bin/ctags ]]; then
    cd $VIM_DIRECTORY
    ./bin/install-ctags.sh
fi

