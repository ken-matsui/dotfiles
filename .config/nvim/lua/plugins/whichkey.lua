-- Load which-key.nvim at last

return {
	{
		"folke/which-key.nvim",
		cond = function()
			return vim.fn.has("nvim-0.9.4") == 1
		end,
		lazy = true,
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		config = true,
	},
}
