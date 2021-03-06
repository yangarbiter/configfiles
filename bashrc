## BASH: this will run on each non-login and interactive shell.

source $HOME/.shrc
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
[ -f ~/.alias ] && source ~/.alias

if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

GIT_PS1_SHOWDIRTYSTATE=1
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]\[\033[01;33m\]@\h\[\033[00m\]\[\033[01;34m\]<\A>\[\033[00m\] $(__git_ps1 "\[\e[1;35m\](%s) \[\e[m\]")[\w] '

TERM=screen-256color

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend


# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=2000

. $DOTFILE_BASEDIR/git-completion.bash
. $DOTFILE_BASEDIR/git-prompt.sh
. $DOTFILE_BASEDIR/z/z.sh

export FZF_DEFAULT_OPTS=--history-size=5000
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export GOPATH=~/gopkgs
#export PATH=$PATH:~/gopkgs/bin/:/sbin/:/usr/sbin

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

[ -e $PYENV_ROOT ] && export PATH="${PYENV_ROOT}/bin:$PATH"
[ -e $PYENV_ROOT ] && eval "$(pyenv init -)"
[ -e $PYENV_ROOT ] && eval "$(pyenv virtualenv-init -)"
