return {
  -- Kanagawa: Japanese-inspired colorscheme with multiple themes.
  -- Dragon theme: dark, minimal, great for coding.
  -- Includes custom overrides to fix popup colors for plugins.
  {
    "rebelot/kanagawa.nvim",
    priority = 1000, -- Load before other plugins.
    lazy = false, -- Load immediately, don't lazy-load.
    config = function()
      require("kanagawa").setup({
        theme = "dragon", -- Use the "dragon" theme (dark, minimal).
        background = { dark = "dragon" }, -- Background style for dark mode.
        undercurl = true, -- Enable undercurl for spelling errors, etc.
        commentStyle = { italic = true }, -- Make comments italic.
        keywordStyle = { italic = true }, -- Make keywords italic.
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none", -- Remove background from line number gutter.
              },
            },
          },
        },
        -- Custom color overrides to fix plugin popups and UI elements.
        -- These ensure plugins like Blink, Snacks, WhichKey look good with Kanagawa.
        overrides = function(colors)
          local theme = colors.theme -- Access the theme's color palette.
          return {
            -- 1. Fix Blink (autocomplete popup) colors.
            BlinkCmpMenu = { fg = theme.ui.fg, bg = theme.ui.bg_m1 }, -- Menu text and bg.
            BlinkCmpMenuBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 }, -- Menu border.
            BlinkCmpDoc = { fg = theme.ui.fg, bg = theme.ui.bg_m1 }, -- Documentation popup.
            BlinkCmpDocBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 }, -- Doc border.
            BlinkCmpMenuSelection = { fg = "NONE", bg = theme.ui.bg_p2, bold = true }, -- Selected item.
            BlinkCmpLabelMatch = { fg = theme.syn.special1, bold = true }, -- Matching text.

            -- 2. Fix Snacks (search/picker window) colors.
            SnacksPickerNormal = { fg = theme.ui.fg, bg = theme.ui.bg_m1 }, -- Normal text.
            SnacksPickerBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 }, -- Border.
            SnacksPickerTitle = { fg = theme.ui.special, bg = theme.ui.bg_m1, bold = true }, -- Title.
            SnacksPickerInput = { fg = theme.ui.fg, bg = theme.ui.bg_p1 }, -- Input field.
            SnacksPickerList = { fg = theme.ui.fg, bg = theme.ui.bg_m1 }, -- List items.

            -- 3. Fix WhichKey (key hint popup) colors.
            WhichKeyFloat = { bg = theme.ui.bg_m1 }, -- Floating window bg.
            WhichKeyBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 }, -- Border.

            -- 4. General floating windows (like LSP hover).
            NormalFloat = { bg = theme.ui.bg_m1 }, -- Normal float bg.
            FloatBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 }, -- Float border.

            -- 5. Indentation scope line color.
            SnacksIndentScope = { fg = "#DCD7BA" }, -- Color for indent guides.
          }
        end,
      })

      -- Apply the colorscheme immediately.
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
