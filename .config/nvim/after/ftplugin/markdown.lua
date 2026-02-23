vim.g.markdown_fenced_languages = {'html', 'ruby', 'bash', 'zsh', 'python', 'js', 'ts' }

vim.opt_local.foldlevel = 1

vim.opt_local.shiftwidth = 4

vim.opt_local.conceallevel = 1

-- Taken from the nvim-treesitter documentation.
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown' },
    callback = function()
      -- syntax highlighting, provided by Neovim
      vim.treesitter.start()
      -- folds, provided by Neovim
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      -- indentation, provided by nvim-treesitter
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
