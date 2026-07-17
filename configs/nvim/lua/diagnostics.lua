-- WARNING: slop
local M = {}

local NS = vim.api.nvim_create_namespace("virtual_diagnostic_cycle")
local AUGROUP = vim.api.nvim_create_augroup("VirtualDiagnosticCycle", { clear = true })

-- Reference to Neovim's own virtual_lines handler, captured the first
-- time setup() runs (before we replace vim.diagnostic.handlers.virtual_lines),
-- so render() below can still delegate the actual drawing to it.
local native_handler

-- state[bufnr][lnum] = 0-based index into that line's sorted diagnostic list
local state = {}

local function get_index(bufnr, lnum)
	local buf_state = state[bufnr]
	return buf_state and buf_state[lnum] or 0
end

local function set_index(bufnr, lnum, idx)
	state[bufnr] = state[bufnr] or {}
	state[bufnr][lnum] = idx
end

-- Group a flat diagnostic list into { [lnum] = { diag, diag, ... } }, each
-- inner list sorted so the most severe diagnostic is first.
local function group_by_line(diagnostics)
	local by_line = {}
	for _, d in ipairs(diagnostics) do
		by_line[d.lnum] = by_line[d.lnum] or {}
		table.insert(by_line[d.lnum], d)
	end
	for _, list in pairs(by_line) do
		table.sort(list, function(a, b)
			if a.severity ~= b.severity then
				return a.severity < b.severity -- ERROR (1) sorts before WARN (2), etc.
			end
			return a.col < b.col
		end)
	end
	return by_line
end

--- Recompute the buffer's diagnostics, keep only the currently-selected
--- one for each line, and hand that filtered list to Neovim's own
--- virtual_lines handler so it does the actual drawing.
local function render(bufnr, opts)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if not vim.api.nvim_buf_is_valid(bufnr) or not native_handler then
		return
	end

	local by_line = group_by_line(vim.diagnostic.get(bufnr))
	local filtered = {}

	for lnum, list in pairs(by_line) do
		local idx = get_index(bufnr, lnum)
		if idx >= #list then
			idx = 0
			set_index(bufnr, lnum, 0)
		end

		local d = list[idx + 1]
		if #list > 1 then
			-- Copy before mutating so we never touch vim.diagnostic's own cache.
			d = vim.tbl_extend("force", {}, d)
			d.message = string.format("%s [%d/%d]", d.message, idx + 1, #list)
		end
		table.insert(filtered, d)
	end

	pcall(native_handler.show, NS, bufnr, filtered, opts)
end

--- Move the diagnostic shown on the cursor's line forward/back by
--- `direction` (1 or -1), wrapping around, then redraw.
function M.cycle(direction)
	local bufnr = vim.api.nvim_get_current_buf()
	local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

	local line_diagnostics = {}
	for _, d in ipairs(vim.diagnostic.get(bufnr)) do
		if d.lnum == lnum then
			table.insert(line_diagnostics, d)
		end
	end

	if #line_diagnostics == 0 then
		vim.notify("No diagnostics on this line", vim.log.levels.INFO)
		return
	elseif #line_diagnostics <= 1 then
		return
	end

	local idx = get_index(bufnr, lnum)
	idx = (idx + direction) % #line_diagnostics
	set_index(bufnr, lnum, idx)

	-- Ask the framework to redisplay this buffer. That dispatches straight
	-- back through our handler override below with freshly resolved opts,
	-- which is what actually redraws with the new selection.
	vim.diagnostic.show(nil, bufnr)
end

function M.next()
	M.cycle(1)
end

function M.prev()
	M.cycle(-1)
end

--- Replace vim.diagnostic.handlers.virtual_lines with our filtering
--- wrapper. Safe to call more than once: `native_handler` is only
--- captured the first time, so a second setup() call can't accidentally
--- wrap our own wrapper and recurse into itself.
local function install_handler()
	native_handler = native_handler or vim.diagnostic.handlers.virtual_lines

	vim.diagnostic.handlers.virtual_lines = {
		show = function(_, bufnr, _, opts)
			render(bufnr, opts)
		end,
		-- Rather than blindly hiding everything (which would also hide any
		-- other still-active namespace's diagnostics on this buffer),
		-- recompute and redraw with whatever's left. If nothing's left,
		-- this naturally renders an empty set, which clears the display.
		hide = function(_, bufnr)
			render(bufnr, vim.diagnostic.config())
		end,
	}
end

local function setup_autocmds()
	vim.api.nvim_clear_autocmds({ group = AUGROUP })

	vim.api.nvim_create_autocmd("BufWipeout", {
		group = AUGROUP,
		desc = "Clear virtual-diagnostic-cycle state for wiped buffers",
		callback = function(args)
			state[args.buf] = nil
		end,
	})
end

local function create_commands()
	vim.api.nvim_create_user_command("DiagnosticCycleNext", M.next, {
		desc = "Show the next diagnostic on the current line",
	})
	vim.api.nvim_create_user_command("DiagnosticCyclePrev", M.prev, {
		desc = "Show the previous diagnostic on the current line",
	})
	vim.api.nvim_create_user_command("DiagnosticCycleRedraw", function()
		vim.diagnostic.show(nil, 0)
	end, { desc = "Force a redraw of the single-diagnostic virtual lines" })
end

function M.setup()
	if not vim.diagnostic.handlers.virtual_lines then
		vim.notify(
			"virtual-diagnostic-cycle requires Neovim >= 0.10 "
				.. "(vim.diagnostic.handlers.virtual_lines doesn't exist)",
			vim.log.levels.ERROR
		)
		return
	end

	install_handler()

	setup_autocmds()
	create_commands()
end

return M
