-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "catppuccin-mocha"

vim.opt.number = true
vim.opt.relativenumber = true

lvim.format_on_save.enabled = true

vim.opt.guifont = "FiraCode Nerd Font Mono:h15"

vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_remember_window_size = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- split
lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"

-- Spectre
lvim.keys.normal_mode["<leader>S"] = '<cmd>lua require("spectre").toggle()<CR>'
lvim.keys.normal_mode["<leader>sw"] = '<cmd>lua require("spectre").open_visual({select_word=true})<CR>'
lvim.keys.visual_mode["<leader>sw"] = '<esc><cmd>lua require("spectre").open_visual()<CR>'
lvim.keys.normal_mode["<leader>sp"] = '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>'

-- Project
lvim.keys.normal_mode["<leader>P"] = '<cmd>lua require("telescope").extensions.project.project{}<CR>'


-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    -- extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    -- filetypes = { "typescript", "typescriptreact" },
  },
}

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "frecency")
  pcall(telescope.load_extension, "neoclip")
  pcall(telescope.load_extension, "project")
  pcall(telescope.load_extension, "ui-select")
  -- any other extensions loading
end

-- Additional Plugins
lvim.plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    config = function()
      require("telescope").load_extension("project")
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  table.insert(lvim.plugins, {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  })
}
