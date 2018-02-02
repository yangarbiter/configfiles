syntax on
colorscheme scheme

"set 80 line
set tw=80
set cc=+1

set encoding=utf-8
set fileencodings=utf-8

set hlsearch
set background=dark
set history=1000
set undolevels=1000
set tabstop=4
set shiftwidth=4
set nu
set ru
set smartindent
set hlsearch
set wrap

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
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"show trailing whitespace
match ExtraWhitespace /\s\+$/
"Show whitespace
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"au InsertLeave * match ExtraWhitespace /\s\+$/
highlight Comment ctermfg=darkcyan

"let $CC = "gcc"
"let $CXX = "g++"
"let $CFLAGS = "-Wall"
"let $CXXFLAGS = "-Wall"
"let $ERRFILE="/a09e5c75-b7f9-415f-90b7-347fb46b173d.err"
"
"function! SingleCompile()
"	let file_suffix = expand("%:e")
"	if file_suffix == "c"
"		!${CC} ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE}
"		cg ${HOME}${ERRFILE}
"	elseif file_suffix == "cpp"
"		!${CXX} ${CXXFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE}
"		cg ${HOME}${ERRFILE}
"	else
"		echo "This file has an UNKNOWN SUFFIX!"
"	endif
"endfunction

function! ToggleQuickFixWindow()
	if g:quick_fix_window_on
		cclose
		let g:quick_fix_window_on = 0
	else
		copen
		let g:quick_fix_window_on = 1
	endif
endfunction

set expandtab

autocmd BufNewFile,BufReadPost *.md set filetype=markdown"

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

autocmd Filetype markdown setlocal shiftwidth=4 softtabstop=4
autocmd Filetype python setlocal shiftwidth=4 softtabstop=4
autocmd Filetype javascript setlocal shiftwidth=2 tabstop=2
autocmd Filetype html setlocal shiftwidth=2 tabstop=2
autocmd Filetype css setlocal shiftwidth=2 tabstop=2
autocmd Filetype c setlocal shiftwidth=2 tabstop=2
autocmd Filetype cpp setlocal shiftwidth=2 tabstop=2
autocmd Filetype lua setlocal shiftwidth=3 softtabstop=3
autocmd Filetype sh setlocal shiftwidth=2 tabstop=2
autocmd Filetype scala setlocal shiftwidth=2 tabstop=2


"===================Plugins=========================
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle required!
Plugin 'gmarik/vundle'

" C/Cpp
"Plugin 'rip-rip/clang_complete'
Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'vim-scripts/taglist.vim'
Plugin 'majutsushi/tagbar'

Plugin 'scrooloose/nerdtree'

"Plugin 'vim-scripts/vimgdb'

"Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'

"Plugin 'LargeFile'

"Plugin 'mattn/emmet-vim'
"https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL

Plugin 'bling/vim-airline'

"dependency for vim-lua-ftplugin
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-lua-ftplugin'

"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'

"Plugin 'ervandew/supertab'

"Plugin 'JuliaLang/julia-vim'

"Plugin 'derekwyatt/vim-scala'
" :SortScalaImports

" Javascript
"Plugin 'pangloss/vim-javascript'
"Plugin 'mxw/vim-jsx'

"Plugin 'skywind3000/asyncrun.vim'

" Asynchronous Lint Engine
"Plugin 'w0rp/ale'

Plugin 'lervag/vimtex'

call vundle#end()
filetype plugin indent on

"=============vim-airline=======================
let g:airline#extensions#tabline#enabled = 1

"=============LargeFile=====================
let g:LargeFile = 1000

"jedi-vim
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"

"=============ale====================
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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


"==============pymode===============
"autocmd FileType python let g:pymode_lint = 0
"autocmd FileType python let g:pymode_lint_on_write = 1
"autocmd FileType python let g:pymode_lint_cwindow = 1
"autocmd FileType python let g:pymode_lint_checkers = ['pylint', 'pep8']
"autocmd FileType python nmap <F3> :PymodeLintToggle<CR>
"
"autocmd FileType python let g:pymode_breakpoint = 1
"autocmd FileType python let g:pymode_breakpoint_bind = '<leader>b'
"
"autocmd FileType python let g:pymode_virtualenv = 1
"
"let g:pymode_rope = 0


"==============taglist======================
"nnoremap <F3> :TlistToggle<CR>

"==============tagbar======================
autocmd BufNewFile,BufRead *.h,*.c setfiletype cpp
autocmd FileType c nmap <F3> :TagbarToggle<CR>
autocmd FileType c++ nmap <F3> :TagbarToggle<CR>

"==============nerdtree=====================
map <F2> :NERDTreeToggle <cr>
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1

"=============vim-markdown=================
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
"## Mappings
"The following work on normal and visual modes:
"- `]]`: go to next header. `<Plug>(Markdown_MoveToNextHeader)`
"- `[[`: go to previous header. Contrast with `]c`.
"`<Plug>(Markdown_MoveToPreviousHeader)`
"- `][`: go to next sibling header if any.
"`<Plug>(Markdown_MoveToNextSiblingHeader)`
"- `[]`: go to previous sibling header if any.
"`<Plug>(Markdown_MoveToPreviousSiblingHeader)`
"- `]c`: go to Current header. `<Plug>(Markdown_MoveToCurHeader)`
"- `]u`: go to parent header (Up). `<Plug>(Markdown_MoveToParentHeader)`

"=============julia-vim====================
"https://github.com/JuliaLang/julia-vim
noremap <expr> <F8> LaTeXtoUnicode#Toggle()
inoremap <expr> <F8> LaTeXtoUnicode#Toggle()
let g:latex_to_unicode_file_types=".*"
let g:latex_to_unicode_auto = 1
let g:julia_blocks=1
let g:latex_to_unicode_eager = 0
runtime macros/matchit.vim

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

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

imap jj <Esc>

autocmd FileType python nnoremap <Leader>f :0,$!yapf<CR>

"====================vim-lua-ftplugin=====================
let g:lua_check_globals = 1
let g:lua_check_syntax = 1
let g:lua_complete_omni = 1
let g:lua_define_omnifunc = 1
let g:lua_safe_omni_modules = 1
let g:lua_define_completefunc = 1

"A trick when forgot to sudo before editing a file that requies root
cmap w!! w !sudo tee % >/dev/null

"source ~/.vim/plugin/cscope_maps.vim

inoremap <tab> <c-r>=Smart_TabComplete()<CR>

"function! init()
"	let file_suffix = expand("%:e")
"	if file_suffix == "c"
"		nmap <F5> :!${CC} ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE} %<CR>
"		cg ${HOME}${ERRFILE}
"	elseif index(['cpp', 'CPP', 'cp', 'cxx', 'cc', 'c++'], file_suffix) >= 0
"		nmap <F5> :!${CXX} ${CFLAGS} %:p:. -o %:r ${LDFLAGS} 2>&1 | tee ${HOME}${ERRFILE} %<CR>
"		cg ${HOME}${ERRFILE}
"	elseif file_suffix == "py"
"		set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"		nmap <F5> :!python2 %<CR>
"		nmap <F6> :!python3 %<CR>
"		set tabstop=4
"	else
"		echo "This file has an UNKNOWN SUFFIX!"
"	endif
"endfunction

" Quick run
nnoremap <leader>r :call <SID>compile_and_run()<CR>

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
endfunction

"Run Python Script
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd BufRead *.py nmap <F5> :!python2 %<CR>
autocmd BufRead *.py nmap <F6> :!python3 %<CR>
autocmd BufRead *.py set tabstop=4
autocmd BufRead *.py set go+=b
"Run lua script
autocmd BufRead *.lua nmap <F5> :!lua %<CR>
"Run php Script
autocmd BufRead *.php nmap <F5> :!php %<CR>
"Run bash Script
autocmd BufRead *.sh nmap <F5> :!bash %<CR>
"Run haskell Script
autocmd BufRead *.hs nmap <F5> :!runghc %<CR>
"Turn markdown to html
autocmd BufRead *.md nmap <F5> :!pandoc -f markdown -t html %<CR>
"Run bash Script
autocmd BufRead *.jl nmap <F5> :update <CR> :!julia %<CR>
"Run scala Script
autocmd BufRead *.scala nmap <F5> :update <CR> :!scala %<CR>

let mapleader = " " " Leader is the space key
let g:mapleader = " "
" easier write
nmap <leader>w :w!<cr>
" easier quit
nmap <leader>q :q<cr>
" fzf command
set rtp+=~/.fzf
nnoremap <leader>t :call fzf#run({ 'sink': 'tabe', 'options': '-m +c', 'dir': '.', 'source': 'find .' })<CR>
"paste from outside buffer
nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>p <Esc>:set paste<CR>gv"+p:set nopaste<CR>
"copy to outside buffer
vnoremap <leader>y "+y

let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

set rtp+=~/.fzf

" pretty print json
" :%!python -m json.tool

" search selected text
vnoremap // y/<C-R>"<CR>
