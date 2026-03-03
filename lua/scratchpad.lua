local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

local scratchpad_buf = nil
local scratchpad_win = nil

local function get_scratchpad_path()
	local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	local base = vim.fn.stdpath("data") .. "/scratchpad"
	if vim.fn.isdirectory(base) == 0 then
		vim.fn.mkdir(base, "p")
	end
	return base .. "/" .. project .. ".md"
end

local function get_window_config(win_width, win_height)
	local width = vim.o.columns
	local height = vim.o.lines
	local row = math.floor((height - win_height) / 2) - 1
	local col = math.floor((width - win_width) / 2)
	return {
		relative = "editor",
		row = row,
		col = col,
		width = win_width,
		height = win_height,
		style = "minimal",
		border = "rounded",
	}
end

local function toggle_scratchpad()
	if scratchpad_win and vim.api.nvim_win_is_valid(scratchpad_win) then
		vim.api.nvim_set_current_win(scratchpad_win)
		vim.cmd("write")
		vim.api.nvim_win_close(scratchpad_win, true)
		scratchpad_win = nil
		return
	end

	local path = get_scratchpad_path()
	local is_new = vim.fn.filereadable(path) == 0

	local win_width = math.floor(vim.o.columns * 0.8)
	local win_height = math.floor(vim.o.lines * 0.8)

	scratchpad_buf = vim.fn.bufnr(path)
	if scratchpad_buf == -1 then
		scratchpad_buf = vim.fn.bufadd(path)
		vim.bo[scratchpad_buf].buflisted = false
	end
	vim.fn.bufload(scratchpad_buf)

	scratchpad_win = vim.api.nvim_open_win(scratchpad_buf, true, get_window_config(win_width, win_height))

	if is_new then
		local title = string.rep("-", math.floor((win_width - 11) / 2))
			.. " Scratchpad "
			.. string.rep("-", math.floor((win_width - 11) / 2))
		vim.api.nvim_buf_set_lines(scratchpad_buf, 0, 0, false, { title, "" })
		vim.cmd("write")
	end

	vim.bo[scratchpad_buf].filetype = "markdown"
	vim.bo[scratchpad_buf].modified = false

	vim.cmd([[highlight ScratchpadTitle guifg=#89b4fa gui=bold]])
	vim.cmd([[match ScratchpadTitle /^.\{-}\zsScratchpad/]])
end

map({ "n", "t" }, "<C-Space>", toggle_scratchpad, "Toggle Scratchpad")

return { ToggleScratchpad = toggle_scratchpad }
