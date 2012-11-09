#!/bin/bash

#echo "Updating plugins..."
cd ~/.vim
git submodule foreach git pull origin master

# Compile command-t extension
#cd .vim/bundle/command-t/ruby/command-t
#ruby extconf.rb && make && make clean && make distclean &&\
#echo "Compiled command-t c extension succesfully!"
