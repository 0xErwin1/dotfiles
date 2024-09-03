local M = {}

M.with_diagnostics_code = function(builtin)
	return builtin.with({
		diagnostics_format = "#{m} [#{c}]",
	})
end

M.with_root_file = function(builtin, file)
	return builtin.with({
		condition = function(utils)
			return utils.root_has_file(file)
		end,
	})
end

M.setup = function(opts)
	local status_ok, nls = pcall(require, "null-ls")

	if not status_ok then
		return
	end

	M.nls_utils = require("null-ls.utils")
	local builtin = nls.builtins

	nls.setup({
		debounce = 10000,
		save_after_format = false,
		update_in_insert = false,
		sources = {
			-- diagnostics
			builtin.diagnostics.markdownlint.with({
				args = {
					"--config",
					vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h") .. "/.markdownlint.json",
				},
			}),
			-- 			require("none-ls.diagnostics.flake8"),
			builtin.diagnostics.cmake_lint.with({
				method = nls.methods.DIAGNOSTICS_ON_SAVE,
			}),
			builtin.diagnostics.checkmake,
			builtin.diagnostics.cfn_lint,
			builtin.diagnostics.golangci_lint,
			M.with_root_file(require("none-ls.diagnostics.eslint_d"), ".eslintrc.json"),
			M.with_diagnostics_code(require("none-ls-shellcheck.diagnostics")),

			-- code actions
			builtin.code_actions.gitsigns,
			builtin.code_actions.gitrebase,
			builtin.code_actions.refactoring,
			builtin.code_actions.gomodifytags,
			require("none-ls-shellcheck.code_actions"),

			-- hover
			builtin.hover.dictionary,
		},
		on_attach = opts.on_attach,
		root_dir = M.nls_utils.root_pattern(".git"),
	})
end

return M
