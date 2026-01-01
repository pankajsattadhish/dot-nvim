return {
  "adibhanna/nvim-newfile.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("nvim-newfile").setup({
      notifications = {
        enabled = false,
      },
    })
  end,
}
