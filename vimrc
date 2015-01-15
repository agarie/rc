" Carlos Agarie's vimrc
" Highly inspired (read: copied some parts) by these folks:
"   eevee - https://github.com/eevee/rc/blob/master/.vimrc
"   ryanb - https://github.com/ryanb/dotfiles/blob/master/vimrc
"   jacob - http://www.stanford.edu/~jacobm/vim.html

set nocompatible
set magic " z0mg magic
set backspace=indent,eol,start " Backspace can delete STUFF in insert mode.
set clipboard=unnamedplus " Enable system clipboard.
set nofoldenable " Code folding is ugly.
set number " Line numbers.
set cursorline   " Line cursors aren't necessary with relativenumber set.
set synmaxcol=100  " Only use syntax highlighting in small lines.
syntax sync minlines=256
set nobackup " LOL BACKUPS
set noswapfile

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

" Open new split panes to right and bottom.
set splitbelow
set splitright

" Show statusline in last window as well.
set laststatus=2

" Display path relative to current dir in statusline. Taken from:
" http://got-ravings.blogspot.com.br/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%f\ [%{strlen(&fenc)?&fenc:'none'},\ %{&ff}][%{&fo}]%h%m%r%y%=%c,%l/%L\ %P

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Start Pathogen.
execute pathogen#infect()
execute pathogen#helptags()

" `pylint` is too slow for development.
let g:syntastic_python_checkers = ['flake8', 'pyflake']
let g:syntastic_python_flake8_args = '--ignore=E501'

" Who thought it would be a good idea to enable code folding?!
let g:vim_markdown_folding_disabled = 1

" Leader
let mapleader = ","
let g:mapleader = ","

" Remaps.
nnoremap <Leader>k i<cr><esc>k$

" Use ' to reindent lines.
noremap ' =

" Splits & tabs.
" Use :sp for splits and :vsp for vertical ones.
" This allows you to use ^J, ^K, ^L and ^H to navigate between them.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" - and = to navigate between tabs.
noremap - :tabprevious<CR>
noremap = :tabnext<CR>

" Language configuration.

filetype plugin indent on
syntax on
syntax enable

" Python, Java and Scala are better with 4 spaces.
autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype java setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype scala setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype javascript setlocal tabstop=4 softtabstop=4 shiftwidth=4

autocmd BufNewFile,BufRead *.jinja* set ft=jinja syntax=html

" See Ruby autocompletion help with :help ft-ruby-omni
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

" Syntax highlighting.
set background=dark
set t_Co=256
colorscheme lavalamp
