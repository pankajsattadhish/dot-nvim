return {
  -- Replaces nvim-cmp with better performance and features.
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets", -- Collection of snippets for many languages.
    },
    version = "*", -- Use latest version.
    config = function()
      require("blink.cmp").setup({
        -- Use LuaSnip for expanding snippets.
        snippets = { preset = "luasnip" },
        -- Show function signatures as you type parameters.
        signature = { enabled = true },
        appearance = {
          -- Don't mimic nvim-cmp's appearance.
          use_nvim_cmp_as_default = false,
          -- Use normal nerd font icons (not mono).
          nerd_font_variant = "normal",
        },
        -- Completion sources: where suggestions come from.
        sources = {
          -- Default sources to use for completion.
          default = { "lsp", "path", "buffer", "snippets" },
          providers = {
            -- LazyDev: completions for Neovim Lua development.
            lazydev = {
              name = "LazyDev", -- Display name.
              module = "lazydev.integrations.blink", -- Integration module.
              score_offset = 100, -- Boost priority (higher = more important).
            },
            -- Command line completions (when typing :commands).
            cmdline = {
              min_keyword_length = 2, -- Need at least 2 chars to trigger.
            },
          },
        },
        -- Keybindings for completion menu navigation.
        keymap = {
          ["<C-space>"] = { "show", "hide", "show_documentation", "hide_documentation" }, -- Toggle completion/docs.
          ["<CR>"] = { "accept", "fallback" }, -- Accept completion or normal enter.
          ["<Tab>"] = { "select_next", "fallback" }, -- Next item or normal tab.
          ["<S-Tab>"] = { "select_prev", "fallback" }, -- Previous item or normal shift-tab.
          ["<C-k>"] = { "select_prev", "fallback" }, -- Previous item (vim-like).
          ["<C-j>"] = { "select_next", "fallback" }, -- Next item (vim-like).
          ["<C-f>"] = { "scroll_documentation_up", "fallback" }, -- Scroll docs up.
          ["<C-b>"] = { "scroll_documentation_down", "fallback" }, -- Scroll docs down.
        },
        -- Command line completion (when typing :commands).
        cmdline = {
          enabled = true, -- Enable cmdline completion.
          completion = { menu = { auto_show = true } }, -- Show menu automatically.
          keymap = {
            -- ["<CR>"] = { "accept", "fallback" }, -- Accept or normal enter.
            -- ["<Tab>"] = { "select_next", "fallback" }, -- Next item or normal tab.
          },
        },
        -- Completion menu appearance and behavior.
        completion = {
          menu = {
            border = "rounded", -- Rounded corners for menu.
            scrolloff = 1, -- Keep 1 line visible above/below selection.
            scrollbar = false, -- Hide scrollbar.
            draw = {
              padding = 1, -- Space around items.
              gap = 1, -- Gap between columns.
              columns = {
                { "kind_icon" }, -- Icon showing type (function, variable, etc.).
                { "label", "label_description", gap = 1 }, -- Main text and description.
                { "kind" }, -- Type name (Function, Variable).
                { "source_name" }, -- Where it comes from (LSP, buffer, etc.).
              },
            },
          },
          -- Documentation popup for selected completion.
          documentation = {
            window = {
              border = "rounded", -- Rounded border.
              scrollbar = false, -- No scrollbar.
              winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc", -- Highlight groups.
            },
            auto_show = true, -- Show docs automatically.
            auto_show_delay_ms = 500, -- Wait 500ms before showing.
          },
        },
      })

      -- Load snippets from VSCode format (friendly-snippets).
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  -- LazyDev: Provides completions for Neovim Lua API.
  -- Helps when writing Neovim plugins or config.
  {
    "folke/lazydev.nvim",
    ft = "lua", -- Only load for Lua files.
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- Include luv library.
      },
    },
  },
  -- LuaSnip: Snippet engine that expands code snippets.
  -- Required for blink.cmp snippets to work.
  { "L3MON4D3/LuaSnip", keys = {} }, -- No default keys, blink.cmp handles them.
}
