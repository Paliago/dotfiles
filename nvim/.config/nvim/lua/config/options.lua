-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.wrap = true

-- Disable inlay hints
vim.g.lazyvim_inlay_hints_enabled = false

-- Also disable via LSP directly
vim.lsp.inlay_hint.enable(false)
