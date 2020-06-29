#!/bin/sh

# vim
ln -sf ~/environment/.vimrc ~/.vimrc

# bash
ln -sf ~/environment/.bashrc ~/.bashrc
ln -sf ~/environment/.bash_profile ~/.bash_profile

# tmux
ln -sf ~/environment/.tmux.conf ~/.tmux.conf

# repo
git clone https://github.com/b4b4r07/enhancd ~/environment/.repository/enhancd
