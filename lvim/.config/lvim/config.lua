vim.opt.relativenumber = true
vim.opt.wrap = true

vim.g.neovide_input_macos_alt_is_meta = true

-- split
lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"

-- movement
lvim.keys.normal_mode["<C_d>"] = "<C_d>zz"
lvim.keys.normal_mode["<C_u>"] = "<C_u>zz"

-- Spectre
lvim.keys.normal_mode["<leader>S"] = '<cmd>lua require("spectre").toggle()<CR>'
lvim.keys.normal_mode["<leader>sw"] = '<cmd>lua require("spectre").open_visual({select_word=true})<CR>'
lvim.keys.visual_mode["<leader>sw"] = '<esc><cmd>lua require("spectre").open_visual()<CR>'
lvim.keys.normal_mode["<leader>sp"] = '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>'

lvim.format_on_save.enabled = true

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact" },
  },
}

lvim.plugins = {
  -- rust
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  -- theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        alpha = true,
        mason = true,
        noice = true,
        dap_ui = true,
        nvimtree = true,
        ts_rainbow2 = true,
        window_picker = true,
        telescope = true,
        which_key = true,
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        }
      }
    }
  },

  -- search and replace
  {
    "windwp/nvim-spectre",
    event = "BufRead",
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    }
  },
  {
    "zbirenbaum/copilot-cmp",
    opts = {
      fix_pairs = true
    }
  },
}

lvim.colorscheme = "catppuccin"
