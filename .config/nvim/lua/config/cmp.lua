local M = {}

M.setup = function()
	local _, cmp = pcall(require, "cmp")
	local lspkind = require("lspkind")

	local _, luasnip = pcall(require, "luasnip")

	local source_names = {
		buffer = "[Buffer]",
		nvim_lsp = "[LSP]",
		nvim_lua = "[Lua]",
		cmp_tabnine = "[TN]",
		path = "[Path]",
		vsnip = "[Snippet]",
		luasnip = "[Snippet]",
		copilot = "[Copilot]",
	}

	lspkind.init({
		preset = "codicons",
		symbol_map = vim.g.config.icons.kinds,
	})

	cmp.setup({
		sorting = {
			priority_weight = 10,
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		view = {
			entries = "custom",
		},
		experimental = {
			ghost_text = true,
			native_menu = false,
		},
		native = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
		formatting = {
			fields = {
				"abbr",
				"kind",
				"menu",
			},
			expandable_indicator = false,
			format = function(entry, vim_item)
        if vim_item.kind == nil then
          vim_item.kind = ""
        end

				vim_item.kind = (lspkind.symbolic(vim_item.kind, { mode = "symbol" })) .. " " .. vim_item.kind
				vim_item.menu = source_names[entry.source.name]

				return vim_item
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "copilot", group_index = 2 },
			{ name = "luasnip", group_index = 2 },
			{ name = "path", group_index = 2 },
			{ name = "nvim_lua" },
			{ name = "orgmode" },
			{ name = "buffer" },
			{ name = "calc" },
			{ name = "emoji" },
			{ name = "treesitter" },
			{ name = "crates" },
			{ name = "zsh" },
			{ name = "tmux" },
			{ name = "npm" },
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
					fallback()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.confirm(cmp.confirm_opts) then
					return
				end

				fallback()
			end),
		}),
	})

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
		matching = { disallow_symbol_nonprefix_matching = false },
	})

	cmp.setup.filetype({
		"dap-repl",
		"dapui_watches",
	}, {
		sources = cmp.config.sources({
			{ name = "dap" },
			{ name = "buffer" },
		}),
	})
end

return M
