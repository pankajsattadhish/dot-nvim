return {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        require("kanagawa").setup({ style = "dark" })
        vim.cmd([[colorscheme kanagawa]])
      end,
      set_light_mode = function()
        require("kanagawa").setup({ style = "light" })
        vim.cmd([[colorscheme kanagawa]])
      end,
    },
  },

  -- Yukinord (default)
  {
    "adibhanna/yukinord.nvim",
    -- dir = "~/Developer/opensource/yukinord/neovim",
    config = function()
      require("yukinord").setup({
        transparent = true,
        transparent_sidebar = true,
      })
      -- vim.cmd("colorscheme yukinord")
    end,
  },

  -- Gruvbox Material
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      -- vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_float_style = "bright"
      vim.g.gruvbox_material_statusline_style = "mix"
      vim.g.gruvbox_material_cursor = "auto"
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000, -- Load this before everything else
    lazy = false, -- We want the theme to load immediately
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
        -- THIS SECTION FIXES THE POPUPS (Your custom overrides)
        overrides = function(colors)
          local theme = colors.theme
          return {
            -- 1. FIX BLINK (Autocomplete Popup)
            BlinkCmpMenu = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            BlinkCmpMenuBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            BlinkCmpDoc = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            BlinkCmpDocBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            BlinkCmpMenuSelection = { fg = "NONE", bg = theme.ui.bg_p2, bold = true },
            BlinkCmpLabelMatch = { fg = theme.syn.special1, bold = true },

            -- 2. FIX SNACKS (Search / Picker Window)
            SnacksPickerNormal = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            SnacksPickerBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },
            SnacksPickerTitle = { fg = theme.ui.special, bg = theme.ui.bg_m1, bold = true },
            SnacksPickerInput = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
            SnacksPickerList = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },

            -- 3. FIX WHICH-KEY
            WhichKeyFloat = { bg = theme.ui.bg_m1 },
            WhichKeyBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },

            -- 4. GENERAL FLOATING WINDOWS
            NormalFloat = { bg = theme.ui.bg_m1 },
            FloatBorder = { fg = theme.ui.fg_border, bg = theme.ui.bg_m1 },

            -- 5. Scope Line
            SnacksIndentScope = { fg = "#DCD7BA" },
          }
        end,
      })

      -- Force the colorscheme to load
      vim.cmd("colorscheme kanagawa")
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
