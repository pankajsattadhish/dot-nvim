local M = {}
local bufh = nil
local winh = nil

local function get_window_config()
	local width = vim.opt.columns:get()
	local height = vim.opt.lines:get()
	local win_width = math.floor(width * 0.8)
	local win_height = math.floor(height * 0.7)
	local row = math.floor((height - win_height) / 2) - 1
	local col = math.floor((width - win_width) / 2)
	return {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}
end

local function apply_window_options(win)
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].cursorline = false
	vim.wo[win].scrolloff = 999
	vim.wo[win].sidescrolloff = 999
end

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

function M.toggle()
	if winh and vim.api.nvim_win_is_valid(winh) then
		vim.api.nvim_win_hide(winh)
		return
	end

	if bufh and vim.api.nvim_buf_is_valid(bufh) then
		M.create_window()
		return
	end

	M.create_terminal()
end

function M.create_terminal()
	bufh = vim.api.nvim_create_buf(false, true)
	vim.bo[bufh].bufhidden = "hide"
	vim.bo[bufh].filetype = "terminal"

	winh = vim.api.nvim_open_win(bufh, true, get_window_config())
	apply_window_options(winh)

	vim.api.nvim_buf_call(bufh, function()
		vim.cmd("terminal")
	end)

	vim.cmd("startinsert")
end

function M.create_window()
	if not bufh or not vim.api.nvim_buf_is_valid(bufh) then
		M.create_terminal()
		return
	end

	winh = vim.api.nvim_open_win(bufh, true, get_window_config())
	apply_window_options(winh)

	vim.cmd("startinsert")
end

function M.open()
	if winh and vim.api.nvim_win_is_valid(winh) then
		vim.api.nvim_set_current_win(winh)
		return
	end
	if bufh and vim.api.nvim_buf_is_valid(bufh) then
		M.create_window()
		return
	end
	M.toggle()
end

function M.close()
	if winh and vim.api.nvim_win_is_valid(winh) then
		vim.api.nvim_win_hide(winh)
	end
end

map({ "n", "t" }, "<C-/>", M.toggle, "Toggle Terminal")
map({ "n", "t" }, "<C-_>", M.toggle, "Toggle Terminal")

return M
