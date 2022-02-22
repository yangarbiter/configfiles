os=${OSTYPE/[^a-z]*/}
case "$os" in
"darwin")
  export PATH=/usr/local/texlive/2016/bin/x86_64-darwin:$PATH
  export CLICOLOR=1
  export LSCOLORS=GxFxCxDxBxegedabagaced
	;;
esac
export LC_ALL=en_US.UTF-8
export DOTFILE_BASEDIR=/home/arbiter/configfiles
export PYENV_ROOT=/home/arbiter/.pyenv
export EDITOR=vim
export SHELL=/bin/zsh
export PYENV_SHELL=/bin/zsh


export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/cuda-10.0/lib64
export PATH=${PATH}:/opt/cuda-10.0/bin
