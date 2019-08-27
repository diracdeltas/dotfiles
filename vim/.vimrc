filetype off
filetype plugin indent off
"set runtimepath+=/usr/local/Cellar/go/1.3.3/libexec/misc/vim
filetype plugin indent on
syntax on

set nocompatible
set t_Co=16
call pathogen#infect()
call pathogen#helptags()

"set number
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
set laststatus=2

set expandtab
"set smarttab
set tabstop=2
set shiftwidth=2

let mapleader = ","
set gdefault
set showmatch
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

vnoremap <leader>1 :s#^#> #<cr>
vnoremap <leader>3 :s#^#\##<cr>
vnoremap <leader>2 :s#^\###<cr>

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

au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
au FileType javascript setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
au FileType sh setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
au BufNewFile,BufRead *.ejs set filetype=html

set background=dark
if has("gui_running")
	set guifont=Inconsolata\ 13
endif

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_python_checkers=['flake8']

" vim-javascript
" let g:javascript_plugin_jsdoc = 1
" let g:javascript_plugin_flow = 1

" let g:hybrid_use_Xresources = 1
colorscheme hybrid
set shell=/bin/sh

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set cursorline
set colorcolumn=80

hi CursorLine cterm=NONE ctermbg=darkgrey

" set omnifunc=syntaxcomplete#Complete
" let g:NERDTreeWinSize = 29

" nmap <f8> :TagbarToggle<CR>
set tags=./tags,tags;~/
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Autoformat js files
" autocmd bufwritepost *.js silent !standard % --format
set autoread
set nomodeline
set modelines=0
