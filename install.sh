#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# terminal
if [ -e ~/.bashrc ] ; then mv ~/.bashrc ~/.bashrc_local; fi
ln -sv ${BASEDIR}/bashrc ~/.bashrc
if [ -e ~/.shrc ] ; then mv ~/.shrc ~/.shrc_local; fi
ln -sv ${BASEDIR}/shrc/ ~/.shrc

# vim
if [ -e ~/.vimrc ] ; then mv ~/.vimrc ~/.vimrc_local; fi
ln -sv ${BASEDIR}/vimrc ~/.vimrc
ln -sv ${BASEDIR}/vim/ ~/.vim

# zsh
# ln -sv ${BASEDIR}/zshrc ~/.zshrc

# git
ln -sv ${BASEDIR}/gitconfig ~/.gitconfig
ln -sv ${BASEDIR}/git_diff_wrapper ~/.git_diff_wrapper

# install vim extensions
# wget http://vimcolorschemetest.googlecode.com/svn/colors/256-jungle.vim

vim +BundleInstall +qall

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
