#!/bin/bash

#echo "Updating plugins..."
cd ~/.vim
git submodule foreach git pull origin master
