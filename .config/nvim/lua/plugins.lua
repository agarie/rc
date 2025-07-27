local packer = require('packer')

packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use "folke/tokyonight.nvim"

  -- Telescope.
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    }
  }

  -- Provides default configuration for several LSP servers.
  use 'neovim/nvim-lspconfig'

  -- Utility to install LSP servers and a lot of other software.
  use 'williamboman/mason.nvim'

  -- Offers icons to make LSP look neater. Kinda useless, will probably remove.
  use 'onsails/lspkind.nvim'

  use {
    "elixir-tools/elixir-tools.nvim",
    tag = "stable",
    requires = {
      "nvim-lua/plenary.nvim"
    }
  }

  -- Completion.
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    }
  }

  -- Configure Treesitter to update its parsers automatically.
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Git.
  use 'tpope/vim-fugitive'

  -- Reformat tabular data with :Tabularize.
  use 'godlygeek/tabular'

  -- Add `end` to blocks in Ruby, Elixir, etc.
  use 'RRethy/nvim-treesitter-endwise'

  -- Work with bulleted/numbered lists.
  use 'dkarter/bullets.vim'

  use 'preservim/nerdtree'

  use {
    'folke/todo-comments.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- Implements commenting operators: gc (line comment) and gb (block comment).
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Language-specific plugins.
  use 'LaTeX-Box-Team/LaTeX-Box'
  use 'mattn/emmet-vim'

  -- Enables folding of specs/contexts/etc in RSpec.
  -- TODO: Maybe a Treesitter implementation would be faster?
  use 'rlue/vim-fold-rspec'

  -- statusline.
  use 'nvim-lualine/lualine.nvim'

  -- Personal wiki.
  use 'vimwiki/vimwiki'

  -- Add/delete/edit surrounding marks with ys{motion}{char}, ds{char}, cs{target}{replacement}.
  use {
    "kylechui/nvim-surround",
    tag = "*",
  }
end)
