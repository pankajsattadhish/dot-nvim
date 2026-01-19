return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("kanagawa").setup({
        theme = "dragon",
        background = { dark = "dragon" },
        undercurl = true,
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        colors = {
          theme = {
            all = {
              ui = { bg_gutter = "none" },
            },
          },
        },

        overrides = function(colors)
          local theme = colors.theme

          return {
            -- === Blink Completion ===
            BlinkCmpMenu = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            BlinkCmpMenuBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            BlinkCmpDoc = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            BlinkCmpDocBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            BlinkCmpMenuSelection = { bg = theme.ui.bg_p2, bold = true },
            BlinkCmpLabelMatch = { fg = theme.syn.special1, bold = true },

            -- === Snacks Picker ===
            SnacksPickerNormal = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            SnacksPickerBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            SnacksPickerTitle = { fg = theme.ui.special, bg = theme.ui.bg_m1, bold = true },
            SnacksPickerInput = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
            SnacksPickerList = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            SnacksPickerBackdrop = { bg = theme.ui.bg_dim },

            -- === WhichKey ===
            WhichKeyFloat = { bg = theme.ui.bg_m1 },
            WhichKeyBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            WhichKey = { fg = theme.ui.fg },
            WhichKeyGroup = { fg = theme.syn.fun },
            WhichKeyDesc = { fg = theme.syn.string },

            -- === Floats ===
            NormalFloat = { bg = theme.ui.bg_m1 },
            FloatBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },

            -- === Popup Menu (Fallback) ===
            Pmenu = { bg = theme.ui.bg_p1 },
            PmenuSel = { bg = theme.ui.bg_p2, bold = true },

            -- === Indent Guides ===
            SnacksIndentScope = { fg = theme.ui.whitespace },
          }
        end,
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },
}
