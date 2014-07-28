all: vimrc clone installBundle git_diff color
	cp ./vimrc ~/.vimrc
	cp ./tmux.conf ~/.tmux.conf
	mkdir -p ~/.vim/colors/
	cp scheme.vim ~/.vim/colors/

installBundle:
	vim +BundleInstall +qall

clone:
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

color:
	wget http://vimcolorschemetest.googlecode.com/svn/colors/256-jungle.vim
	mkdir -p ~/.vim/colors/
	mv 256-jungle.vim ~/.vim/colors/

#not working now
syntax:
	cp scheme.vim ~/.vim/colors/
	tar -zxf gtk-vim-syntax.tar.gz
	mv -p gtk-vim-syntax/ ~/.vim/after/syntax/c.vim

#open git diff with vimdiff
git_diff:
	cp gitconfig ~/.gitconfig
	cp git_diff_wrapper ~/.git_diff_wrapper
	chmod +w ~/.git_diff_wrapper

cscope:
	wget -O ~/.vim/plugin/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim
	#cscope -bR

#download html.vim
html:
	mkdir ~/.vim/indent
	wget -O ~/.vim/indent/html.vim http://www.vim.org/scripts/download_script.php?src_id=21389
