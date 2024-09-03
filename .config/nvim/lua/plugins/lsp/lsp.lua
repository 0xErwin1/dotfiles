return {
	"neovim/nvim-lspconfig",
	config = function()
		require("config.lsp").setup()
	end,
	dependencies = {
		{
			"j-hui/fidget.nvim",
		},
		{
			"vigoux/ltex-ls.nvim",
			commit = "c8139ea6b7f3d71adcff121e16ee8726037ffebd",
		},
		{
			"nvimtools/none-ls.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvimtools/none-ls-extras.nvim",
				"gbprod/none-ls-shellcheck.nvim",
			},
			name = "null-ls",
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					java = { "google-java-format" },
					nasm = { "asmfmt" },
					asm = { "asmfmt" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					cmake = { "cmake-format" },
					make = { "cmake-format" },
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
					rust = { "rustfmt" },
					json = { { "prettierd", "jq" } },
					ocaml = { "ocamlformat" },
					zig = { "zigfmt" },
					bash = { "shellcheck" },
					markdown = { "prettierd" },
					dart = { "dart format" },
					go = { "gofmt" },
					ignis = { "trim_whitespace" },
          nix = { "nixfmt" },
					["_"] = { "trim_whitespace" },
				},
				formatters = {
					["clang-format"] = {},
				},
			},
			config = function(_, opts)
				opts.formatters["clang-format"] = {
					command = "clang-format",
					cwd = require("conform.util").root_file({ ".clang-format" }),
				}

				require("conform").setup(opts)
			end,
		},
		{
			"williamboman/mason.nvim",
			event = "VeryLazy",
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				{
					"WhoIsSethDaniel/mason-tool-installer.nvim",
					event = "VeryLazy",
				},
			},
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		{
			"ray-x/lsp_signature.nvim",
			opts = {
				bind = true,
				max_height = 10, -- max height of signature floating_window
				max_width = 70, -- max_width of signature floating_window
				noice = true, -- set to true if you using noice to render markdown
				wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
				floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
			},
		},
		"b0o/schemastore.nvim",
		"folke/lsp-colors.nvim",
		"SmiteshP/nvim-navic",
	},
}
