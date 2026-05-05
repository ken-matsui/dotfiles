-- Load which-key.nvim at last

return {
	{
		"folke/which-key.nvim",
		version = "v3.*",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			delay = 500,
		},
	},
}
