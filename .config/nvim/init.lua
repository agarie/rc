-- Carlos Agarie's vimrc

vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- Plugins — installation
require('plugins')

-- General {{{
vim.opt.hidden = true
vim.opt.backspace = { "indent", "eol", "start" } -- Backspace can delete stuff in insert mode.
vim.opt.clipboard = "unnamedplus"  -- Enable system clipboard.
vim.opt.number = true                        -- Show line numbers.
vim.opt.relativenumber = true
vim.opt.cursorline = true                    -- Highlight current line.
vim.opt.backup = false                      -- LOL BACKUPS
vim.opt.swapfile = false

-- Folding.
-- Don't open folds when moving around with paragraph text objects ({ and }).
vim.opt.foldopen:remove("block")

-- Show fold information in the gutter.
vim.opt.foldcolumn = "1"

-- Use Treesitter for code folding.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Indentation
vim.opt.autoindent = true                    -- Copies current line indentation when creating a new line.
vim.opt.tabstop = 8                     -- Hard tabs (eww) are equivalent to 8 spaces.
vim.opt.softtabstop = 2                 -- Tab key, 1 tab = 2 spaces.
vim.opt.shiftwidth = 2                  -- Autoindent, 1 tab = 2 spaces.
vim.opt.shiftround = true                    -- Indentation is set to multiples of shiftwidth.
vim.opt.expandtab = true                     -- Never use hard tabs. To insert one, use CTRL-V <Tab>.

-- Searching
vim.opt.hlsearch = true                      -- Highlight matches.
vim.opt.incsearch = true                     -- Incremental search.
vim.opt.ignorecase = true                    -- Ignore case...
vim.opt.smartcase = true                     -- ... except when they contain at least one capital letter.

-- Open new split panes to right and bottom.
vim.cmd([[
	set splitbelow
	set splitright

	colorscheme molokai

" Window height.
	set winheight=30
]])
-- }}}

-- Plugin config {{{

-- Telescope
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {".git", "node_modules"}
  }
}

vim.cmd([[
	nnoremap <C-P> <cmd>Telescope find_files hidden=true<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>
]])

-- LSP
require'nvim-treesitter.configs'.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.solargraph.setup{}

local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup {
      mapping = {
         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
         ["<C-f>"] = cmp.mapping.scroll_docs(4),
         ["<C-e>"] = cmp.mapping.close(),
         ["<c-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
         },
      },
      formatting = {
         format = lspkind.cmp_format {
            with_text = true,
            menu = {
               buffer   = "[buf]",
               nvim_lsp = "[LSP]",
               path     = "[path]",
            },
         },
      },
      sources = {
         { name = "nvim_lsp"},
         { name = "path" },
         { name = "buffer" , keyword_length = 5},
      }
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- airline
vim.cmd([[
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = " ℅:"

" vim-markdown
let g:markdown_folding = 1
]])
-- }}}

-- vimwiki {{{

-- Configuration for my personal notes.
vim.g.vimwiki_list = {{
  path = '/home/agarie/Code/Personal/notes',
  path_html = '/home/agarie/Code/Personal/notes/notes_html',
  template_path = '/home/agarie/Code/Personal/notes/_templates',
  custom_wiki2html = 'vimwiki_markdown',
  syntax = 'markdown',
  ext = '.md',
  html_filename_parameterization = 1,
  auto_generate_links = 1,
  auto_diary_index = 1,
  auto_tags = 1
}}

vim.g.vimwiki_folding = 'expr'

-- Do not create a 'temporary wiki' whenever I open a *.md file.
-- A temporary wiki is a mechanism by which vimwiki can create an anonymous
-- wiki if it can't find one defined in your environment.
vim.g.vimwiki_global_ext = 0

-- }}}

-- Remaps {{{

-- Use ,k to break into a new line.
vim.cmd([[nnoremap <Leader>k i<cr><esc>k$]])

-- Use ,e to edit files in the current directory.
vim.cmd([[cnoremap %% <C-R>=expand('%:h').'/'<cr>]])
vim.cmd([[map <Leader>e :edit %%<cr>]])

-- Use ^J, ^K, ^L and ^H to navigate between splits.
vim.cmd([[
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
]])

-- Use <Leader>- and <Leader>= to navigate between tabs.
vim.keymap.set('n', '<Leader>-', ':tabprevious<CR>')
vim.keymap.set('n', '<Leader>=', ':tabnext<CR>')

-- "in line" (entire line sans white-space; cursor at beginning--ie, ^)
vim.cmd([[
xnoremap <silent> iL :<c-u>normal! g_v^<cr>
onoremap <silent> iL :<c-u>normal! g_v^<cr>
]])

-- "around line" (entire line sans trailing newline; cursor at beginning--ie, 0)
vim.cmd([[
xnoremap <silent> aL :<c-u>normal! $v0<cr>
onoremap <silent> aL :<c-u>normal! $v0<cr>
]])

-- Exit insert mode.
vim.cmd([[inoremap jk <esc>]])

-- Save file path for c/p.
vim.cmd([[noremap \l :let @+ = expand('%')<cr>]])
vim.cmd([[nnoremap <Leader>/ :Ggrep! <c-r>=expand('<cword>')<CR>]])

vim.cmd([[
noremap \\ :wa<return>
noremap ZA :wa<cr>:qa<cr>
noremap ZC :qa!<cr>
]])

-- Highlight words without moving cursor.
vim.cmd([[noremap <Leader><Leader>h *#]])

-- Search and replace word under cursor.
vim.cmd([[nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/]])

-- Clear highlight.
vim.cmd([[nnoremap <Leader>n :noh<cr>]])

-- Yank until the end of line.
vim.cmd([[noremap Y y$]])

-- }}}

-- Language configuration {{{

vim.cmd([[
filetype plugin indent on
syntax on
syntax enable
]])

-- Indentation for various languages.
vim.cmd([[
autocmd Filetype python,java,scala,javascript,php,c,c++,julia set sw=4 sts=4 et
autocmd FileType ruby,eruby,yaml,html,sass,cucumber set sw=2 sts=2 et
]])

vim.cmd([[au BufNewFile,BufRead PKGBUILD set ft=sh]])

vim.cmd([[
augroup vimscript
  autocmd!
  autocmd FileType vim,lua setlocal foldmethod=marker
augroup END

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal foldlevel=1
augroup END
]])

-- }}}

-- Extra autocommands and functions {{{

-- Remove any trailing whitespace that is in the file.
vim.cmd([[autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif]])

-- Introduce current date as yyyy-mm-dd.
vim.cmd([[autocmd Filetype markdown,vimwiki nnoremap <buffer> <LocalLeader>dt :.!today --hyphen<cr>]])

-- Introduce current time as HH:MM.
vim.cmd([[autocmd Filetype markdown,vimwiki nnoremap <buffer> <LocalLeader>dh :.!now<cr>]])

-- Remove content under current header in vimwiki.
-- This mapping is recursive as it is using the vimwiki header text-object.
-- See :help vimwiki-text-objects
vim.cmd([[autocmd Filetype vimwiki nmap <buffer> <LocalLeader>xh [[jdih]])

-- Scratch buffer.
-- https://www.gilesorr.com/blog/vim-tips-23-scratch-buffer.html
vim.cmd([[
function Newscratch()
    execute 'tabnew '
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
endfunction
command! Ns call Newscratch()
]])

-- }}}

