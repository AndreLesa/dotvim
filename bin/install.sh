#!/bin/bash
VIM_DIRECTORY=~/.vim

cd ~
git clone https://github.com/moljac024/dotvim.git $VIM_DIRECTORY
ln -s $VIM_DIRECTORY/vimrc ~/.vimrc
cd $VIM_DIRECTORY
git submodule init
git submodule update

# Compile command-t extension
cd $VIM_DIRECTORY/bundle/command-t/ruby/command-t
ruby extconf.rb && make && make clean && make distclean &&\
echo "Compiled command-t c extension succesfully!"

# Compile ctags
CTAGS_SOURCE_DIR=$VIM_DIRECTORY/ctags/install/source
CTAGS_SOURCE_FILE=ctags-5.8.tar.gz
cd $CTAGS_SOURCE_DIR
if [[ ! -d $VIM_DIRECTORY/tmp ]]; then
    mkdir -p $VIM_DIRECTORY/tmp/ctags-install
fi
cp $CTAGS_SOURCE_FILE $VIM_DIRECTORY/tmp/ctags-install
cd $VIM_DIRECTORY/tmp/ctags-install
tar xzf $CTAGS_SOURCE_FILE
./configure --prefix=$HOME/.local && make && make install &&\
make clean && make distclean
echo "Compiled and installed ctags succesfully!"
