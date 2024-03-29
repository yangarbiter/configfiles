#!/bin/bash

git submodule init
git submodule update

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OS=${OSTYPE/[^a-z]*/}
case $OS in
  'linux')
    OS='linux'
    ;;
  'freebsd')
    OS='freebsd'
    ;;
  'windowsnt')
    OS='windows'
    ;;
  'darwin')
    OS='mac'
    ;;
  'sunos')
    OS='solaris'
    ;;
  'aix') ;;
  *) ;;
esac

link_and_bak () {
  if [[ ! "$1" -ef "$2" ]]; then
    if [ -e "$2" ] ; then mv "$2" "$2".bak; fi
    ln -sv "$1" "$2";
  fi
}
link_and_rm () {
  if [[ ! "$1" -ef "$2" ]]; then
    if [ -e "$2" ] ; then rm "$2"; fi
    ln -sv "$1" "$2";
  fi
}

if [ "$1" == vscode ]; then
  if [ "$OS" == mac ]; then
    vssettings=$HOME/Library/Application\ Support/Code/User/settings.json
    link_and_bak ${BASEDIR}/vscode/settings.json "${vssettings}"
    vssnippet=$HOME/Library/Application\ Support/Code/User/snippets
    link_and_bak ${BASEDIR}/vscode/snippets "${vssnippet}"
    vskey=$HOME/Library/Application\ Support/Code/User/keybindings.json
    link_and_bak ${BASEDIR}/vscode/keybindings.json "${vskey}"
  elif [ "$OS" == mac ]; then
    vssettings=$HOME/.config/Code/User/settings.json
    link_and_bak ${BASEDIR}/vscode/settings.json "${vssettings}"
    vssnippet=$HOME/.config/Code/User/snippets
    link_and_bak ${BASEDIR}/vscode/snippets "${vssnippet}"
    vskey=$HOME/.config/Code/User/keybindings.json
    link_and_bak ${BASEDIR}/vscode/keybindings.json "${vskey}"
  fi
  echo "installed vscode preferences."

elif [ "$1" == pyenv ]; then
  # install pyenv
  export PYENV_ROOT=$HOME/.pyenv
  curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
  $PYENV_ROOT/bin/pyenv init -
  $PYENV_ROOT/bin/pyenv virtualenv-init -
  pyenv update
  if [ "$OS" == 'linux' ]; then
    env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.11.3
  else
    env PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 3.11.3 # OSX
  fi
  echo "export PYENV_ROOT=$PYENV_ROOT" >> ~/.env_vars.sh
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.env_vars.sh
  echo 'eval "$(pyenv init --path)"' >> ~/.env_vars.sh
  echo 'eval "$(pyenv init -)"' >> ~/.zshrc
  echo "installed pyenv."

elif [ "$1" == zsh ]; then
  # install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  # uninstall_oh_my_zsh
  # upgrade_oh_my_zsh
  cp ${BASEDIR}/yyy.zsh-theme ~/.oh-my-zsh/custom/themes/
  cp ${BASEDIR}/oh-my-zshrc ~/.zshrc
  link_and_rm ${BASEDIR}/.zprofile ~/.zprofile
  ~/.fzf/install
  echo "installed zsh."

elif [ "$1" == remove_all ]; then
  rm -rf ~/.bashrc
  rm -rf ~/.shrc
  rm -rf ~/.bash_profile ~/.profile
  rm -rf ~/.alias
  rm -rf ~/.vim ~/.vimrc
  rm -rf ~/.gitconfig ~/.git_diff_wrapper
  rm -rf ~/.screenrc
  rm -rf ~/.fzf

else
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
  #if [ -e ~/.vimrc ] ; then mv ~/.vimrc ~/.vimrc_local; fi
  link_and_rm ${BASEDIR}/vimrc ~/.vimrc
  if [ -e ~/.vim ] ; then mv ~/.vim; fi
  ln -sv ${BASEDIR}/vim ~/.vim

  # zsh
  # ln -sv ${BASEDIR}/zshrc ~/.zshrc

  # git
  if [ -e ~/gitconfig ] ; then mv ~/.gitconfig ~/.gitconfig_local; fi
  ln -sv ${BASEDIR}/gitconfig ~/.gitconfig
  ln -sv ${BASEDIR}/git_diff_wrapper ~/.git_diff_wrapper

  link_and_rm ${BASEDIR}/screenrc ~/.screenrc
  link_and_rm ${BASEDIR}/tmux.conf ~/.tmux.conf
  link_and_rm ${BASEDIR}/inputrc ~/.inputrc

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
fi
