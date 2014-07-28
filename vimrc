syntax on
colorscheme scheme

set encoding=utf-8
set fileencodings=utf-8

set hlsearch
set background=dark
set history=700
set undolevels=700
set tabstop=4
set shiftwidth=4
set nu
set ru
set smartindent
set hlsearch

" from http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction
highlight Pmenu ctermbg=Gray ctermfg=Black
highlight PmenuSel ctermbg=Green ctermfg=Black

let $CC = "gcc"
let $CXX = "g++"
let $CFLAGS = "-Wall"
let $CXXFLAGS = "-Wall"
let $ERRFILE="/a09e5c75-b7f9-415f-90b7-347fb46b173d.err"

function! SingleCompile()
	let file_suffix = expand("%:e")
	if file_suffix == "c"
		!${CC} ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE}
		cg ${HOME}${ERRFILE}	
	elseif file_suffix == "cpp"
		!${CXX} ${CXXFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE}
		cg ${HOME}${ERRFILE}
	else
		echo "This file has an UNKNOWN SUFFIX!"
	endif
endfunction

function! ToggleQuickFixWindow()
	if g:quick_fix_window_on
		cclose
		let g:quick_fix_window_on = 0
	else
		copen
		let g:quick_fix_window_on = 1
	endif
endfunction


"Show whitespace
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"au InsertLeave * match ExtraWhitespace /\s\+$/

highlight Comment ctermfg=darkcyan


autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd Filetype html setlocal shiftwidth=2 tabstop=2
autocmd Filetype javascript setlocal shiftwidth=2 tabstop=2
autocmd Filetype python setlocal expandtab shiftwidth=4 softtabstop=4


"===================Plugins=========================
set nocompatible

"filetype off
filetype on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'majutsushi/tagbar'

Bundle 'gmarik/vundle'
"Bundle 'vim-scripts/taglist.vim'
Bundle 'scrooloose/nerdtree'

Bundle 'vim-scripts/vimgdb'

"Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'

Bundle 'LargeFile'

Bundle "mattn/emmet-vim"
"https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL

Bundle 'bling/vim-airline'

"=============vim-airline=======================
let g:airline#extensions#tabline#enabled = 1

"=============LargeFile=====================
let g:LargeFile = 1000


" The bundles you install will be listed here
filetype plugin indent on

" The rest of your config follows here

"jedi-vim
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"


"==============vim-gdb===============
"List of default key mappings:
"    CTRL-Z  send an interrupt to GDB and the program it is running
"    B       info breakpoints
"    L       info locals
"    A       info args
"    S       step
"    I       stepi
"    CTRL-N  next: next source line, skipping all function calls
"    X       nexti
"    F       finish
"    R       run
"    Q       quit
"    C       continue
"    W       where
"    CTRL-U  up: go up one frame
"    CTRL-D  down: go down one frame
"cursor position: ~
"    CTRL-B  set a breakpoint on the line where the cursor is located
"    CTRL-E  clear all breakpoints on the line where the cursor is located
"mouse pointer position: ~
"    CTRL-P  print the value of the variable defined by the mouse pointer
"            position
"    CTRL-X  print the value that is referenced by the address whose
"            value is that of the variable defined by the mouse pointer
"            position
"    CTRL-K  set a breakpoint at assembly address shown by mouse position
"    CTRL-H  clear a breakpoint at assembly address shown by mouse position
"    CTRL-J  add the selected variable at mouse position to the watched
"            variables window


"==============taglist======================
"nnoremap <F3> :TlistToggle<CR>

"==============taglist======================
nnoremap <F3> :TagbarToggle<CR>

"==============nerdtree=====================
map <F2> :NERDTreeToggle <cr>

"navigate through tabs
"map <tab> :tabn <cr>
"nnoremap <C-tab> gt
"nnoremap <C-S-tab> gT 
"inoremap <C-tab> gt
"inoremap <C-S-tab> gT 

map <F9> :make exec<cr>
"map <ScrollWheelDown> <C-U>
"map <ScrollWheelUp> <C-D>

set pastetoggle=<F4>
set showmode

"Quicksave command
map <Leader>s <esc>:update<cr>

"Undo Redo
map <Leader>z <esc> u <cr>
map <Leader>y <esc> <C-R> <cr>

"easier moving of code blocks
nmap <tab> V>
nmap <S-tab> V<
vmap <tab> >gv
vmap <S-tab> <gv

"source ~/.vim/plugin/cscope_maps.vim

inoremap <tab> <c-r>=Smart_TabComplete()<CR>

"Run Python Script
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd BufRead *.py nmap <F5> :update <CR> :!python %<CR>
autocmd BufRead *.py set tabstop=4
autocmd BufRead *.py set nowrap
autocmd BufRead *.py set go+=b

"Run php Script
autocmd BufRead *.php nmap <F5> :update <CR> :!php %<CR>

"Run nodejs Script
autocmd BufRead *.js nmap <F5> :update <CR> :!node %<CR>

"Run bash Script
autocmd BufRead *.sh nmap <F5> :update <CR> :!bash %<CR>
