" Carlos Agarie's vimrc
" Highly inspired (read: copied some parts) by these guys:
"   eevee - https://github.com/eevee/rc/blob/master/.vimrc
"   ryanb - https://github.com/ryanb/dotfiles/blob/master/vimrc
"   jacob - http://www.stanford.edu/~jacobm/vim.html

" Preferred mode.
set nocompatible

filetype plugin indent on
syntax on
syntax enable

" Backspace can delete STUFF in insert mode.
set backspace=indent,eol,start

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Enable system clipboard.
set clipboard=unnamedplus

" Leader
let mapleader = ","
let g:mapleader = ","

" No cluttering working directory.
set nobackup " These backups aren't very useful.
set directory=~/.vim/tmp

" Fix vim slowdowns.
set nocursorcolumn " Remove cursor in column
set nocursorline   " Line cursors aren't necessary with relativenumber set.
set synmaxcol=80  " Only use syntax highlighting in small lines.
syntax sync minlines=256

" Line and columns numbers.
set number
set numberwidth=4
set ruler
set relativenumber " Line numbers spread from 0.

" Soft tabs with 2 spaces.
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Searching
set hlsearch    " Highlight matches.
set incsearch   " Incremental search.
set ignorecase  " Ignore case.
set smartcase   " ... except when they contain at least one capital letter.

" - / = to navigate between tabs.
noremap - :tabprevious<CR>
noremap = :tabnext<CR>

" Splits & tabs.
" Use :sp for splits and :vsp for vertical ones.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new split panes to right and bottom.
set splitbelow
set splitright

" Language configuration.

" Python is better with 4 spaces.
autocmd Filetype python setlocal tabstop=4 shiftwidth=4

" Ruby path to speed up vim startup time.
let g:ruby_path = "$HOME/.rvm/bin/rvm-auto-ruby"

" Syntax highlighting.
set background=dark
se t_Co=16
if &t_Co > 2
  colorscheme solarized
else
  colorscheme elflord
endif

" Plugin configuration.

" Start Pathogen.
execute pathogen#infect()

" Who thought it would be a good idea to enable code folding?!
let g:vim_markdown_folding_disabled = 1

let g:pymode_folding = 0
let g:pymode_lint_checker = "pyflakes"

" Remaps.
nnoremap <Leader>k i<cr><esc>k$

