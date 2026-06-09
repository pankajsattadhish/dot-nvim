local M = {}

local state = {
	buf = nil,
	win = nil,
}

local function create_terminal()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("buflisted", false, { buf = buf })
	vim.api.nvim_buf_call(buf, function()
		vim.fn.termopen({ vim.o.shell })
	end)
	return buf
end

local function open_window(buf)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.6)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	})
	vim.cmd("startinsert")
	return win
end

function M.toggle()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
		state.win = nil
		return
	end

	if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		state.win = open_window(state.buf)
	else
		state.buf = create_terminal()
		state.win = open_window(state.buf)
	end
end

vim.keymap.set({ "n", "t" }, "<C-\\>", M.toggle, { desc = "Toggle floating terminal" })

return M
