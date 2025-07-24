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

  -- LSP.
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind.nvim'
  use 'williamboman/mason.nvim'

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

  -- asdf
  use 'godlygeek/tabular'
  use 'RRethy/nvim-treesitter-endwise'
  use 'dkarter/bullets.vim'
  use 'Raimondi/delimitMate'

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
