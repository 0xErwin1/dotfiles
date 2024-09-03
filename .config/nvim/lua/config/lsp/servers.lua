local util = require("lspconfig.util")
local lspconfig = require("lspconfig")

return {
	{
		package_name = "nixd",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.nixd.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "gopls",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.gopls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "nimlsp",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.nimls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "typescript-language-server",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.tsserver.setup({
				root_dir = util.root_pattern("package.json"),
				filetypes = {
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"javascript",
					"javascriptreact",
					"vue",
				},
				preferences = {
					quotePreference = "single",
					importModuleSpecifierPreference = "relative",
					includeCompletionsForImportStatements = true,
					includeInlayParameterNameHints = "all",
					allowRenameOfImportPath = true,
				},
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "asm-lsp",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.asm_lsp.setup({
				filetypes = {
					"asm",
					"s",
					"nasm",
					"a",
				},
				root_dir = util.root_pattern(".git", "."),
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "ocaml-lsp",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.ocamllsp.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "tailwindcss-language-server",
		enable = false,
		config = function(on_attach, capabilities)
			lspconfig.tailwindcss.setup({
				on_attach,
				capabilities,
				filetypes = {
					"css",
					"scss",
					"sass",
					"postcss",
					"html",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"svelte",
					"vue",
					"rust",
				},
				init_options = {
					userLanguages = {
						rust = "html",
					},
				},
				root_dir = util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.ts",
					"postcss.config.js",
					"postcss.config.ts",
					"windi.config.ts"
				),
			})
		end,
	},
	{
		package_name = "biome",
		enable = util.root_pattern("biome.json")(vim.fn.expand("%:p")),
		config = function(on_attach, capabilities)
			lspconfig.biome.setup({
				root_dir = util.root_pattern("biome.json"),
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "ltex-ls",
		enable = true,
		config = function(on_attach, capabilities)
			require("ltex-ls").setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text", "org", "norg" },
				settings = {
					ltex = {
						enabled = { "latex", "tex", "bib", "markdown", "gitcommit", "text", "org", "norg" },
						language = "auto",
						dictionary = (function()
							local files = {}
							for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
								local lang = vim.fn.fnamemodify(file, ":t:r")
								local fullpath = vim.fn.fnamemodify(file, ":p")
								files[lang] = { ":" .. fullpath }
							end

							if files.default then
								for lang, _ in pairs(files) do
									if lang ~= "default" then
										vim.list_extend(files[lang], files.default)
									end
								end
								files.default = nil
							end
							return files
						end)(),
					},
				},
			})
		end,
	},
	{
		package_name = nil,
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.metals.setup({
				root_dir = util.root_pattern("build.sbt", "build.sc", "build.gradle", "pom.xml", "*.scala"),
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "jdtls",
		enable = false,
		config = function(on_attach, capabilities)
			lspconfig.jdtls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "bash-language-server",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.bashls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "html-lsp",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.html.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "rust-analyzer",
		enable = false,
		config = function(on_attach, capabilities)
			lspconfig.rust_analyzer.setup({
				on_attach,
				capabilities,
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = true,
						},
					},
				},
			})
		end,
	},
	{
		package_name = "yaml-language-server",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.yamlls.setup({
				on_attach,
				capabilities,
				settings = {
					yaml = {
						schemas = {
							["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose.*",
						},
					},
				},
			})
		end,
	},
	{
		package_name = "vim-language-server",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.vimls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "json-lsp",
		enable = true,
		config = function(on_attach, capabilities)
			local _, schemastore = pcall(require, "schemastore")

			lspconfig.jsonls.setup({
				on_attach,
				capabilities,
				settings = {
					json = {
						schemas = schemastore.json.schemas({
							select = {
								".eslintrc",
								"package.json",
								"tsconfig.json",
								"tslint.json",
							},
						}),
						validate = { enable = true },
					},
				},
			})
		end,
	},
	{
		package_name = "lua-language-server",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.lua_ls.setup({
				on_attach,
				capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},
	{
		package_name = "pyright",
		enable = false,
		config = function(on_attach, capabilities)
			lspconfig.pyright.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "sqlls",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.sqlls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "css-lsp",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.cssls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "zls",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.zls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "diagnostic-languageserver",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.diagnosticls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "clangd",
		enable = true,
		config = function(on_attach, capabilities)
			capabilities.offsetEncoding = "utf-16"

			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp" },
				single_file_support = true,
				root_dir = lspconfig.util.root_pattern(
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git"
				),
			})
		end,
	},
	{
		package_name = "dockerfile-language-server",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.dockerls.setup({
				on_attach,
				capabilities,
			})
		end,
	},
	{
		package_name = "taplo",
		enable = true,
		config = function(on_attach, capabilities)
			lspconfig.taplo.setup({
				on_attach,
				capabilities,
			})
		end,
	},
}
