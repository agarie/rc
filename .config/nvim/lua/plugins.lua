local packer = require('packer')

packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope.
  use 'nvim-telescope/telescope.nvim'

  -- LSP.
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'onsails/lspkind.nvim'

  -- Treesitter.

  -- Completion.
  use 'hrsh7th/nvim-cmp'

  -- Git.
  use 'tpope/vim-fugitive'

  -- asdf
  use 'godlygeek/tabular'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-endwise'
  use 'dkarter/bullets.vim'
  use 'Raimondi/delimitMate'
  use 'numToStr/Comment.nvim'

  -- Language-specific plugins.
  use 'JuliaEditorSupport/julia-vim'
  use 'LaTeX-Box-Team/LaTeX-Box'
  use 'sudar/vim-arduino-syntax'
  use 'mattn/emmet-vim'
  use 'neovimhaskell/haskell-vim'
  use 'pangloss/vim-javascript'
  use 'rlue/vim-fold-rspec'
  use 'rust-lang/rust.vim'
  use 'stephpy/vim-php-cs-fixer'

  use 'nvim-lua/plenary.nvim'

  -- line
  use 'vim-airline/vim-airline'

  -- Personal wiki.
  use 'vimwiki/vimwiki'

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)
