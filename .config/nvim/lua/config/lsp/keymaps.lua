local M = {}
local keymap = vim.api.nvim_set_keymap

M.setup = function(client, bufnr)
	local opts = { noremap = true, silent = true }

	local status_ok, whichkey = pcall(require, "which-key")

	if not status_ok then
		return
	end
end

return M
