return {
	"folke/which-key.nvim",
  lazy = false,
	event = { "VeryLazy", "VimEnter" },
	config = require("config.whichkey").setup,
	opts = { },
}
