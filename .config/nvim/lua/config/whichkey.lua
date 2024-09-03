local M = {}

M.opts = {
	mode = { "n" }, -- Normal mode
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

M.v_opts = {
	mode = { "v" }, -- Visual mode
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

M.code_keymap = function(whichkey)
	vim.cmd("autocmd FileType * lua CodeRunner()")

	function CodeRunner()
		local bufnr = vim.api.nvim_get_current_buf()
		local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
		local keymap = nil
		local visual_keymap = nil

		if file_type == "http" then
			keymap = {
				name = "HTTP Client",
				r = {
					"<cmd>Rest run<CR>",
					"Run the request under the cursor",
				},
				o = {
					"<cmd>Rest logs<CR>",
					"Show rest logs",
				},
				l = {
					"<cmd>Rest last<CR>",
					"Re-run the last request",
				},
			}

			whichkey.register({ l = keymap }, {
				mode = "v", -- Visual mode
				prefix = "<leader>",
				buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = false, -- use `nowait` when creating keymaps
			})
		elseif file_type == "jdtls" then
			keymap = {
				name = "Code",
				o = { '<cmd>lua require("jdtls").organize_imports()<CR>', "Sort Imports" },
				u = { "<cmd>JdtUpdateConfig<CR>", "Update Config" },
			}
		end

		if keymap ~= nil then
			whichkey.register(
				{ l = keymap },
				{ mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>" }
			)
		elseif visual_keymap ~= nil then
		end
	end
end

M.setup = function(_, conf)
	local status_ok, whichkey = pcall(require, "which-key")

	if not status_ok then
		return
	end

	local mappings = {
		{ "<leader>a", "<cmd>Outline<CR>", desc = "Outline", nowait = false, remap = false },
		{ "<leader>d", desc = "DAP", nowait = false, remap = false },
		{
			"<leader>dB",
			'<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
			desc = "Set Breakpoint",
			nowait = false,
			remap = false,
		},
		{
			"<leader>dR",
			'<cmd>lua require("dap").run_to_cursor<CR>',
			desc = "Run to cursor",
			nowait = false,
			remap = false,
		},
		{ "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint", nowait = false, remap = false },
		{ "<leader>dc", "<cmd>DapContinue<CR>", desc = "Continue", nowait = false, remap = false },
		{ "<leader>di", "<cmd>DapStepInto<CR>", desc = "Step Into", nowait = false, remap = false },
		{ "<leader>do", '<cmd>lua require("dap").step_out<CR>', desc = "Step Out", nowait = false, remap = false },
		{ "<leader>dr", '<cmd>lua require("dap").eval<CR>', desc = "Eval", nowait = false, remap = false },
		{ "<leader>ds", "<cmd>DapStepOver<CR>", desc = "Step Over", nowait = false, remap = false },
		{ "<leader>du", "<cmd> lua require('dapui').toggle()<CR>", desc = "Toggle UI", nowait = false, remap = false },
		{
			"<leader>dx",
			function()
				require("dap").terminate()
				require("dap").clear_breakpoints()
				require("dapui").close()
			end,
			desc = "Disconnect",
			nowait = false,
			remap = false,
		},
		{
			"<leader>e",
			function()
				require("oil").open_float()
			end,
			desc = "Explorer",
			nowait = false,
			remap = false,
		},
		{ "<leader>f", group = "Find", nowait = false, remap = false },
		{ "<leader>fG", group = "Git", nowait = false, remap = false },
		{
			"<leader>fGp",
			'<cmd>lua require("gitsigns").preview_hunk()<CR>',
			desc = "Preview hunk",
			nowait = false,
			remap = false,
		},
		{ "<leader>fGr", "<cmd>FzfLua <CR>", desc = "Reset hunk", nowait = false, remap = false },
		{ "<leader>fGs", "<cmd>FzfLua git_status<CR>", desc = "Git status", nowait = false, remap = false },
		{ "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find in buffer", nowait = false, remap = false },
		{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files", nowait = false, remap = false },
		{ "<leader>fg", "<cmd>FzfLua grep<CR>", desc = "Live Grep", nowait = false, remap = false },
		{ "<leader>fl", group = "LSP", nowait = false, remap = false },
		{ "<leader>flD", "<cmd>FzfLua lsp_declarations", desc = "Declarations", nowait = false, remap = false },
		{ "<leader>fld", "<cmd>FzfLua lsp_definitions<CR>", desc = "Definitions", nowait = false, remap = false },
		{
			"<leader>fli",
			"<cmd>FzfLua lsp_implementations<CR>",
			desc = "lsp_implementations",
			nowait = false,
			remap = false,
		},
		{ "<leader>flr", "<cmd>FzfLua lsp_references<CR>", desc = "References", nowait = false, remap = false },
		{
			"<leader>flt",
			"<cmd>FzfLua lsp_type_definitions<CR>",
			desc = "Type Definitions",
			nowait = false,
			remap = false,
		},
		{ "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = false, remap = false },
		{ "<leader>w", "<cmd>update!<CR>", desc = "Save", nowait = false, remap = false },
	}

	local visual_keymap = {}

	local keymap_l = {
		{ "<leader>c", group = "Code" },
		{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
		{ "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Line Diagnostics" },
		{
			"<leader>cf",
			'<cmd>lua require("conform").format({ async = true, lsp_fallback = true })<CR>',
			desc = "Format Document",
		},
		{ "<leader>ci", "<cmd>LspInfo<CR>", desc = "Lsp info" },
		{ "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Raname" },
		{ "<leader>g", group = "Goto diagnostic" },
		{ "<leader>gD", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
		{
			"<leader>gE",
			"<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>",
			desc = "Next Error",
		},
		{
			"<leader>gW",
			"<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<CR>",
			desc = "Next Warning",
		},
		{ "<leader>gd", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous Diagnostic" },
		{
			"<leader>ge",
			"<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>",
			desc = "Previous Error",
		},
		{
			"<leader>gw",
			"<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<CR>",
			desc = "Previous Warning",
		},
	}

	local keymap_g = {
		{ "g", group = "Goto" },
		{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go Declarantion" },
		{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go Definition" },
		{ "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go Implementation" },
		{ "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go References" },
		{ "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature Help" },
		{ "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Go Type Definition" },
	}

	whichkey.setup(conf)

	whichkey.add(keymap_l, M.opts)
	whichkey.add(keymap_g, M.opts)
	whichkey.add(mappings, M.opts)
	whichkey.add(visual_keymap, M.v_opts)
	M.code_keymap(whichkey)
end

return M
