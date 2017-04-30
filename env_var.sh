os=${OSTYPE/[^a-z]*/}
case "$os" in
"darwin")
  export PATH=/usr/local/texlive/2016/bin/x86_64-darwin:$PATH
  export CLICOLOR=1
  export LSCOLORS=GxFxCxDxBxegedabagaced
	;;
esac
