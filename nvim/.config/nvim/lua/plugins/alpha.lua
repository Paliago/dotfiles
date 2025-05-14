return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "catppuccin/nvim",
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
      default = {
        header = {
          [[                                                                     ███████████                                                  ]],
          [[                                                                 ███████████████████████                                          ]],
          [[                                                             █████████████████████████████                                        ]],
          [[                                                  █████████████████████████████████████████                                       ]],
          [[                                                █████████████████████████████████████████████                                     ]],
          [[                           █████████████████████████████████████████████████████████████████████████                              ]],
          [[                         ████████████████████████████████████████████████████████████████████████████                             ]],
          [[                        ███████████████████████████████████████████████████████████████████████████████                           ]],
          [[                        ███████████████████████████████████████████████████████████████████████████████                           ]],
          [[                        ███████████████████████████████████████████████████████████████████████████████                           ]],
          [[                       █████████████████████████████████████████████████████████████████████████████████                          ]],
          [[                       █████████████████████████████████████████████████████████████████████████████████                          ]],
          [[                       █████████████████████████████████████████████████████████████████████████████████                          ]],
          [[                       ██████████████████████████████████████████████████████████████████████████████████                         ]],
          [[                      ███████████████████████████████████████████████████████████████████████████████████                         ]],
          [[                      ████████████████████████████████████████████████████████████████████████████████████                        ]],
          [[                      ████████████████████████████████████████████████████████████████████████████████████                        ]],
          [[                      █████████████████████████████████████████████████████████████████████████████████████                       ]],
          [[                     ███████████████████████████████████████████████████████████████████████████████████████                      ]],
          [[                     ████████████████████████████████████████████████████████████████████████████████████████                     ]],
          [[                     ████████████████████████████████████████████████████████████████████████████████████████                     ]],
          [[                     ██████████████████████████████████████████████████████████████████████  ████████████████                     ]],
          [[                      ███████████████████████████████████████████████████████████████████      █████████████                      ]],
          [[                                       ████████████████████████████████████████████              █████████                        ]],
          [[                                       ██████████████████████████████████████████                                                 ]],
          [[                                       █████████████████████████████████████████                                                  ]],
          [[                                        ██████████████████████████████                                                            ]],
          [[                                          ███████████████████████                                                                 ]],
          [[                                                 ████████████                                                                     ]],
        },
        color_map = {
          [[                                                                     @@@@@@@@@@@                                                  ]],
          [[                                                                 @@@@@@@@@@@@@@@@@@@@@@@                                          ]],
          [[                                                             @@@@@@@@@@HHHHHHHH@@@@@@@@@@@                                        ]],
          [[                                                  @@@@@@@@@@@@@@@@@HHHHHHHHHHHHHHHHHHH@@@@@                                       ]],
          [[                                                @@@@@@@@@@BBBB@@@HHHHHHHHHHHHHHHHHHHHHH@@@@@@                                     ]],
          [[                           @@@@@@@@@@@@@@@@@@@@@@@@@BBBBBBBBBBBB@@HHHHHHHHHHHHHHHHHHHHH@@@@@@@@@@@@@                              ]],
          [[                         @@@@@@@@@@@@@@@@@@@@@@@@@@@BBBBBBBBBB@@@@@@HHHHHHHHHHHHHHHHHHH@@@@@@MMM@@@@@                             ]],
          [[                        @@@MMMMMMMMMMMMMMMM@@@@MM@M@@BBBBBBBBB@@MMMM@@HHHHHHHHHHHHHHHH@@@@@MMMMMM@@@@@@                           ]],
          [[                        @@@MMMMMMMMMMMMMMMM@@@MMMMM@@BBBBBBBBB@@@MMMM@@HHHHHHHH@@@@HHH@@@@@MMMMMMM@@@@@                           ]],
          [[                        @@@MMMMMMM@@@@@@@@@@@@MMMMM@@BBBBBBBBB@@@MMMMM@@HHHHH@@MMMM@@@@@@@MMMMMMMMM@@@@                           ]],
          [[                       @@@MMMMMMM@@@@@@@@@@@@@MMMMM@@BBBBBBBBB@@@MMMMM@@HHH@@@@MMMMM@@@@@@MMMMMMMMM@@@@@                          ]],
          [[                       @@@MMMMMM@@@@@@@@@@@@@MMMMMM@@BBBBBBBBB@@@@MMMMM@HH@@@MMMMMM@@@@@@MMMMMMMMMMM@@@@                          ]],
          [[                       @@@MMMMMM@@@@@@@@@@@@@MMMMMM@BBBBBBBBB@@@@@MMMMM@@@@@MMMMMM@@@@@@MMMMMMMMMMMM@@@@                          ]],
          [[                       @@@MMMMMMMMMMMMMMMM@@@MMMMMM@BBBBBBBBB@@@@@MMMMM@@@@MMMMMM@@@@@@MMMMMMM@MMMMM@@@@@                         ]],
          [[                      @@@@MMMMMMMMMMMMMM@@@@MMMMMMM@BBBBBBBB@@@@@@@MMMM@@@MMMMMM@@@@@@MMMMMMM@@@MMMMM@@@@                         ]],
          [[                      @@@@MMMMM@@@@@@@@@@@@@MMMMMM@@BBBBBBBB@@@@@@@MMMMM@MMMMMM@@HH@@MMMMMMM@@@@MMMMMM@@@@                        ]],
          [[                      @@@@MMMMM@@@@@@@@@@@@@MMMMMM@@@@@@@@@@@@@@@@@MMMMMMMMMM@@HHH@@MMMMMMM@@@@@MMMMMM@@@@                        ]],
          [[                      @@@MMMMM@@@@@@@@@@@@@@MMMMMM@@@@@@@@MMMMMMM@@MMMMMMMMM@@@HH@@MMMMMMM@@@@@@@MMMMMM@@@@                       ]],
          [[                     @@@@MMMMMMMMMMMMMMMMM@@MMMMMMMMMMMMMMMMMMM@@@@MMMMMMMM@@HHH@@MMMMMMM@@@@@@@@MMMMMMM@@@@                      ]],
          [[                     @@@@MMMMMMMMMMMMMMMMM@@MMMMMMMMMMMMMMMMMM@@@@@MMMMMMM@@HHHH@MMMMMM@@@@@@@@@@MMMMMMM@@@@@                     ]],
          [[                     @@@@MMMMMMMMMMMMMMM@@@@MMMMMMMMMMMMM@@@@@@BB@@MMMMMM@@HHHH@MMMMMM@@@@@@@@@@@@MMMMMMM@@@@                     ]],
          [[                     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@BBBBBBB@@@@@@@@@HHHHH@@@@@@@@@@@@  @@@@@MMMMMMM@@@@                     ]],
          [[                      @@@@@@@@@@@@@@@@@@@@@@@@@@@BBBBBBBBBBBBBBB@@@@HHHHHHHHHH@@@@@@@@@@@      @@@@@@@@@@@@@                      ]],
          [[                                       @@@@BBBBBBBBBBBBBBBBBBBBB@@HHHHHHHHHHHH@@@@@              @@@@@@@@@                        ]],
          [[                                       @@@@BBBBBBBBBBBBBBBBBBBB@@HHHHHH@@@@@@@@@@                                                 ]],
          [[                                       @@@@@BBBBBBBBBBBBBBBBBB@@@@@@@@@@@@@@@@@@                                                  ]],
          [[                                        @@@@@@@@@@@@BBBBBB@@@@@@@@@@@@                                                            ]],
          [[                                          @@@@@@@@@@@@@@@@@@@@@@@                                                                 ]],
          [[                                                 @@@@@@@@@@@@                                                                     ]],
        },
        colors = {
          ["@"] = { fg = mocha.crust },
          ["H"] = { fg = mocha.pink },
          ["M"] = { fg = mocha.yellow },
          ["B"] = { fg = mocha.sky },
        },
      },
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
      text = {
        header = {
          [[                                                                                                                                    ]],
          [[                                                                                                                                    ]],
          [[                                                                                                         &5G&GGG#                   ]],
          [[           P?JJJJJJJJJ?????????77JG&     Y!J  &                  B7?J5#                                  7!?~^^^^G                  ]],
          [[           7^^^^^^^^^^^^^^^^^^^^^^~#    Y^^~J7?                   7^^^~5J&                              B^!!^^^^^~!!B               ]],
          [[          B^^^^^^^~~~!!!!!!!!!!!7J#     ?^^^^^J                   P~^^^^^J             &# &             7^^^^^^^^^^^?               ]],
          [[          #~^^^^^^^JYYYJ5GGGG#          !^^^^^5                    5^^^^^^B           #PPJ!7P #&       J^^^^^^^^^!J^~#              ]],
          [[         #?~^^^^^^YPGGBB###&&          #~^^^^^B                    &~^^^^^?         B&BJ~^^7JY!5      5^^^^^^^^^^!G~^J              ]],
          [[         P^^^^^^^!                   &PB^^^^^~&                     ?^^^^^~#      B5G5~^~!~7~7P#     G^^^^^^^^^^^^~~^~#             ]],
          [[         J^^^^^^^J    &&&&###BB&     B5P^^^^^7                      Y~~^^^^Y     PGG7~^~?!^!P       B~!^^^^^^~!^^^^7~^5             ]],
          [[        &!^^^^^^^!?77!!!!~~~~^~JPB   PYJ^^^^^J                      G!7^^^^!&  & #Y~^^^~^^Y&       &!??^^^^^^YB^^^^^~^!&            ]],
          [[        #!^^^^^^^^^^^^^^^^^^^~~7JB   J!7^^^^^5                      #~7~^^^~# &YG7^^^^^^!B        &7!J^^^^^~P& !^^^^^^^P            ]],
          [[        P^^^^^^~~~~~!!77?J5PG#&      7Y7^^^^^B                      &~Y~^^^^B&BP~^^^^^^J&         ?~!~^^^^^5 B&5^^^^^^^!            ]],
          [[        P!^^~^~PYYY5GBBBB           &!Y~^^^^~#                      &!J~^^^^5 Y^^^^^^^5          ?!?^^^^^^J   Y#!^^^^^^^G           ]],
          [[       #Y!^^J^5                     B~Y~^^^^7             &&&        7^^^^^^?Y^^^^^^~G          ?^~~^^^^^Y    P P^^^^^^^7           ]],
          [[       YY?^!PY                      P~?^^^^^J  &##BBGGGGPPPPG######& ?^^^^^^^^^^~~^!B         &?^^^^^^^~P      B ?^^^^^^^P          ]],
          [[       PY!^?&&##BBGGPP55YYYJJJJJYP# Y^^^^^^^7YYJ??YYJ?77!~~~!~~~~!7J&?^^^^^^^^~~~^?&         #7^^^^^^^!B       YG&~^^^~^^~#         ]],
          [[       Y5~^~!~~~^^^^^^^^^^^^^^^^^!& 7^^^^^^^~~~~^^^^^^^^^^^^^^~7J5&  J^^^^^^^~P!^J         &P~^^^^^^^J&        &?#P7^^!J^^7&        ]],
          [[      B~~^^^^^^^^^^^^^^^^^^~!!7?5#  B7^^^^^^^^^^^^^^^^^^~!7?JYPGB#   ?^~^^^^^~!^P         P~^^^^^^^~P           #Y&Y^^^?~^^?        ]],
          [[      7^^^^^^^^^^^^^^^~~!!7?JY5B   &GJ^^^^^^^^^^~!?JYPGB#&          &~?~^^^^^^~G        &5~^^^^!?^J#             &&&J^^^~5!~?#      ]],
          [[      Y!~!!77?JY55PGBB#&&          #?^^^^^~!?YPB&                    5P5!!~Y#G#         #P5YYYP&&B                &JBY^^^7PJ~J      ]],
          [[        &&                           GJYPB#                              &&                                        &B PYPB #G       ]],
          [[                                                                                                                                    ]],
          [[                                                                                                                                    ]],
        },
        color_map = {
          [[ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ]],
          [[ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ]],
          [[ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@PPPPPPPP@@@@@@@@@@@@@@@@@@ ]],
          [[ @@@@@@@@@@PPPPPPPPPPPPPPPPPPPPPPPPP@@@@@PPP@@P@@@@@@@@@@@@@@@@@@PPPPPP@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@PPPPPPPPP@@@@@@@@@@@@@@@@@ ]],
          [[ @@@@@@@@@@PPPPPPPPPPPPPPPPPPPPPPPPP@@@@PPPPPPP@@@@@@@@@@@@@@@@@@@PPPPPPPP@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@PPPPPPPPPPPPP@@@@@@@@@@@@@@ ]],
          [[ @@@@@@@@@PPPPPPPPPPPPPPPPPPPPPPPPP@@@@@PPPPPPP@@@@@@@@@@@@@@@@@@@PPPPPPPP@@@@@@@@@@@@@PP@P@@@@@@@@@@@@@PPPPPPPPPPPPP@@@@@@@@@@@@@@ ]],
          [[ @@@@@@@@@PPPPPPPPPPPPPPPPPPPP@@@@@@@@@@PPPPPPP@@@@@@@@@@@@@@@@@@@@PPPPPPPP@@@@@@@@@@@PPPPPPP@PP@@@@@@@PPPPPPPPPPPPPPP@@@@@@@@@@@@@ ]],
          [[ @@@@@@@@PPPPPPPPPPPPPPPPPPPP@@@@@@@@@@PPPPPPPP@@@@@@@@@@@@@@@@@@@@PPPPPPPP@@@@@@@@@PPPPPPPPPPPP@@@@@@PPPPPPPPPPPPPPPP@@@@@@@@@@@@@ ]],
          [[ @@@@@@@@PPPPPPPPP@@@@@@@@@@@@@@@@@@@PPPPPPPPPP@@@@@@@@@@@@@@@@@@@@@PPPPPPPP@@@@@@PPPPPPPPPPPPPP@@@@@PPPPPPPPPPPPPPPPPP@@@@@@@@@@@@ ]],
          [[ @@@@@@@@PPPPPPPPP@@@@PPPPPPPPPP@@@@@PPPPPPPPP@@@@@@@@@@@@@@@@@@@@@@PPPPPPPP@@@@@PPPPPPPPPPPP@@@@@@@PPPPPPPPPPPPPPPPPPP@@@@@@@@@@@@ ]],
          [[ @@@@@@@PPPPPPPPPPPPPPPPPPPPPPPPPP@@@PPPPPPPPP@@@@@@@@@@@@@@@@@@@@@@PPPPPPPPP@@P@PPPPPPPPPPP@@@@@@@PPPPPPPPPPPPPPPPPPPPP@@@@@@@@@@@ ]],
          [[ @@@@@@@PPPPPPPPPPPPPPPPPPPPPPPPPP@@@PPPPPPPPP@@@@@@@@@@@@@@@@@@@@@@PPPPPPPPP@PPPPPPPPPPPP@@@@@@@@PPPPPPPPPPPP@PPPPPPPPP@@@@@@@@@@@ ]],
          [[ @@@@@@@PPPPPPPPPPPPPPPPPPPPPPP@@@@@@PPPPPPPPP@@@@@@@@@@@@@@@@@@@@@@PPPPPPPPPPPPPPPPPPPPP@@@@@@@@@PPPPPPPPPP@PPPPPPPPPPP@@@@@@@@@@@ ]],
          [[ @@@@@@@PPPPPPPPPPPPPPPPP@@@@@@@@@@@PPPPPPPPPP@@@@@@@@@@@@@@@@@@@@@@PPPPPPPPP@PPPPPPPPP@@@@@@@@@@PPPPPPPPPP@@@PPPPPPPPPPP@@@@@@@@@@ ]],
          [[ @@@@@@PPPPPPPP@@@@@@@@@@@@@@@@@@@@@PPPPPPPPP@@@@@@@@@@@@@PPP@@@@@@@@PPPPPPPPPPPPPPPPP@@@@@@@@@@PPPPPPPPPP@@@@P@PPPPPPPPP@@@@@@@@@@ ]],
          [[ @@@@@@PPPPPPP@@@@@@@@@@@@@@@@@@@@@@PPPPPPPPP@@PPPPPPPPPPPPPPPPPPPPP@PPPPPPPPPPPPPPPP@@@@@@@@@PPPPPPPPPPP@@@@@@P@PPPPPPPPP@@@@@@@@@ ]],
          [[ @@@@@@PPPPPPPPPPPPPPPPPPPPPPPPPPPP@PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP@@@@@@@@@PPPPPPPPPPP@@@@@@@PPPPPPPPPPPP@@@@@@@@ ]],
          [[ @@@@@@PPPPPPPPPPPPPPPPPPPPPPPPPPPP@PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP@@PPPPPPPPPPPPP@@@@@@@@@PPPPPPPPPPPP@@@@@@@@PPPPPPPPPPPPP@@@@@@@ ]],
          [[ @@@@@PPPPPPPPPPPPPPPPPPPPPPPPPPPP@@PPPPPPPPPPPPPPPPPPPPPPPPPPPPPP@@@PPPPPPPPPPPP@@@@@@@@@PPPPPPPPPPP@@@@@@@@@@@PPPPPPPPPPPP@@@@@@@ ]],
          [[ @@@@@PPPPPPPPPPPPPPPPPPPPPPPPPP@@@PPPPPPPPPPPPPPPPPPPPPPP@@@@@@@@@@PPPPPPPPPPPP@@@@@@@@PPPPPPPPPPPP@@@@@@@@@@@@@PPPPPPPPPPPPP@@@@@ ]],
          [[ @@@@@PPPPPPPPPPPPPPPPPPP@@@@@@@@@@PPPPPPPPPPPPPP@@@@@@@@@@@@@@@@@@@@PPPPPPPPPP@@@@@@@@@PPPPPPPPPP@@@@@@@@@@@@@@@@PPPPPPPPPPPP@@@@@ ]],
          [[ @@@@@@@PP@@@@@@@@@@@@@@@@@@@@@@@@@@@PPPPPP@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@PP@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@PP@PPPP@PP@@@@@@ ]],
          [[ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ]],
          [[ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ]],
        },
        colors = {
          ["@"] = { fg = mocha.base },
          ["P"] = { fg = mocha.pink },
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
      uwu2 = {
        header = {
          [[                                -----------                                                          ]],
          [[                              -----------------                                                      ]],
          [[                             -------------------                                                     ]],
          [[               --------------------MMMMMU}------- ---------       +------                            ]],
          [[      ------------------------?8---MMMMMMMM------------------   --------------                       ]],
          [[    ------------------------------aMMMMMMMM------------------- -----------------                     ]],
          [[   ---------------uMMMMMMMMQ------MMMMMMMMM---------MMMM-------------MM----------                    ]],
          [[  -------MMMMMMMMMMMMMMMMMMM------MMMMMMMMM-----MMMMMMMMM--------8--MMMMMMMM-------------            ]],
          [[ ---t8b--MMMMMMMMMMMMMMMMMMM------MMMMMMMM1-----]MMMMMMMMz------8--MMMMMMMMM---------------          ]],
          [[----888--MMMMMMMMMMMMMMMMMMM------MMMMMMMM-------#MMMMMMMM-----8--\MMMMMMMM-----------------         ]],
          [[ ---888--MMMMMMMMMMMMMMMMMo{------MMMMMMMM--------MMMMMMMMM---8---MMMMMMMMb----MMMMMMM)------        ]],
          [[ ---o88---MMMMMMMMM--------------pMMMMMMMM---------MMMMMMMMM--{--MMMMMMMMM---)MMMMMMMMM-------       ]],
          [[ ----88&--MMMMMMMMM--------------MMMMMMMMM----------MMMMMMMM----MMMMMMMMM---oMMMMMMMMMMM------       ]],
          [[ ----888--MMMMMMMMMMMMMMMMM------MMMMMMMMM-----------MMMMMMMM--MMMMMMMMM---dMMMMMMMMMMMMM------      ]],
          [[  ---888--bMMMMMMMMMMMMMMMM------MMMMMMMMMMMMMMMMM---#MMMMMMMMrMMMMMMMMk--{MMMMMMMMMMMMMMM------     ]],
          [[  ---m88---MMMMMMMMMMMMMMMM------MMMMMMMMMMMMMMMMM----MMMMMMMMMMMMMMMMM---MMMMMMM--MMMMMMMd------    ]],
          [[  ----888--MMMMMMMMMMMMMMMM------MMMMMMMMMMMMMMMMM-----MMMMMMMMMMMMMMM---MMMMMMM----MMMMMMM-------   ]],
          [[  ----888--MMMMMMMMMX-----------QMMMMMMMMMMMMMMMM#------MMMMMMMMMMMMM---MMMMMMMMMMM-XMMMMMMM-------  ]],
          [[   ---888--JMMMMMMMMM-----XMMMM--------(oMMMMMMMM--------MMMMMMMMMMM---dMMMMMMMMMMM--MMMMMMMM------  ]],
          [[   ---u88---MMMMMMMMMMMMMMMMMMM--------------------------ZMMMMMMMM-----MMMMMMMMMMMM---MMMMMMMM------ ]],
          [[   ----888--MMMMMMMMMMMMMMMMMMM/---------------------pppp-------------MMMMMMMMMMMMM----MMMMMMMM------]],
          [[    ---888--MMMMMMMMMMMMMMMMMMMM----------------?---1p----------------0MMMMM}----------pMMMMMMM------]],
          [[    ---888--jMMMMMMMMMMMMMMMMMMM--------------?pppp-pppp----------jpp-------------------MM-----------]],
          [[    ---]88)--MMMMMMMMM(-------ppp---pp0------pppp----QQQQ---------Qpp------pppppp----------)888----? ]],
          [[    ----888--------------r--xpppppppppZQ--------------------------QQpzppt--pppppp--88888888888----   ]],
          [[     ---888888888888888888--cQQQQQQQQQQQ]?----------8---QQQQQY(]?-QQQQQpp----ppp------88---------    ]],
          [[     ----88888888888m---888----Un-QQQQ--QQQQQQQQQ--888--QQQQQQQQQ-----------Qqp-pppp----------       ]],
          [[      ------------------88888?---QQQQ--------------w88--------------v888--QQQQ----Q------            ]],
          [[        ------------ ----88888---QQ---8888888888a--&888888888888888888888------&r--------            ]],
          [[                      -----u888q----Z88888888888----888888888888-----[88888x*888888-----             ]],
          [[                        ----8888888z----------------------------------?88888n--888----               ]],
          [[                         ----(888m---------------  --------------   -----------------                ]],
          [[                          -----------                                 -------  --                    ]],
          [[                             -----                                                                   ]],
        },
        color_map = {},
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

    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. "Find files", ":Telescope find_files <CR>"),
      dashboard.button("p", " " .. "Select project", ":Telescope neovim-project history <CR>"),
      dashboard.button("t", " " .. "Change theme", ":ThemeSwitcher <CR>"),
      dashboard.button("m", " " .. "Mason", ":Mason <CR>"),
      dashboard.button("l", "󰚰 " .. "LazyUI", ":Lazy <CR>"),
      dashboard.button("q", "󰚑 " .. "Quit", ":qa<CR>"),
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
