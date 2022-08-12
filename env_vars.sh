os=${OSTYPE/[^a-z]*/}
case "$os" in
"darwin")
  export PATH=/usr/local/texlive/2016/bin/x86_64-darwin:$PATH
  export CLICOLOR=1
  export LSCOLORS=GxFxCxDxBxegedabagaced
	;;
esac
export LC_ALL=en_US.UTF-8
export DOTFILE_BASEDIR=$HOME/configfiles
export PYENV_ROOT=$HOME/.pyenv
export EDITOR=vim
export SHELL=/bin/zsh
export PYENV_SHELL=/bin/zsh
export CUDA_DEVICE_ORDER=PCI_BUS_ID


export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/tmp2/cuda/cuda-10.0/lib64:/tmp2/cuda/cuda-10.1/lib64:/tmp2/cuda/cudnn-7/
export PATH=${PATH}:/tmp2/cuda/cuda-10.1/bin:$HOME/google-cloud-sdk/bin/
