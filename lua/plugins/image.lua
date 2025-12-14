return {
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "folke/snacks.nvim",
        opts = {
          bigfile = { enabled = true },
        }
      } 
    },
    opts = {
      backend = "kitty",
      
      -- This section controls images appearing INSIDE text files
      integrations = {
        markdown = {
          enabled = false, -- Set to false to stop images in .md files
        },
        neorg = {
          enabled = false,
        },
        html = {
          enabled = false, -- Set to false to stop images in .html files
        },
        css = {
          enabled = false,
        },
      },
      
      max_width = 100,
      max_height = 12,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge,
      window_overlap_clear_enabled = false,
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = true,
      
      -- This keeps the feature where opening a .png file directly SHOWS the image
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },
}
