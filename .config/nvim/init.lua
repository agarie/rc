-- Carlos Agarie's vimrc

-- --
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

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
vim.opt.tabstop = 8 -- Hard tabs are equivalent to 8 spaces.
vim.opt.shiftwidth = 2 -- Autoindent, 1 tab = 2 spaces.
vim.opt.shiftround = true -- Indentation is set to multiples of shiftwidth.
vim.opt.expandtab = true -- Never use hard tabs. To insert one, use CTRL-V <Tab>.

-- Searching
vim.opt.hlsearch = false -- Use <Leader>n to toggle.
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
-- }}}

-- LSP configuration {{{
require('mason').setup()

vim.lsp.enable('cssls')
vim.lsp.enable('marksman')
vim.lsp.enable('jedi_language_server')
vim.lsp.enable('solargraph')
vim.lsp.enable('lua_ls')
vim.lsp.enable('harper_ls')

vim.lsp.config('lua_ls', {
  on_init = function(client)
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})

-- Disable easily-triggered linters that don't add a lot to my writing.
vim.lsp.config('harper_ls', {
  filetypes = { 'markdown' },
  settings = {
    ["harper-ls"] = {
      linters = {
        SentenceCapitalization = false,
        SpellCheck = false
      }
    }
  }
})

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

-- TODO: Check if there are other LSP capabilities that need keymaps.
-- NOTE: Default keymaps in Neovim 0.11:
--
-- https://neovim.io/doc/user/lsp.html#_defaults
--
-- GLOBAL DEFAULTS
-- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
-- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
-- "grr" is mapped in Normal mode to vim.lsp.buf.references()
-- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
-- "grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
-- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
-- "an" and "in" are mapped in Visual mode to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range()
--
-- BUFFER-LOCAL DEFAULTS
-- 'omnifunc' is set to vim.lsp.omnifunc(), use i_CTRL-X_CTRL-O to trigger completion.
-- 'tagfunc' is set to vim.lsp.tagfunc(). This enables features like go-to-definition, :tjump, and keymaps like CTRL-], CTRL-W_], CTRL-W_} to utilize the language server.
-- 'formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it.
-- To opt out of this use gw instead of gq, or clear 'formatexpr' on LspAttach.
-- K is mapped to vim.lsp.buf.hover() unless 'keywordprg' is customized or a custom keymap for K exists.
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc='LSP: [G]o to [D]efinition' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc='LSP: [G]o to [R]eferences' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc='LSP: [C]ode [A]ction' })

-- Diagnostics.
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

-- General Keymaps {{{

vim.keymap.set('n', '<leader>k', 'i<cr><esc>k$', { desc = 'Use <leader>k to break into a new line.'})

-- Use ^J, ^K, ^L and ^H to navigate between splits.
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { desc = 'Move to the split below.' })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { desc = 'Move to the split above.' })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { desc = 'Move to the split to the right.' })
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { desc = 'Move to the split to the left.' })

-- Use <Leader>- and <Leader>= to navigate between tabs.
vim.keymap.set('n', '<Leader>-', ':tabprevious<CR>')
vim.keymap.set('n', '<Leader>=', ':tabnext<CR>')

-- These mapping allow iL and aL to work similar to a text-object.
vim.keymap.set({'x', 'o'}, 'iL', ':<c-u>normal! g_v^<cr>', { desc = 'in line: entire line except whitespace (from ^)' })
vim.keymap.set({'x', 'o'}, 'aL', ':<c-u>normal! $v0<cr>', { desc = 'around line: entire line except trailing newline (from 0)' })

-- Exit insert mode.
vim.keymap.set('i', 'jk', '<esc>', { noremap = true, desc = 'Exit insert mode' })

-- TODO: This conflicts with Telescope. How does it compare to Telescope's `builtin.git_files`?
vim.keymap.set('n', '<Leader>/', ":Ggrep! -q <c-r>=expand('<cword>')<CR><CR>", { desc = 'Search git files for the word under the cursor.' })

-- TODO: This conflicts with Telescope's `builtin.resume`.
-- Search and replace word under cursor. See `:help c_CTRL-r_CTRL-w`.
vim.keymap.set('n', '<Leader>sr', ":%s/\\<<C-r><C-w>\\>/")

-- Toggle highlight.
vim.keymap.set('n', '<Leader>n', function ()
  vim.o.hlsearch = not vim.o.hlsearch
end, { desc = 'Toggle hlsearch' })
-- }}}

-- todo-comments {{{

require('todo-comments').setup()

vim.keymap.set('n', ']t', function () require('todo-comments').jump_next() end, { desc = "Next TODO comment" })
vim.keymap.set('n', '[t', function () require('todo-comments').jump_prev() end, { desc = "Previous TODO comment" })
-- }}}

-- nvim-surround {{{
-- Using default config.
require("nvim-surround").setup()
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
