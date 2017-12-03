#!/bin/bash

git submodule init
git submodule update

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sv ${BASEDIR}/env_vars.sh ~/.env_vars.sh
echo "export DOTFILE_BASEDIR=$BASEDIR" >> ~/.env_vars.sh

# terminal
if [ -e ~/.bashrc ] ; then mv ~/.bashrc ~/.bashrc_local; fi
ln -sv ${BASEDIR}/bashrc ~/.bashrc

if [ -e ~/.shrc ] ; then mv ~/.shrc ~/.shrc_local; fi
ln -sv ${BASEDIR}/shrc ~/.shrc

if [ -e ~/.profile ] ; then mv ~/.profile ~/.profile_local; fi
if [ -e ~/.bash_profile ] ; then mv ~/.bash_profile ~/.bash_profile_local; fi
ln -sv ${BASEDIR}/bash_profile ~/.bash_profile
ln -sv ${BASEDIR}/.profile ~/.profile

if [ -e ~/.alias ] ; then rm ~/.alias; fi
ln -sv ${BASEDIR}/.alias ~/.alias

# vim
if [ -e ~/.vimrc ] ; then mv ~/.vimrc ~/.vimrc_local; fi
ln -sv ${BASEDIR}/vimrc ~/.vimrc
ln -sv ${BASEDIR}/vim ~/.vim

# zsh
# ln -sv ${BASEDIR}/zshrc ~/.zshrc

# git
if [ -e ~/gitconfig ] ; then mv ~/.gitconfig ~/.gitconfig_local; fi
ln -sv ${BASEDIR}/gitconfig ~/.gitconfig
ln -sv ${BASEDIR}/git_diff_wrapper ~/.git_diff_wrapper

ln -sv ${BASEDIR}/screenrc ~/.screenrc

GIT_COMPLET_URL=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
wget $GIT_COMPLET_URL -O $BASEDIR/git-completion.bash

GIT_PROMPT_URL=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
wget $GIT_PROMPT_URL -O $BASEDIR/git-prompt.sh

# install vim extensions
# wget http://vimcolorschemetest.googlecode.com/svn/colors/256-jungle.vim

vim +BundleInstall +qall

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install pyenv
# curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
