" Start Pathogen.
execute pathogen#infect()
syntax on
filetype plugin indent on

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Enable system clipboard.
set clipboard=unnamedplus

" No cluttering working directory.
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Syntax highlighting.
if &t_Co > 2
  colorscheme hemisu
endif

" Highlight current line.
set cul                                                              " highlight current line
hi CursorLine term=none cterm=none ctermbg=red ctermfg=white         " adjust color

" Line and columns numbers.
set number
set numberwidth=4
set ruler

" Soft tabs with 2 spaces.
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Python is better with 4 spaces.
autocmd Filetype python setlocal tabstop=4 shiftwidth=4

" Ruby path to speed up vim startup time.
let g:ruby_path = "$HOME/.rvm/bin/rvm-auto-ruby"

" Searching
set hlsearch    " Highlight matches.
set incsearch   " Incremental search.
set ignorecase  " Ignore case.
set smartcase   " ... except when they contain at least one capital letter.

" Backspace can delete STUFF in insert mode.
set backspace=indent,eol,start

" Splits
" Use :sp for splits and :vsp for vertical ones.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new split panes to right and bottom.
set splitbelow
set splitright

