local packer = require('packer')

packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'JuliaEditorSupport/julia-vim'
  use 'LaTeX-Box-Team/LaTeX-Box'
  use 'Raimondi/delimitMate'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'mattn/emmet-vim'
  use 'neovim/nvim-lspconfig'
  use 'neovimhaskell/haskell-vim'
  use 'numToStr/Comment.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'onsails/lspkind.nvim'
  use 'pangloss/vim-javascript'
  use 'rlue/vim-fold-rspec'
  use 'rust-lang/rust.vim'
  use 'stephpy/vim-php-cs-fixer'
  use 'godlygeek/tabular'
  use 'hail2u/vim-css3-syntax'
  use 'sudar/vim-arduino-syntax'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-endwise'
  use 'tpope/vim-fugitive'
  use 'vim-airline/vim-airline'
  use 'vimwiki/vimwiki'

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)
