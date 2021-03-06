" Carlos Agarie's vimrc
" Highly inspired (read: copied some parts) by these folks:
"   eevee - https://github.com/eevee/rc/blob/master/.vimrc
"   grb   - https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
"   ryanb - https://github.com/ryanb/dotfiles/blob/master/vimrc
"   jacob - http://www.stanford.edu/~jacobm/vim.html

" General
set nocompatible
set hidden
set magic                         " z0mg magic
set backspace=indent,eol,start    " Backspace can delete stuff in insert mode.
set clipboard=unnamedplus         " Enable system clipboard.
set number                        " Show line numbers.
set nocursorline                  " Less clutter.
set synmaxcol=200                 " Only use syntax highlighting in small lines.
syntax sync minlines=200          " Highlight from 200 lines backwards to improve performance.
set nobackup                      " LOL BACKUPS
set noswapfile
set laststatus=2                  " Show statusline in last window as well.

" Indentation
set autoindent                    " Copies current line indentation when creating a new line.
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

" Folds.
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Display path relative to current dir in statusline. Taken from:
" http://got-ravings.blogspot.com.br/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%f\ [%{strlen(&fenc)?&fenc:'none'},\ %{&ff}][%{&fo}]%h%m%r%y%=%c,%l/%L\ %P

" https://github.com/sickill/vim-monokai
colorscheme corvine

" Window height.
set winheight=30

" Pathogen and bundles.
"""""""""""""""""""""""

execute pathogen#infect()
execute pathogen#helptags()

" syntastic
"""""""""""

" `pylint` is too slow for development.
let g:syntastic_python_checkers = ['flake8', 'pyflake']
let g:syntastic_python_flake8_args = '--ignore=E501'

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" vim-markdown
""""""""""""""

" Disable automatic folding in Markdown.
let g:vim_markdown_folding_disabled = 1

" vimwiki
"""""""""

" Configuration for my personal notes.
let g:vimwiki_list = [{
      \ 'path': '~/Code/Personal/notes',
      \ 'syntax': 'markdown',
      \ 'ext': '.md',
      \ 'custom_wiki2html': 'vimwiki_markdown'}]

" Remaps.
"""""""""

" Leader is used in general remaps, localleader for filetype remaps.
let mapleader = ","
let maplocalleader = "\\"

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

" "in line" (entire line sans white-space; cursor at beginning--ie, ^)
xnoremap <silent> iL :<c-u>normal! g_v^<cr>
onoremap <silent> iL :<c-u>normal! g_v^<cr>

" "around line" (entire line sans trailing newline; cursor at beginning--ie, 0)
xnoremap <silent> aL :<c-u>normal! $v0<cr>
onoremap <silent> aL :<c-u>normal! $v0<cr>

" Language configuration.
"""""""""""""""""""""""""

filetype plugin indent on
syntax on
syntax enable

" Indentation for various languages.
autocmd Filetype python,java,scala,javascript,php,c,c++,julia set sw=4 sts=4 et
autocmd FileType ruby,eruby,yaml,html,sass,cucumber set sw=2 sts=2 et

au BufNewFile,BufRead PKGBUILD set ft=sh

" Remove any trailing whitespace that is in the file.
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Introduce current date as yyyy-mm-dd.
autocmd Filetype markdown,vimwiki nnoremap <buffer> <LocalLeader>dt :.!today --hyphen<cr>
