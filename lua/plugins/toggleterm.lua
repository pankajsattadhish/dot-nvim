return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Dynamic size based on direction
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4 -- Uses 40% of the screen width
        end
      end,
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "vertical", -- Default direction
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
      },
    })

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- ESC to go to Normal Mode in terminal
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      -- Window navigation from inside terminal
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
  -- Custom Key Definitions
  keys = {
    {
      "<C-5>",
      "<cmd>ToggleTerm direction=vertical<cr>",
      desc = "Toggle Vertical Terminal",
      mode = { "n", "t" } -- Works in Normal and Terminal mode
    },
    -- Fallback: Some terminals send C-_ instead of C-/
    {
      "<C-_>",
      "<cmd>ToggleTerm direction=vertical<cr>",
      desc = "Toggle Vertical Terminal",
      mode = { "n", "t" }
    },
    {
      "<C-'>", -- This is Ctrl + Shift + /
      "<cmd>ToggleTerm direction=horizontal<cr>",
      desc = "Toggle Horizontal Terminal",
      mode = { "n", "t" }
    },
  }
}
