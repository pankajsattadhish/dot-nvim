return {
  "nvim-treesitter/nvim-treesitter",
  -- FORCE the stable branch to fix the "module not found" error
  branch = "master",
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    -- Also force the textobjects plugin to stay on its compatible branch
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
  },
  config = function()
    -- Use the old module name that 'master' branch expects
    require("nvim-treesitter.configs").setup({
      modules = {},
      ignore_install = {},
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vue",
        "vim",
        "vimdoc",
        "yaml",
        "rust",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "terraform",
        "proto",
        "zig",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
        },
      },
    })
  end,
}
