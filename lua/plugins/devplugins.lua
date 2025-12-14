return {
  {
    dir = "~/Developer/opensource/simplemarkdown.nvim",
    enabled = false,
    ft = 'markdown',
    config = function()
      require('simplemarkdown').setup()
    end
  },
  -- {
  --   dir = "~/Developer/opensource/forest-night.nvim",
  --   config = function()
  --     -- vim.cmd('colorscheme forest-night')
  --   end
  -- }
}

