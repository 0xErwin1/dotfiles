return {
  {
    "dstein64/vim-startuptime"
  },
	{
		"stevearc/oil.nvim",
		dependencies = { "echasnovski/mini.icons" },
		opts = {
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
      float = {
        padding = 10,
        max_width = 100,
        max_height = 100,
      }
		},
	},
	{
		"BasileusErwin/pomodoro.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			time_work = 25,
			time_break_short = 5,
			time_break_long = 20,
			timers_to_long_break = 4,
			stopped_icon = " ",
		},
	},
	{
		"ribelo/taskwarrior.nvim",
		config = true,
	},
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
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{ "elkowar/yuck.vim", event = "BufRead *.yuck" },
	{
		"RaafatTurki/hex.nvim",
		config = function()
			require("hex").setup()
		end,
	},
}
