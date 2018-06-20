#!/bin/bash

# Setup sweet ~ environment with only one script

# Get my custom tailored bashrc
echo "Acquiring bashrc"
wget https://raw.githubusercontent.com/kosztkas/dotfiles/master/bashrc -O .bashrc

# Get the vimrc and add the molokai color theme as well (requires vim 7.4+)
echo "Creating folders for Vim"
mkdir .vim
mkdir .vim/colors

echo "Acquiring vimrc and colors"
wget https://raw.githubusercontent.com/kosztkas/dotfiles/master/vimrc -O .vimrc
wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -O .vim/colors/molokai.vim

echo "Done. Enjoy."
