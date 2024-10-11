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
			{ "<Leader>s", "<Cmd>NvimTreeFindFileToggle<Cr>", mode = "n", desc = "Toggle NvimTree" },
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
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<Leader>o", "<Cmd>Outline<Cr>", desc = "Toggle outline" },
		},
		opts = {},
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
			{ "<Leader>h", "<Cmd>BufferLineCyclePrev<Cr>", "n", desc = "Go to left buffer" },
			{ "<Leader>l", "<Cmd>BufferLineCycleNext<Cr>", "n", desc = "Go to right buffer" },
			{ "<Leader>p", "<Cmd>BufferLinePick<Cr>", "n", desc = "Pick buffer" },
			{ "<Leader><Left>", "<Cmd>BufferLineMovePrev<Cr>", "n", desc = "Move buffer to left" },
			{ "<Leader><Right>", "<Cmd>BufferLineMoveNext<Cr>", "n", desc = "Move buffer to right" },
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
		"famiu/bufdelete.nvim",
		keys = {
			{
				"<Leader>w",
				function()
					require("bufdelete").bufdelete(0, true)
				end,
				"n",
				desc = "Close buffer",
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
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<Leader>td",
				"<Cmd>Trouble diagnostics toggle<Cr>",
				desc = "Trouble Diagnostics",
			},
			{
				"<Leader>tD",
				"<Cmd>Trouble diagnostics toggle filter.buf=0<Cr>",
				desc = "Trouble Buffer Diagnostics",
			},
			{
				"<Leader>ts",
				"<Cmd>Trouble symbols toggle focus=false<Cr>",
				desc = "Trouble Symbols",
			},
			{
				"<Leader>tr",
				"<Cmd>Trouble lsp toggle focus=false win.position=right<Cr>",
				desc = "Trouble LSP Definitions / References",
			},
			{
				"<Leader>tl",
				"<Cmd>Trouble loclist toggle<Cr>",
				desc = "Trouble Location List",
			},
			{
				"<Leader>tq",
				"<Cmd>Trouble qflist toggle<Cr>",
				desc = "Trouble Quickfix List",
			},
		},
	},

	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		opts = {
			animate = {
				enabled = false,
			},
			bottom = {
				{
					title = "Trouble",
					ft = "trouble",
					size = { height = 0.1 },
				},
				{ ft = "qf", title = "QuickFix" },
				{
					ft = "help",
					size = { height = 20 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
			},
			left = {
				{
					title = "NvimTree",
					ft = "NvimTree",
					size = { height = 0.5 },
				},
				{
					title = "Outline",
					ft = "Outline",
					pinned = true,
					open = "SymbolsOutlineOpen",
				},
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

	{
		"j-hui/fidget.nvim",
		version = "v1.*",
		opts = {},
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
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "treesitter" },
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
			{ "<Leader>g", "<Cmd>Telescope live_grep<Cr>", "n", desc = "Telescope grep" },
			{ "<Leader>r", "<Cmd>Telescope resume<Cr>", "n" },
			{ "<Leader>b", "<Cmd>Telescope vim_bookmarks all<Cr>", "n", desc = "Telescope bookmarks" },
		},
		opts = {
			defaults = {
				file_ignore_patterns = { ".git" },
				mappings = {
					i = {
						["<C-p>"] = "cycle_history_prev",
						["<C-n>"] = "cycle_history_next",
					},
				},
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
				"<Leader>f",
				function()
					require("telescope.builtin").find_files()
				end,
				"n",
				desc = "Telescope files",
			},
		},
		config = true,
	},

	{
		"easymotion/vim-easymotion",
		event = "VeryLazy",
	},
}
