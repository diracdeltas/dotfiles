filetype off

set nocompatible
set t_Co=16
call pathogen#infect()
call pathogen#helptags()

set ignorecase
set smartcase
set hlsearch
set incsearch
set encoding=utf8
set nobackup
set nowb
set noswapfile

set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

filetype indent plugin on
syntax on
set modeline
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
au FileType javascript setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType sh setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
au BufNewFile,BufRead *.ejs set filetype=html

syntax on
set background=dark " dark | light "
if has("gui_running")
	set guifont=Inconsolata\ 13
endif

let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"

" DON'T Auto check on save
let g:pymode_lint_write = 0

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0
let g:molokai_original = 1

colorscheme solarized
set shell=/bin/sh

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set cursorline
set colorcolumn=80
