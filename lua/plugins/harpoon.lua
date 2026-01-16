return {
  "ThePrimeagen/harpoon",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
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
      "<C-h>",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Mark 1",
    },
    {
      "<C-i>",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Mark 2",
    },
    {
      "<C-p>",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Mark 3",
    },
    {
      "<C-n>",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Mark 4",
    },
  }}
