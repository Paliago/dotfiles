return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "catppuccin/nvim",
    "folke/persistence.nvim",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local mocha = require("catppuccin.palettes").get_palette("mocha")

    -- Color handling functions
    local function getLen(str, start_pos)
      local byte = string.byte(str, start_pos)
      if not byte then
        return nil
      end

      return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
    end

    local function colorize(header, header_color_map, colors)
      for letter, color in pairs(colors) do
        local color_name = "AlphaJemuelKwelKwelWalangTatay" .. letter
        vim.api.nvim_set_hl(0, color_name, color)
        colors[letter] = color_name
      end

      local colorized = {}

      for i, line in ipairs(header_color_map) do
        local colorized_line = {}
        local pos = 0

        for j = 1, #line do
          local start = pos
          pos = pos + getLen(header[i], start + 1)

          local color_name = colors[line:sub(j, j)]
          if color_name then
            table.insert(colorized_line, { color_name, start, pos })
          end
        end

        table.insert(colorized, colorized_line)
      end

      return colorized
    end

    local header_variants = {
      alpha = {
        header = {
          [[           _____                    _____            _____                    _____           ]],
          [[          /\    \                  /\    \          /\    \                  /\    \          ]],
          [[         /::\    \                /::\____\        /::\____\                /::\    \         ]],
          [[        /::::\    \              /:::/    /       /:::/    /               /::::\    \        ]],
          [[       /::::::\    \            /:::/    /       /:::/    /               /::::::\    \       ]],
          [[      /:::/\:::\    \          /:::/    /       /:::/    /               /:::/\:::\    \      ]],
          [[     /:::/__\:::\    \        /:::/    /       /:::/____/               /:::/__\:::\    \     ]],
          [[    /::::\   \:::\    \      /:::/    /        |::|    |               /::::\   \:::\    \    ]],
          [[   /::::::\   \:::\    \    /:::/    /         |::|    |     _____    /::::::\   \:::\    \   ]],
          [[  /:::/\:::\   \:::\    \  /:::/    /          |::|    |    /\    \  /:::/\:::\   \:::\    \  ]],
          [[ /:::/__\:::\   \:::\____\/:::/____/           |::|    |   /::\____\/:::/  \:::\   \:::\____\ ]],
          [[ \:::\   \:::\   \::/    /\:::\    \           |::|    |  /:::/    /\::/    \:::\  /:::/    / ]],
          [[  \:::\   \:::\   \/____/  \:::\    \          |::|    | /:::/    /  \/____/ \:::\/:::/    /  ]],
          [[   \:::\   \:::\    \       \:::\    \         |::|____|/:::/    /            \::::::/    /   ]],
          [[    \:::\   \:::\____\       \:::\    \        |:::::::::::/    /              \::::/    /    ]],
          [[     \:::\   \::/    /        \:::\    \       \::::::::::/____/               /:::/    /     ]],
          [[      \:::\   \/____/          \:::\    \       ~~~~~~~~~~                    /:::/    /      ]],
          [[       \:::\    \               \:::\    \                                   /:::/    /       ]],
          [[        \:::\____\               \:::\____\                                 /:::/    /        ]],
          [[         \::/    /                \::/    /                                 \::/    /         ]],
          [[          \/____/                  \/____/                                   \/____/          ]],
          [[                                                                                              ]],
        },
        color_map = {
          [[ XXXXXXXXXX_____XXXXXXXXXXXXXXXXXXXX_____XXXXXXXXXXXX_____XXXXXXXXXXXXXXXXXXXX_____XXXXXXXXXX ]],
          [[ XXXXXXXXX/\XXXX\XXXXXXXXXXXXXXXXXX/\XXXX\XXXXXXXXXX/\XXXX\XXXXXXXXXXXXXXXXXX/\XXXX\XXXXXXXXX ]],
          [[ XXXXXXXX/PP\XXXX\XXXXXXXXXXXXXXXX/PP\____\XXXXXXXX/PP\____\XXXXXXXXXXXXXXXX/PP\XXXX\XXXXXXXX ]],
          [[ XXXXXXX/PPPP\XXXX\XXXXXXXXXXXXXX/PPP/XXXX/XXXXXXX/PPP/XXXX/XXXXXXXXXXXXXXX/PPPP\XXXX\XXXXXXX ]],
          [[ XXXXXX/PPPPPP\XXXX\XXXXXXXXXXXX/PPP/XXXX/XXXXXXX/PPP/XXXX/XXXXXXXXXXXXXXX/PPPPPP\XXXX\XXXXXX ]],
          [[ XXXXX/PPP/\PPP\XXXX\XXXXXXXXXX/PPP/XXXX/XXXXXXX/PPP/XXXX/XXXXXXXXXXXXXXX/PPP/\PPP\XXXX\XXXXX ]],
          [[ XXXX/PPP/__\PPP\XXXX\XXXXXXXX/PPP/XXXX/XXXXXXX/PPP/____/XXXXXXXXXXXXXXX/PPP/__\PPP\XXXX\XXXX ]],
          [[ XXX/PPPP\XXX\PPP\XXXX\XXXXXX/PPP/XXXX/XXXXXXXX|PP|XXXX|XXXXXXXXXXXXXXX/PPPP\XXX\PPP\XXXX\XXX ]],
          [[ XX/PPPPPP\XXX\PPP\XXXX\XXXX/PPP/XXXX/XXXXXXXXX|PP|XXXX|XXXXX_____XXXX/PPPPPP\XXX\PPP\XXXX\XX ]],
          [[ X/PPP/\PPP\XXX\PPP\XXXX\XX/PPP/XXXX/XXXXXXXXXX|PP|XXXX|XXXX/\XXXX\XX/PPP/\PPP\XXX\PPP\XXXX\X ]],
          [[ /PPP/__\PPP\XXX\PPP\____\/PPP/____/XXXXXXXXXXX|PP|XXXX|XXX/PP\____\/PPP/XX\PPP\XXX\PPP\____\ ]],
          [[ \PPP\XXX\PPP\XXX\PP/XXXX/\PPP\XXXX\XXXXXXXXXXX|PP|XXXX|XX/PPP/XXXX/\PP/XXXX\PPP\XX/PPP/XXXX/ ]],
          [[ X\PPP\XXX\PPP\XXX\/____/XX\PPP\XXXX\XXXXXXXXXX|PP|XXXX|X/PPP/XXXX/XX\/____/X\PPP\/PPP/XXXX/X ]],
          [[ XX\PPP\XXX\PPP\XXXX\XXXXXXX\PPP\XXXX\XXXXXXXXX|PP|____|/PPP/XXXX/XXXXXXXXXXXX\PPPPPP/XXXX/XX ]],
          [[ XXX\PPP\XXX\PPP\____\XXXXXXX\PPP\XXXX\XXXXXXXX|PPPPPPPPPPP/XXXX/XXXXXXXXXXXXXX\PPPP/XXXX/XXX ]],
          [[ XXXX\PPP\XXX\PP/XXXX/XXXXXXXX\PPP\XXXX\XXXXXXX\PPPPPPPPPP/____/XXXXXXXXXXXXXXX/PPP/XXXX/XXXX ]],
          [[ XXXXX\PPP\XXX\/____/XXXXXXXXXX\PPP\XXXX\XXXXXXX~~~~~~~~~~XXXXXXXXXXXXXXXXXXXX/PPP/XXXX/XXXXX ]],
          [[ XXXXXX\PPP\XXXX\XXXXXXXXXXXXXXX\PPP\XXXX\XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/PPP/XXXX/XXXXXX ]],
          [[ XXXXXXX\PPP\____\XXXXXXXXXXXXXXX\PPP\____\XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/PPP/XXXX/XXXXXXX ]],
          [[ XXXXXXXX\PP/XXXX/XXXXXXXXXXXXXXXX\PP/XXXX/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\PP/XXXX/XXXXXXXX ]],
          [[ XXXXXXXXX\/____/XXXXXXXXXXXXXXXXXX\/____/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\/____/XXXXXXXXX ]],
          [[ XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ]],
        },
        colors = {
          ["X"] = { fg = mocha.base },
          ["P"] = { fg = mocha.pink },
        },
      },
      blurred = {
        header = {
          [[ ░▒▓████████▓▒░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░   ]],
          [[ ░▒▓█▓▒░      ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ]],
          [[ ░▒▓█▓▒░      ░▒▓█▓▒░    ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░  ]],
          [[ ░▒▓██████▓▒░ ░▒▓█▓▒░    ░▒▓█▓▒▒▓█▓▒░░▒▓████████▓▒░  ]],
          [[ ░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░  ]],
          [[ ░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░  ]],
          [[ ░▒▓████████▓▒░▒▓████████▓▒░▒▓██▓▒░  ░▒▓█▓▒░░▒▓█▓▒░  ]],
        },
        color_map = {
          [[ LBGFFFFFFFFGBLBGFGBL   LBGFGBLLBGFGBLLBGFFFFFFGBL   ]],
          [[ LBGFGBL      LBGFGBL   LBGFGBLLBGFGBLBGFGBLLBGFGBL  ]],
          [[ LBGFGBL      LBGFGBL    LBGFGBBGFGBLLBGFGBLLBGFGBL  ]],
          [[ LBGFFFFFFGBL LBGFGBL    LBGFGBBGFGBLLBGFFFFFFFFGBL  ]],
          [[ LBGFGBL      LBGFGBL     LBGFGGFGBL LBGFGBLLBGFGBL  ]],
          [[ LBGFGBL      LBGFGBL     LBGFGGFGBL LBGFGBLLBGFGBL  ]],
          [[ LBGFFFFFFFFGBLBGFFFFFFFFGBLBGFFGBL  LBGFGBLLBGFGBL  ]],
        },
        colors = {
          ["L"] = { fg = mocha.pink },
          ["B"] = { fg = mocha.pink },
          ["G"] = { fg = mocha.pink },
          ["F"] = { fg = mocha.pink },
        },
      },
      bulb = {
        header = {
          [[  ____  __  _  _  __    ]],
          [[ ( ___)(  )( \/ )/__\   ]],
          [[  )__)  )(__\  //(__)\  ]],
          [[ (____)(____)\/(__)(__) ]],
        },
        color_map = {
          [[  PPPP  PP  P  P  PP    ]],
          [[ P PPPPP  PP PP PPPPP   ]],
          [[  PPPP  PPPPP  PPPPPPP  ]],
          [[ PPPPPPPPPPPPPPPPPPPPPP ]],
        },
        colors = {
          ["P"] = { fg = mocha.pink },
        },
      },
      flower = {
        header = {
          [[     .-''-.    .---.   ,---.  ,---.   ____      ]],
          [[   .'_ _   \   | ,_|   |   /  |   | .'  __ `.   ]],
          [[  / ( ` )   ',-./  )   |  |   |  .'/   '  \  \  ]],
          [[ . (_ o _)  |\  '_ '`) |  | _ |  | |___|  /  |  ]],
          [[ |  (_,_)___| > (_)  ) |  _( )_  |    _.-`   |  ]],
          [[ '  \   .---.(  .  .-' \ (_ o._) / .'   _    |  ]],
          [[  \  `-'    / `-'`-'|___\ (_,_) /  |  _( )_  |  ]],
          [[   \       /   |        \\     /   \ (_ o _) /  ]],
          [[    `'-..-'    `--------` `---`     '.(_,_).'   ]],
        },
        color_map = {
          [[     PPPPPP    PPPPP   PPPPP  PPPPP   PPPP      ]],
          [[   PPX X   P   P XXP   P   P  P   P PP  PP PP   ]],
          [[  P X X X   PXXXX  X   P  P   P  PPP   P  P  P  ]],
          [[ P XX Y XX  PX  XY XXX P  P X P  P PPPPP  P  P  ]],
          [[ P  XXXXXPPPP X YYY  X P  XX XX  P    PPPP   P  ]],
          [[ P  P   PPPPPX  X  XXX P XX YXXX P PP   X    P  ]],
          [[  P  PPP    P XXXXXXPPPPP XXXXX P  P  XX XX  P  ]],
          [[   P       P   P        PP     P   P XX Y XX P  ]],
          [[    PPPPPPP    PPPPPPPPPP PPPPP     PPXXXXXPP   ]],
        },
        colors = {
          ["P"] = { fg = mocha.blue },
          ["X"] = { fg = mocha.pink },
          ["Y"] = { fg = mocha.yellow },
        },
      },
    }

    -- Function to get a random header variant
    local function get_random_variant()
      local keys = {}
      for key, _ in pairs(header_variants) do
        table.insert(keys, key)
      end
      return keys[math.random(#keys)]
    end

    -- Select a random header variant
    local current_variant = get_random_variant()

    -- Set up the dashboard
    local variant = header_variants[current_variant]
    dashboard.section.header.val = variant.header
    dashboard.section.header.opts = {
      hl = colorize(variant.header, variant.color_map, variant.colors),
      position = "center",
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      button.opts.width = 49
      button.opts.cursor = -2
    end

    -- Set up alpha
    alpha.setup(dashboard.config)

    -- Update footer with startup info
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local v = vim.version()
        local version = v.major .. "." .. v.minor .. "." .. v.patch
        local plugins_count = stats.count
        local time = os.date("%H:%M:%S")
        local date = os.date("%d.%m.%Y")

        dashboard.section.footer.val = {
          " " .. plugins_count .. " plugins loaded in " .. ms .. "ms",
          "󰃭 " .. date .. "  " .. time,
          " " .. version,
        }

        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    -- Disable folding on alpha buffer
    vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])
  end,
}
