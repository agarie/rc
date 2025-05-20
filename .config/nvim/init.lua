-- Carlos Agarie's vimrc

-- --
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- Plugins are stored in lua/plugins.lua.
require('plugins')

-- General {{{
vim.opt.hidden = true
vim.opt.backspace = { "indent", "eol", "start" } -- Backspace can delete stuff in insert mode.
vim.opt.clipboard = "unnamedplus" -- Enable system clipboard.
vim.opt.number = true -- Show line numbers.
vim.opt.relativenumber = true
vim.opt.cursorline = true -- Highlight current line.
vim.opt.backup = false -- LOL BACKUPS
vim.opt.swapfile = false

-- Folding.
-- Don't open folds when moving around with paragraph text objects ({ and }).
vim.opt.foldopen:remove("block")

-- Show fold information in the gutter.
vim.opt.foldcolumn = "1"

-- Indentation
vim.opt.autoindent = true -- Copies current line indentation when creating a new line.
vim.opt.tabstop = 8 -- Hard tabs (eww) are equivalent to 8 spaces.
vim.opt.softtabstop = 2 -- Tab key, 1 tab = 2 spaces.
vim.opt.shiftwidth = 2 -- Autoindent, 1 tab = 2 spaces.
vim.opt.shiftround = true -- Indentation is set to multiples of shiftwidth.
vim.opt.expandtab = true -- Never use hard tabs. To insert one, use CTRL-V <Tab>.

-- Searching
vim.opt.hlsearch = false -- Do not highlight matches.
vim.opt.incsearch = true -- Incremental search.
vim.opt.ignorecase = true -- Ignore case...
vim.opt.smartcase = true -- ... except when they contain at least one capital letter.

-- Open new split panes to right and bottom.
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.winheight = 30
-- }}}

-- Colorscheme {{{
require('tokyonight').setup({
  on_colors = function (colors)
    -- The default color for the gutter text is illegible.
    colors.fg_gutter = colors.magenta
  end,
  on_highlights = function (highlights, colors)
    -- By changing the gutter color, we end up making folded text also illegible.
    -- TODO: It is probably better to check which highlight control the color of the line numbers on the gutter.
    highlights.Folded = {
      bg = require('tokyonight.util').darken(colors.purple, 0.3)
    }
  end
})
vim.cmd.colorscheme "tokyonight"
-- }}}

-- Telescope configuration {{{
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {".git", "node_modules"}
  }
}

-- Enable telescope fzf.
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]resume' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind [B]uffers'})
vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files({ hidden = true }) end, { desc = 'Find files'})
-- }}}

-- Treesitter configuration {{{
require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = 'elixir'
  }
}
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- These parameters work well with Ruby/Python files.
vim.opt.foldnestmax = 3
vim.opt.foldlevel = 2
-- }}}

-- LSP configuration {{{
require('mason').setup()
require('mason-lspconfig').setup()

require('lspconfig').cssls.setup{}
require('lspconfig').marksman.setup{}
require('lspconfig').jedi_language_server.setup{}
require('lspconfig').solargraph.setup{}
require('lspconfig').lua_ls.setup{}
require("elixir").setup()

local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
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
      mode = 'symbol',
      maxwidth = 50,
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

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc='LSP: [G]o to [D]efinition' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc='LSP: [G]o to [R]eferences' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc='LSP: [C]ode [A]ction' })

-- Diagnostics.
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc='Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc='Go to next diagnostic message' })
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc='Open diagnostic list' })
--- }}}

-- lualine {{{
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'molokai'
  },
  sections = { -- Copied from the nvim-lualine repo's README
    lualine_a = {
      {
        'lsp_status',
        icon = '', -- f013
        symbols = {
          -- Standard unicode symbols to cycle through for LSP progress:
          spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
          -- Standard unicode symbol for when LSP is done:
          done = '✓',
          -- Delimiter inserted between LSP names:
          separator = ' ',
        },
        -- List of LSP names to ignore (e.g., `null-ls`):
        ignore_lsp = {},
      }
    },
    lualine_y = {'mode'} -- vim mode is more useful than file progress IMO
  }
}
-- }}}

-- vimwiki {{{

-- Configuration for my personal notes.
vim.g.vimwiki_list = {{
  path = vim.env.HOME .. '/Code/Personal/notes',
  path_html = vim.env.HOME .. '/Code/Personal/notes/notes_html',
  template_path = vim.env.HOME .. '/Code/Personal/notes/_templates',
  custom_wiki2html = 'vimwiki_markdown',
  syntax = 'markdown',
  ext = '.md',
  html_filename_parameterization = 1,
  auto_generate_links = 1,
  auto_diary_index = 1
}}

vim.g.vimwiki_folding = 'expr'
vim.g.markdown_folding = 1

-- Do not create a 'temporary wiki' whenever I open a *.md file.
-- A temporary wiki is a mechanism by which vimwiki can create an anonymous
-- wiki if it can't find one defined in your environment.
vim.g.vimwiki_global_ext = 0
-- }}}

-- Remaps {{{

vim.keymap.set('n', '<leader>k', 'i<cr><esc>k$', { desc = 'Use <leader>k to break into a new line.'})

-- Use <leader>e to edit files in the current directory.
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
vim.keymap.set('i', 'jk', '<esc>', { noremap = true, desc = 'Exit insert mode' })

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

vim.keymap.set('n', 'Y', 'y$', { noremap = true, desc = 'Yank until the end of line' })
-- }}}

-- todo-comments {{{

require('todo-comments').setup()

vim.keymap.set('n', ']t', function () require('todo-comments').jump_next() end, { desc = "Next TODO comment" })
vim.keymap.set('n', '[t', function () require('todo-comments').jump_prev() end, { desc = "Previous TODO comment" })
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

vim.g.markdown_fenced_languages = {'html', 'ruby', 'bash', 'zsh', 'python'}

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

-- vim: foldlevel=0
