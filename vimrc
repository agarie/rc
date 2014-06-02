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
set cursorline   " Line cursors aren't necessary with relativenumber set.
set synmaxcol=100  " Only use syntax highlighting in small lines.
syntax sync minlines=256

" Code folding is ugly.
set nofoldenable

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
set smartindent

" Searching
set hlsearch    " Highlight matches.
set incsearch   " Incremental search.
set ignorecase  " Ignore case.
set smartcase   " ... except when they contain at least one capital letter.

" Use ' to reindent lines.
noremap ' =

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

" Highlight all characters past 80 columns.
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%80v.*/
augroup END

" Show statusline in last window as well.
set laststatus=2

" Display path relative to current dir in statusline. Taken from:
" http://got-ravings.blogspot.com.br/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%f\ [%{strlen(&fenc)?&fenc:'none'},\ %{&ff}][%{&fo}]%h%m%r%y%=%c,%l/%L\ %P

" Language configuration.

" Python, Java and Scala are better with 4 spaces.
autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype java setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype scala setlocal tabstop=4 softtabstop=4 shiftwidth=4

" See Ruby autocompletion help with :help ft-ruby-omni
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

" Ruby path to speed up vim startup time.
let g:ruby_path = "$HOME/.rvm/rubies/default/bin/ruby"

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

" Highlight words to avoid in tech writing
" =======================================
"
"   obviously, basically, simply, of course, clearly,
"   just, everyone knows, However, So, easy
"
"   http://css-tricks.com/words-avoid-educational-writing/

highlight TechWordsToAvoid ctermbg=red ctermfg=white
match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy/
autocmd BufWinEnter *.md match TechWordsToAvoid /\cobviously\|obvious\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd InsertEnter *.md match TechWordsToAvoid /\cobviously\|obvious\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd InsertLeave *.md match TechWordsToAvoid /\cobviously\|obvious\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd BufWinLeave *.md call clearmatches()
