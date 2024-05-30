return {
	{
		"ellisonleao/glow.nvim",
		event = "BufRead *.md",
		opts = {
			border = "shadow",
			style = "dark", -- filled automatically with your current editor background, you can override using glow json style
			pager = false,
			width = 150,
			height = 120,
		},
		cmd = "Glow",
	},
	{
		-- NOTE: This plugin is temporary and will be removed once the issue is resolved.
		"samsaga2/vim-z80",
		event = "BufRead *.z80",
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"ActivityWatch/aw-watcher-vim",
		enabled = false,
	},
	{ "elkowar/yuck.vim", event = "BufRead *.yuck" },
	{ "tweekmonster/startuptime.vim" },
	{ "jidn/vim-dbml", event = "BufRead *.dbml" },
	{
		"RaafatTurki/hex.nvim",
		config = function()
			require("hex").setup()
		end,
	},
}
