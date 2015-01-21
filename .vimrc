filetype off
filetype plugin indent off
set runtimepath+=/usr/local/Cellar/go/1.3.3/libexec/misc/vim
filetype plugin indent on
syntax on

set nocompatible
set t_Co=16
call pathogen#infect()
call pathogen#helptags()
set modelines=0

set ignorecase
set smartcase
set hlsearch
set incsearch
set autoindent
set showmode
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set encoding=utf8
set scrolloff=3
set nobackup
set nowb
set noswapfile
set ttyfast
set ruler
set backspace=indent,eol,start
set relativenumber
set laststatus=2

set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

let mapleader = ","
set gdefault
set showmatch
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1

" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" nnoremap j gj
" nnoremap k gk

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>q gqip
nnoremap <leader>v V`]

set modeline
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
au FileType javascript setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType sh setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
au BufNewFile,BufRead *.ejs set filetype=html

set background=dark
if has("gui_running")
	set guifont=Inconsolata\ 13
endif

let g:pymode_rope = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_lookcup_project = 0

" Documentation
" let g:pymode_doc = 1
" let g:pymode_doc_key = 'K'

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

let g:hybrid_use_Xresources = 1
colorscheme hybrid
set shell=/bin/sh

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set cursorline
set colorcolumn=80

hi CursorLine cterm=NONE ctermbg=darkgrey

set omnifunc=syntaxcomplete#Complete
let g:NERDTreeWinSize = 29

nmap <f8> :TagbarToggle<CR>
set tags=./tags,tags;~/
autocmd FileType go autocmd BufWritePre <buffer> Fmt
