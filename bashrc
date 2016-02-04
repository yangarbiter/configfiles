
## BASH: this will run on each non-login and interactive shell.
. $HOME/.shrc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bashrc_local ] && source ~/.bashrc_local

GIT_PS1_SHOWDIRTYSTATE=1
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]\033[01;33m\]@\h\[\033[00m\]\[\033[01;34m\]<\A>\[\033[00m\] $(__git_ps1 "\[\e[1;35m\](%s) \[\e[m\]")[\w] '


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
