" Carlos Agarie's vimrc
" Highly inspired (read: copied some parts) by these folks:
"   eevee - https://github.com/eevee/rc/blob/master/.vimrc
"   grb   - https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
"   ryanb - https://github.com/ryanb/dotfiles/blob/master/vimrc
"   jacob - http://www.stanford.edu/~jacobm/vim.html

set nocompatible
set hidden
set magic                         " z0mg magic
set backspace=indent,eol,start    " Backspace can delete stuff in insert mode.
set clipboard=unnamedplus         " Enable system clipboard.
set number                        " Show line numbers.
set cursorline                    " Line cursors aren't necessary with relativenumber set.
set synmaxcol=200                 " Only use syntax highlighting in small lines.
syntax sync minlines=256
set nobackup                      " LOL BACKUPS
set noswapfile
set laststatus=2                  " Show statusline in last window as well.

" Soft tabs with 2 spaces.
set autoindent                    " Copies the current line indentation when CRing or CTRL-o / CTRL-O.
set tabstop=8                     " Hard tabs (eww) are equivalent to 8 spaces.
set softtabstop=2                 " Tab key, 1 tab = 2 spaces.
set shiftwidth=2                  " Autoindent, 1 tab = 2 spaces.
set shiftround                    " Indentation is set to multiples of shiftwidth.
set expandtab                     " Never use hard tabs. To insert one, use CTRL-V <Tab>.

" Searching
set hlsearch                      " Highlight matches.
set incsearch                     " Incremental search.
set ignorecase                    " Ignore case...
set smartcase                     " ... except when they contain at least one capital letter.

" Open new split panes to right and bottom.
set splitbelow
set splitright

" Display path relative to current dir in statusline. Taken from:
" http://got-ravings.blogspot.com.br/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%f\ [%{strlen(&fenc)?&fenc:'none'},\ %{&ff}][%{&fo}]%h%m%r%y%=%c,%l/%L\ %P

" Color scheme.
set background=dark
set t_Co=256
colorscheme lavalamp

" Window height.
set winheight=30

" Pathogen and bundles.
"""""""""""""""""""""""

execute pathogen#infect()
execute pathogen#helptags()

" See Ruby autocompletion help with :help ft-ruby-omni
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

" `pylint` is too slow for development.
let g:syntastic_python_checkers = ['flake8', 'pyflake']
let g:syntastic_python_flake8_args = '--ignore=E501'

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" Who thought it would be a good idea to enable code folding?!
let g:vim_markdown_folding_disabled = 1

" Remaps.
"""""""""

" Use comma as the leader key.
let mapleader = ","
let g:mapleader = ","

" Use ,k to break into a new line.
nnoremap <Leader>k i<cr><esc>k$

" Use ,e to edit files in the current directory.
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <Leader>e :edit %%<cr>

" Use ^J, ^K, ^L and ^H to navigate between splits.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use ,- and ,= to navigate between tabs.
noremap <Leader>- :tabprevious<CR>
noremap <Leader>= :tabnext<CR>

" Language configuration.
"""""""""""""""""""""""""

filetype plugin indent on
syntax on
syntax enable

" Indentation for various languages.
autocmd Filetype python,java,scala,javascript,php set sw=4 sts=4 et
autocmd FileType ruby,haml,eruby,yaml,html,jinja,sass,cucumber set sw=2 sts=2 et
autocmd BufNewFile,BufRead *.jinja* set ft=jinja syntax=html

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

