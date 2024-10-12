return {
	-- Detect shiftwidth and expandtab automatically
	"tpope/vim-sleuth",

	"dkarter/bullets.vim",

	"farmergreg/vim-lastplace",

	{
		"rstacruz/vim-closer",
		lazy = true,
		event = "InsertEnter",
	},

	{
		"tpope/vim-endwise",
		lazy = true,
		event = "InsertEnter",
	},

	{
		"tpope/vim-repeat",
		lazy = true,
		event = "VeryLazy",
	},

	{
		"machakann/vim-sandwich",
		lazy = true,
		event = "VeryLazy",
	},
}
