#!/bin/bash

cd ~
git clone https://github.com/moljac024/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodule init
git submodule update

cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb && make && echo "Compiled command-t c extension succesfully!"
