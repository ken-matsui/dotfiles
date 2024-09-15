return {
	-- if some code requires a module from an unloaded plugin, it will be automatically loaded.
	-- So for api plugins like devicons, we can always set lazy=true
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<Leader>s", "<Cmd>NvimTreeFindFileToggle<Cr>", mode = "n", desc = "NvimTree Toggle" },
		},
		opts = {
			sort_by = "case_sensitive",
			diagnostics = {
				enable = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		},
	},

	{
		"akinsho/bufferline.nvim",
		version = "v4.*",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<Leader>h", "<Cmd>BufferLineCyclePrev<Cr>", "n" },
			{ "<Leader>l", "<Cmd>BufferLineCycleNext<Cr>", "n" },
			{ "<Leader>t", "<Cmd>BufferLinePick<Cr>", "n" },
			{ "<Leader><Left>", "<Cmd>BufferLineMovePrev<Cr>", "n" },
			{ "<Leader><Right>", "<Cmd>BufferLineMoveNext<Cr>", "n" },
		},
		opts = {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = true,
					},
				},
			},
		},
	},

	{
		"utilyre/barbecue.nvim",
		version = "v1.*",
		lazy = true,
		event = "BufReadPre",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		config = true,
	},

	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				theme = "material",
			},
			extensions = {
				"nvim-tree",
				"toggleterm",
			},
		},
	},

	{
		"petertriho/nvim-scrollbar",
		lazy = true,
		event = "BufReadPre",
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("scrollbar").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"ray-x/cmp-treesitter",
			"onsails/lspkind-nvim",
		},
		opts = function()
			local cmp = require("cmp")
			return {
				preselect = cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					["<Esc>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = false,
					}),
				}),
				sources = cmp.config.sources({
					{ name = "buffer" },
					{ name = "path" },
					{ name = "treesitter" },
					{ name = "nvim_lsp" },
				}),
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			}
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.*",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"tom-anders/telescope-vim-bookmarks.nvim",
		},
		keys = {
			{ "<Leader>f", "<Cmd>Telescope live_grep<Cr>", "n" },
			{ "<Leader>r", "<Cmd>Telescope resume<Cr>", "n" },
			{ "<Leader>b", "<Cmd>Telescope vim_bookmarks all<Cr>", "n" },
		},
		opts = {
			defaults = {
				file_ignore_patterns = { ".git" },
			},
			pickers = {
				live_grep = {
					additional_args = function(opts)
						return { "--hidden" }
					end,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("vim_bookmarks")
		end,
	},
	{
		"prochri/telescope-all-recent.nvim",
		lazy = true,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"kkharji/sqlite.lua",
		},
		keys = {
			{
				"<Leader>o",
				function()
					require("telescope.builtin").find_files()
				end,
				"n",
				desc = "Find file",
			},
		},
		config = true,
	},

	{
		"easymotion/vim-easymotion",
		event = "VeryLazy",
	},
}
