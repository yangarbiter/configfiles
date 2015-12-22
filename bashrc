
## BASH: this will run on each non-login and interactive shell.
. $HOME/.shrc

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]\[\033[01;33m\]@\h\[\033[00m\]\[\033[01;34m\]<\A>\[\033[00m\] [\w] '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
