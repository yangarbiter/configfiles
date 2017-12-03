[ -f ~/.profile_local ] && source ~/.profile_local
#[ -f ~/.bash_profile_local ] && source ~/.bash_profile_local

ulimit -S -c 0	# core dumpsize
umask 027

os=${OSTYPE/[^a-z]*/}

export TERM=xterm-256color
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export USER=$LOGNAME

source ~/.alias
