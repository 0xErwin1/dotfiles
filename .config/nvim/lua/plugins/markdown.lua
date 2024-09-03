return {
	{
		"tadmccorkle/markdown.nvim",
		ft = "VeryLazy",
		config = function()
			require("markdown").setup()
		end,
	},
	{
		"MeanderingProgrammer/markdown.nvim",
    enabled = false,
		name = "render-markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		config = function()
			require("render-markdown").setup({})
		end,
	},
}
