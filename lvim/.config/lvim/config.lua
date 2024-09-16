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

vim.g.root_spec = { { ".git", "lua" }, "cwd" }

lvim.format_on_save.enabled = true

-- -- formatters
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   {
--     command = "prettier",
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }


local lspconfig = require("lspconfig")

-- Astro langauge server
lspconfig.astro.setup({})
-- vim.filetype.add({
--   extension = {
--     mdx = 'mdx'
--   }
-- })

-- vim.treesitter.language.register("markdown", "mdx")

-- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
-- ft_to_parser.mdx = "markdown"

lvim.plugins = {
  {
    "davidmh/mdx.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },
  -- rust
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
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
}

lvim.colorscheme = "catppuccin"

local function biome_lsp_or_prettier(bufnr)
  local has_biome_lsp = vim.lsp.get_clients({
    bufnr = bufnr,
    name = "biome",
  })[1]
  if has_biome_lsp then
    return {}
  end
  local has_prettier = vim.fs.find({
    -- https://prettier.io/docs/en/configuration.html
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
  }, { upward = true })[1]
  if has_prettier then
    return { "prettier" }
  end
  return { "biome" }
end

return {
  {
    "stevearc/conform.nvim",
    ---@class ConformOpts
    opts = {
      formatters_by_ft = {
        javascript = biome_lsp_or_prettier,
        typescript = biome_lsp_or_prettier,
        javascriptreact = biome_lsp_or_prettier,
        typescriptreact = biome_lsp_or_prettier,
        json = { "biome" },
        jsonc = { "biome" },
      },
    },
  },
}
