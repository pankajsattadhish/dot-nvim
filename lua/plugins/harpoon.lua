return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  opts = {
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  },

  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Add File",
    },
    {
      "<C-e>",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon Menu",
    },
    {
      "<leader>hf",
      function()
        require("harpoon.ui").nav_next()
      end,
      desc = "Next Mark",
    },
    {
      "<leader>hd",
      function()
        require("harpoon.ui").nav_prev()
      end,
      desc = "Previous Mark",
    },
    {
      "<leader>h1",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Mark 1",
    },
    {
      "<leader>h2",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Mark 2",
    },
    {
      "<leader>h3",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Mark 3",
    },
    {
      "<leader>h4",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Mark 4",
    },
  },
}
