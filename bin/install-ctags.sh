#!/bin/bash
VIM_DIRECTORY="$HOME/.vim"
CTAGS_VERSION="5.8"

CTAGS_SOURCE_DIR="$VIM_DIRECTORY/bin/ctags/install/source"
CTAGS_SOURCE_FILE="ctags-$CTAGS_VERSION.tar.gz"

# Compile ctags
cd $CTAGS_SOURCE_DIR
if [[ ! -d "$VIM_DIRECTORY/tmp/ctags-install" ]]; then
    mkdir -p "$VIM_DIRECTORY/tmp/ctags-install"
fi

cp "$CTAGS_SOURCE_FILE" "$VIM_DIRECTORY/tmp/ctags-install"
cd "$VIM_DIRECTORY/tmp/ctags-install"
tar xzf "$CTAGS_SOURCE_FILE"
cd "$VIM_DIRECTORY/tmp/ctags-install/ctags-$CTAGS_VERSION"
./configure --prefix=$HOME/.local && make && make install &&\
make clean && make distclean
rm -rf "$VIM_DIRECTORY/tmp/ctags-install/"
echo "Compiled and installed ctags succesfully!"
