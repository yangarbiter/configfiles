## BASH: this will run on each non-login and interactive shell.

. $HOME/.shrc
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

# Usage: smartextract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is Mac OS X-specific.
smartextract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1        ;;
            *.tar.gz)   tar -zxvf $1        ;;
            *.bz2)      bunzip2 $1          ;;
            *.dmg)      hdiutil mount $1    ;;
            *.gz)       gunzip $1           ;;
            *.tar)      tar -xvf $1         ;;
            *.tbz2)     tar -jxvf $1        ;;
            *.tgz)      tar -zxvf $1        ;;
            *.zip)      unzip $1            ;;
            *.Z)        uncompress $1       ;;
            *.7z)       7z e $1       ;;
            *.rar)      unrar e $1       ;;
            *)          echo "'$1' cannot be extracted/mounted via smartextract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
alias e='smartextract'

. $DOTFILE_BASEDIR/git-completion.bash
. $DOTFILE_BASEDIR/git-prompt.sh
. $DOTFILE_BASEDIR/z/z.sh

export FZF_DEFAULT_OPTS=--history-size=5000
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export GOPATH=~/gopkgs
#export PATH=$PATH:~/gopkgs/bin/:/sbin/:/usr/sbin

#[ -e ~/.pyenv ] && export PATH="/Users/arbiter/.pyenv/bin:$PATH"
#[ -e ~/.pyenv ] && eval "$(pyenv init -)"
#[ -e ~/.pyenv ] && eval "$(pyenv virtualenv-init -)"
