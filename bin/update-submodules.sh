#!/bin/bash

#echo "Updating plugins..."
cd $HOME/.vim
git submodule foreach git pull origin master

cd bundle/vimproc
make clean all
