" Carlos Agarie's vimrc

" Still using old .vim directory with bunch of stuf.
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" General {{{
set nocompatible
set hidden
set magic                         " z0mg magic
set backspace=indent,eol,start    " Backspace can delete stuff in insert mode.
set clipboard=unnamedplus         " Enable system clipboard.
set number                        " Show line numbers.
set relativenumber
set cursorline                    " Highlight current line.
set nobackup                      " LOL BACKUPS
set noswapfile
set foldopen-=block               " Don't open folds when moving around with paragraph text objects ({ and }).
set foldcolumn=1                  " Show fold information in the gutter.

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

colorscheme molokai

" Window height.
set winheight=30

" }}}

" Plugins {{{
call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
call plug#end()

" Pathogen and bundles.
"""""""""""""""""""""""
" TODO: Use `vim-plug` instead of Pathogen.

execute pathogen#infect()
execute pathogen#helptags()

" Telescope
nnoremap <C-P> <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" airline
"""""""""

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = " ℅:"

" syntastic
"""""""""""

" `pylint` is too slow for development.
let g:syntastic_python_checkers = ['flake8', 'pyflake']
let g:syntastic_python_flake8_args = '--ignore=E501'

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" vim-markdown
let g:markdown_folding = 1

" }}}

" vimwiki {{{

" Configuration for my personal notes.
let g:vimwiki_list = [{
      \ 'path': $HOME . '/Code/Personal/notes',
      \ 'path_html': $HOME . '/Code/Personal/notes/notes_html',
      \ 'template_path': $HOME . '/Code/Personal/notes/_templates',
      \ 'custom_wiki2html': 'vimwiki_markdown',
      \ 'syntax': 'markdown',
      \ 'ext': '.md',
      \ 'html_filename_parameterization': 1,
      \ 'auto_generate_links': 1,
      \ 'auto_diary_index': 1,
      \ 'auto_tags': 1}]

" Let folding be defined by another plugin.
let g:vimwiki_folding = 'expr'

" Do not create a 'temporary wiki' whenever I open a *.md file.
" A temporary wiki is a mechanism by which vimwiki can create an anonymous
" wiki if it can't find one defined in your environment.
let g:vimwiki_global_ext = 0

" }}}

" Remaps {{{

" Leader is used in general remaps, localleader for filetype remaps.
let mapleader = ","
let maplocalleader = ";"

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

" Use ,[ and ,] to navigate between buffers.
noremap <Leader>[ :bnext<CR>
noremap <Leader>] :blast<CR>

" "in line" (entire line sans white-space; cursor at beginning--ie, ^)
xnoremap <silent> iL :<c-u>normal! g_v^<cr>
onoremap <silent> iL :<c-u>normal! g_v^<cr>

" "around line" (entire line sans trailing newline; cursor at beginning--ie, 0)
xnoremap <silent> aL :<c-u>normal! $v0<cr>
onoremap <silent> aL :<c-u>normal! $v0<cr>

" Exit insert mode.
inoremap jk <esc>

" Save file path for c/p.
noremap \l :let @+ = expand('%')<cr>
nnoremap <Leader>/ :Ggrep! <c-r>=expand('<cword>')<CR>

noremap \\ :wa<return>
noremap ZA :wa<cr>:qa<cr>
noremap ZC :qa!<cr>

" Highlight words without moving cursor.
noremap <Leader><Leader>h *#

" Search and replace word under cursor.
nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/

" Clear highlight.
nnoremap <Leader>n :noh<cr>

" Yank until the end of line.
noremap Y y$

" }}}

"" Language configuration {{{

filetype plugin indent on
syntax on
syntax enable

" Indentation for various languages.
autocmd Filetype python,java,scala,javascript,php,c,c++,julia set sw=4 sts=4 et
autocmd FileType ruby,eruby,yaml,html,sass,cucumber set sw=2 sts=2 et

au BufNewFile,BufRead PKGBUILD set ft=sh

augroup vimscript
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal foldlevel=1
augroup END

" }}}

" Remove any trailing whitespace that is in the file.
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Introduce current date as yyyy-mm-dd.
autocmd Filetype markdown,vimwiki nnoremap <buffer> <LocalLeader>dt :.!today --hyphen<cr>

" Introduce current time as HH:MM.
autocmd Filetype markdown,vimwiki nnoremap <buffer> <LocalLeader>dh :.!now<cr>
