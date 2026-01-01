return {
  "windwp/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>sS",
      function()
        require("spectre").open()
      end,
      desc = "Search & Replace",
    },
    {
      "<leader>sW",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Replace Word",
    },
    {
      "<leader>sF",
      function()
        require("spectre").open_file_search()
      end,
      desc = "Replace in File",
    },
  },
}
