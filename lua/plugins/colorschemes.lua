return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        theme = "dragon", -- The dark, minimal flavor
        background = { dark = "dragon" },
        undercurl = true,
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none", -- Remove gutter background
              },
            },
          },
        },
        -- THIS SECTION FIXES THE POPUPS
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- 1. FIX BLINK (Autocomplete Popup)
            -- Force the menu to match the theme's popup background
            BlinkCmpMenu = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            BlinkCmpMenuBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            BlinkCmpDoc = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            BlinkCmpDocBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            -- The selected item in the list
            BlinkCmpMenuSelection = { fg = "NONE", bg = theme.ui.bg_p2, bold = true },
            BlinkCmpLabelMatch = { fg = theme.syn.special1, bold = true }, -- Matched characters

            -- 2. FIX SNACKS (Search / Picker Window)
            SnacksPickerNormal = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            SnacksPickerBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            SnacksPickerTitle = { fg = theme.ui.special, bg = theme.ui.bg_m1, bold = true },
            SnacksPickerInput = { fg = theme.ui.fg, bg = theme.ui.bg_p1 }, -- Slightly darker input box
            SnacksPickerList = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            
            -- 3. FIX WHICH-KEY (The key helper popup)
            WhichKeyFloat = { bg = theme.ui.bg_m1 },
            WhichKeyBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },

            -- 4. GENERAL FLOATING WINDOWS (Fallback)
            NormalFloat = { bg = theme.ui.bg_m1 },
            FloatBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },

            -- 5. Scope Line (Your previous request: Off-white)
            SnacksIndentScope = { fg = "#DCD7BA" },
          }
        end,
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
