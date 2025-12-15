# Neovim Keymaps

## Core Keymaps (from `init.lua` and `lua/config/keymaps.lua`)

*   `v`, `J`: `:m ' M>+1<CR>gv=gv` - Move selected lines down in visual mode.
*   `v`, `K`: `:m ' M<-2<CR>gv=gv` - Move selected lines up in visual mode.
*   `n`, `k`: `v:count == 0 ? 'gk' : 'k'` - Adjusts `k` to work with `wrap` option, keeping cursor centered.
*   `n`, `j`: `v:count == 0 ? 'gj' : 'j'` - Adjusts `j` to work with `wrap` option, keeping cursor centered.
*   `v`, `<`: `<gv` - Indent left in visual mode.
*   `v`, `>`: `>gv` - Indent right in visual mode.
*   `v`, `p`: `"_dp` - Paste selection over current selection without yanking.
*   `v`, `P`: `"_dP` - Paste selection before current selection without yanking.
*   `n`, `YY`: `va{Vy` - Yank a block of text including surrounding curly braces `{}`.
*   `i`, `jj`: `<ESC>` - Exit insert mode by typing `jj`.
*   `i`, `jk`: `<ESC>` - Exit insert mode by typing `jk`.
*   `n`, `H`: `^` - Move cursor to the beginning of the line.
*   `x`, `H`: `^` - Move cursor to the beginning of the line in visual mode.
*   `o`, `H`: `^` - Move cursor to the beginning of the line in operator pending mode.
*   `n`, `L`: `g_` - Move cursor to the end of the line.
*   `x`, `L`: `g_` - Move cursor to the end of the line in visual mode.
*   `o`, `L`: `g_` - Move cursor to the end of the line in operator pending mode.
*   `n`, `<Right>`: `:bnext<CR>` - Go to the next buffer.
*   `n`, `<Left>`: `:bprevious<CR>` - Go to the previous buffer.
*   `n`, `+`: `:vertical resize +5<CR>` - Increase vertical window size.
*   `n`, `_`: `:vertical resize -5<CR>` - Decrease vertical window size.
*   `n`, `=`: `:resize +5<CR>` - Increase horizontal window size.
*   `n`, `-`: `:resize -5<CR>` - Decrease horizontal window size.
*   `n`, `n`: `nzzzv` - Move cursor to the center of the screen after search.
*   `n`, `N`: `Nzzzv` - Move cursor to the center of the screen after reverse search.
*   `n`, `*`: `*zzzv` - Search for the word under the cursor, keeping it centered.
*   `n`, `#`: `#zzzv` - Reverse search for the word under the cursor, keeping it centered.
*   `n`, `g*`: `g*zz` - Search for the word under the cursor, keeping it centered (like `*`).
*   `n`, `g#`: `g#zz` - Reverse search for the word under the cursor, keeping it centered (like `#`).
*   `n`, `<C-s>`: `:Telescope current_buffer_fuzzy_find<CR>` - Fuzzy find within the current buffer using Telescope.
*   `n`, `X`: `:keeppatterns substitute/\s*\s*/\r/e <bar> normal! ==^<cr>` - Removes extra whitespace.
*   `n`, `<C-x>`: `dd` - Delete the current line.
*   `n`, `<C-a>`: `ggVG` - Select all text in the buffer.
*   `n`, `<C-n>`: `:w %:h/` - Write the current file to a new file in the same directory.
*   `n`, `<C-P>`: `:lua require("config.utils").toggle_go_test()<CR>` - Toggle between Go test file and its corresponding main file.
*   `v`, `<leader>ln`: `:lua require("config.utils").get_highlighted_line_numbers()<CR>` - Get and copy line numbers of the visual selection.
*   `n`, `<Esc>`: `:nohlsearch<CR>` - Turn off search highlighting.
*   `n`, `<C-h>`: `<C-w>h` - Go to the left window.
*   `n`, `<C-j>`: `<C-w>j` - Go to the lower window.
*   `n`, `<C-k>`: `<C-w>k` - Go to the upper window.
*   `n`, `<C-l>`: `<C-w>l` - Go to the right window.

## Which-key Plugin Keymaps (`lua/plugins/which-key.lua`)

*   `n`, `v`, `?`: `require("which-key").show({ global = false })` - Show local keymaps for the current mode.
*   Groups defined for leader key (`<leader>`):
    *   `<leader>f`: Find
    *   `<leader>G`: Git
    *   `<leader>g`: Gitsigns
    *   `<leader>h`: Harpoon
    *   `<leader>R`: Replace
    *   `<leader>l`: LSP
    *   `<leader>c`: LSP (Trouble)
    *   `<leader>t`: Test
    *   `<leader>D`: Debugger
    *   `<leader>s`: Search
    *   `<leader>x`: Diagnostics/Quickfix (Trouble)
    *   `<leader>u`: Toggle Features
    *   `<leader>W`: Workspace
    *   `[`: Previous
    *   `]`: Next
    *   `g`: goto

## Harpoon Plugin Keymaps (`lua/plugins/harpoon.lua`)

*   `n`, `<leader>ha`: `harpoon:list():add()` - Add the current file to the Harpoon list.
*   `n`, `<leader>hm`: `harpoon.ui:toggle_quick_menu(harpoon:list())` - Toggle the Harpoon quick menu.
*   `n`, `<C-e>`: `harpoon.ui:toggle_quick_menu(harpoon:list())` - Toggle the Harpoon quick menu (alternative).
*   `n`, `<M-n>`: `harpoon:list():prev()` - Go to the previous file in the Harpoon list.
*   `n`, `<M-p>`: `harpoon:list():next()` - Go to the next file in the Harpoon list.
*   `n`, `<leader>1`: `harpoon:list():select(1)` - Go to the 1st file in the Harpoon list.
*   `n`, `<leader>2`: `harpoon:list():select(2)` - Go to the 2nd file in the Harpoon list.
*   `n`, `<leader>3`: `harpoon:list():select(3)` - Go to the 3rd file in the Harpoon list.
*   `n`, `<leader>4`: `harpoon:list():select(4)` - Go to the 4th file in the Harpoon list.

## Nvim-Tree Plugin Keymaps (`lua/plugins/nvim-tree.lua`)

*   `n`, `<leader>e`: `<cmd>NvimTreeToggle<CR>` - Toggle the file explorer.
*   Window navigation keymaps (`<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`) are remapped within Nvim-tree to use global window navigation.

## ToggleTerm Plugin Keymaps (`lua/plugins/toggleterm.lua`)

*   `n`, `t`, `<C-5>`: `<cmd>ToggleTerm direction=vertical<cr>` - Toggle a vertical terminal.
*   `n`, `t`, `<C-_>`: `<cmd>ToggleTerm direction=vertical<cr>` - Toggle a vertical terminal (alternative for terminals that send `C-_` instead of `C-/`).
*   `n`, `t`, `<C-'`: `<cmd>ToggleTerm direction=horizontal<cr>` - Toggle a horizontal terminal.

## Snacks Plugin Keymaps (`lua/plugins/snacks.lua`)

*   `n`, `<leader><space>`: `Snacks.picker.smart()` - Find files smartly.
*   `n`, `<leader>/`: `Snacks.picker.grep()` - Grep for text.
*   `n`, `<leader>:`: `Snacks.picker.command_history()` - Access command history.
*   `n`, `<leader>sn`: `Snacks.picker.notifications()` - Search notifications.
*   `n`, `<leader>e`: `Snacks.explorer()` - Open the file explorer.
*   `n`, `<leader>o`: `Snacks.picker.buffers(...)` - Find buffers.
*   `n`, `<leader>fc`: `Snacks.picker.files({ cwd = vim.fn.stdpath("config") })` - Find config files.
*   `n`, `<leader>ff`: `Snacks.picker.files()` - Find files.
*   `n`, `<leader>fg`: `Snacks.picker.git_files()` - Find git files.
*   `n`, `<leader>fp`: `Snacks.picker.projects()` - Find projects.
*   `n`, `<leader>fr`: `Snacks.picker.recent()` - Find recent files.
*   `n`, `<leader>gb`: `Snacks.picker.git_branches()` - Git branches.
*   `n`, `<leader>gl`: `Snacks.picker.git_log()` - Git log.
*   `n`, `<leader>gL`: `Snacks.picker.git_log_line()` - Git log line.
*   `n`, `<leader>gs`: `Snacks.picker.git_status()` - Git status.
*   `n`, `<leader>gS`: `Snacks.picker.git_stash()` - Git stash.
*   `n`, `<leader>gd`: `Snacks.picker.git_diff()` - Git diff (hunks).
*   `n`, `<leader>gf`: `Snacks.picker.git_log_file()` - Git log for the current file.
*   `n`, `<leader>sb`: `Snacks.picker.lines()` - Lines in the buffer.
*   `n`, `<C-s>`: `Snacks.picker.grep_buffers()` - Grep open buffers.
*   `n`, `<leader>st`: `Snacks.picker.grep()` - Grep.
*   `n`, `x`, `<leader>sw`: `Snacks.picker.grep_word()` - Grep visual selection or word.
*   `n`, `<leader>s"`: `Snacks.picker.registers()` - Registers.
*   `n`, `<leader>s/`: `Snacks.picker.search_history()` - Search history.
*   `n`, `<leader>sa`: `Snacks.picker.autocmds()` - Autocmds.
*   `n`, `<leader>sc`: `Snacks.picker.command_history()` - Command history.
*   `n`, `<leader>sd`: `Snacks.picker.diagnostics()` - Diagnostics.
*   `n`, `<leader>sD`: `Snacks.picker.diagnostics_buffer()` - Buffer diagnostics.
*   `n`, `<leader>sh`: `Snacks.picker.help()` - Help pages.
*   `n`, `<leader>sH`: `Snacks.picker.highlights()` - Highlights.
*   `n`, `<leader>si`: `Snacks.picker.icons()` - Icons.
*   `n`, `<leader>sj`: `Snacks.picker.jumps()` - Jumps.
*   `n`, `<leader>sk`: `Snacks.picker.keymaps()` - Keymaps.
*   `n`, `<leader>sl`: `Snacks.picker.loclist()` - Location list.
*   `n`, `<leader>sm`: `Snacks.picker.marks()` - Marks.
*   `n`, `<leader>sM`: `Snacks.picker.man()` - Man pages.
*   `n`, `<leader>sp`: `Snacks.picker.lazy()` - Search for plugin spec.
*   `n`, `<leader>sq`: `Snacks.picker.qflist()` - Quickfix list.
*   `n`, `<leader>sR`: `Snacks.picker.resume()` - Resume.
*   `n`, `<leader>su`: `Snacks.picker.undo()` - Undo history.
*   `n`, `<leader>uC`: `Snacks.picker.colorschemes()` - Colorschemes.
*   `n`, `gd`: `Snacks.picker.lsp_definitions()` - Go to definition (LSP).
*   `n`, `gD`: `Snacks.picker.lsp_declarations()` - Go to declaration (LSP).
*   `n`, `gr`: `Snacks.picker.lsp_references()` - Go to references (LSP).
*   `n`, `gI`: `Snacks.picker.lsp_implementations()` - Go to implementation (LSP).
*   `n`, `gy`: `Snacks.picker.lsp_type_definitions()` - Go to type definition (LSP).
*   `n`, `<leader>p`: `Snacks.picker.lsp_symbols()` - LSP symbols.
*   `n`, `<leader>WS`: `Snacks.picker.lsp_workspace_symbols()` - LSP workspace symbols.
*   `n`, `<leader>z`: `Snacks.zen()` - Toggle Zen mode.
*   `n`, `<leader>Z`: `Snacks.zen.zoom()` - Toggle zoom in Zen mode.
*   `n`, `<leader>.`: `Snacks.scratch()` - Toggle scratch buffer.
*   `n`, `<leader>S`: `Snacks.scratch.select()` - Select scratch buffer.
*   `n`, `<leader>n`: `Snacks.notifier.show_history()` - Notification history.
*   `n`, `Q`: `Snacks.bufdelete()` - Delete buffer.
*   `n`, `<leader>cR`: `Snacks.rename.rename_file()` - Rename file.
*   `n`, `<leader>gB`: `Snacks.gitbrowse()` - Git browse.
*   `n`, `<leader>gg`: `Snacks.lazygit()` - Open Lazygit.
*   `n`, `<leader>un`: `Snacks.notifier.hide()` - Dismiss all notifications.
*   `]]`: `Snacks.words.jump(vim.v.count1)` - Jump to next reference.
*   `[[`: `Snacks.words.jump(-vim.v.count1)` - Jump to previous reference.
*   `n`, `<leader>N`: `Snacks.win(...)` - Open Neovim news.

## Spectre Plugin Keymaps (`lua/plugins/extra.lua`)

*   `n`, `v`, `<leader>Rr`: `require("spectre").open()` - Open Spectre for find and replace.
*   `n`, `<leader>Rw`: `require("spectre").open_visual({ select_word = true })` - Open Spectre for word search and replace.
*   `n`, `<leader>Rf`: `require("spectre").open_file_search()` - Open Spectre for file search and replace.

## Flash Plugin Keymaps (`lua/plugins/extra.lua`)

*   `n`, `x`, `o`, `s`: `require("flash").jump()` - Jump to a highlighted location.
*   `n`, `x`, `o`, `S`: `require("flash").treesitter()` - Jump using Treesitter.
*   `o`, `r`: `require("flash").remote()` - Remote jump.
*   `o`, `x`, `R`: `require("flash").treesitter_search()` - Treesitter search.
*   `c`, `<c-s>`: `require("flash").toggle()` - Toggle Flash search.

## Showkeys Plugin Keymaps (`lua/plugins/extra.lua`)

*   `n`, `<leader>ut`: `vim.cmd("ShowkeysToggle")` - Toggle the display of key presses.

## LSP Keymaps (from `lua/core/lsp.lua`)

While not direct keymaps, the LSP configuration sets up many features that are bound to keymaps within the `setup_keymaps` function in `lua/core/lsp.lua`. These include mappings for:
*   Go to Definition, Declaration, Implementation, Type Definition
*   Hover documentation
*   Signature help
*   Code actions
*   Renaming
*   Formatting
*   Diagnostics navigation and display
*   Workspace folder management

These are detailed in the "LSP Keymaps" section above.

## Gitsigns Plugin Keymaps (`lua/plugins/git.lua`)

*   `n`, `]]`: `require("gitsigns").next_hunk()` - Go to the next git hunk.
*   `n`, `[[`: `require("gitsigns").prev_hunk()` - Go to the previous git hunk.
*   `n`, `<leader>H`: `require("gitsigns").preview_hunk()` - Preview git hunk.
*   `n`, `<leader>Gk`: `require("gitsigns").prev_hunk({ navigation_message = false })` - Go to previous hunk without message.
*   `n`, `<leader>Gl`: `require("gitsigns").blame_line()` - Show blame for the current line.
*   `n`, `<leader>Gp`: `require("gitsigns").preview_hunk()` - Preview hunk.
*   `n`, `<leader>Gr`: `require("gitsigns").reset_hunk()` - Reset current hunk.
*   `n`, `<leader>GR`: `require("gitsigns").reset_buffer()` - Reset current buffer.
*   `n`, `<leader>Gj`: `require("gitsigns").next_hunk({ navigation_message = false })` - Go to next hunk without message.
*   `n`, `<leader>Gs`: `require("gitsigns").stage_hunk()` - Stage current hunk.
*   `n`, `<leader>Gu`: `require("gitsigns").undo_stage_hunk()` - Undo stage hunk.
*   `n`, `<leader>Gd`: `vim.cmd("Gitsigns diffthis HEAD")` - Show diff for the current file against HEAD.

## Conform Plugin Keymaps (`lua/plugins/conform.lua`)

*   `n`, `v`, `<leader>cf`: `require("conform").format(...)` - Format the buffer.

## Undotree Plugin Keymaps (`lua/plugins/git.lua`)

*   `n`, `<leader>GU`: `:UndotreeToggle<CR>` - Toggle the undo tree.

## Autocmds (`lua/config/autocmds.lua`)

*   `FileType` (for specific filetypes like `mail`, `man`, `help`, `qf`, etc.): Sets options or maps `q` to close the buffer.
*   `CursorHold`, `CursorHoldI`, `CursorMoved`, `CursorMovedI`: Manages cursor line highlighting and LSP document highlighting.
*   `TextYankPost`: Highlights yanked text.
*   `BufReadPost`: Restores cursor position when opening a file.
*   `BufEnter`: Sets `formatoptions` to disable auto-commenting on new lines.
*   `FocusGained`, `BufEnter`: Triggers `checktime` to reload changed files.
*   `LspAttach`: Sets up LSP-specific keymaps and features for newly attached buffers.
*   `FileType` (for `man`): Maps `q` to `:quit`.
*   `FileType` (for `*.txt`, `*.md`, `*.tex`): Enables spell checking.
*   `FileType` (for various diagnostic/info buffers): Maps `q` to close the buffer.
*   `VimResized`: Resizes Neovim splits when the terminal is resized.
*   `FileType` (for `terraform`, `hcl`): Fixes comment string.## LSP Capabilities Configuration (from `lua/core/lsp.lua`)

While not direct keymaps, the LSP configuration sets up many features that are bound to keymaps within the `setup_keymaps` function in `lua/core/lsp.lua`. These include mappings for:
*   Go to Definition, Declaration, Implementation, Type Definition
*   Hover documentation
*   Signature help
*   Code actions
*   Renaming
*   Formatting
*   Diagnostics navigation and display
*   Workspace folder management

These are detailed in the "LSP Keymaps" section above.
