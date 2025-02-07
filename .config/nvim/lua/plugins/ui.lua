return {
	-- if some code requires a module from an unloaded plugin, it will be automatically loaded.
	-- So for api plugins like devicons, we can always set lazy=true
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<Leader>e", "<Cmd>NvimTreeFindFileToggle<Cr>", desc = "Toggle NvimTree" },
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
			{ "<Leader>o", "<Cmd>Outline<Cr>", desc = "Toggle Outline" },
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
			{ "<Leader>h", "<Cmd>BufferLineCyclePrev<Cr>", desc = "Go to Left Buffer" },
			{ "<Leader>l", "<Cmd>BufferLineCycleNext<Cr>", desc = "Go to Right Buffer" },
			{ "<Leader>p", "<Cmd>BufferLinePick<Cr>", desc = "Pick Buffer" },
			{ "<Leader><Left>", "<Cmd>BufferLineMovePrev<Cr>", desc = "Move Buffer to Left" },
			{ "<Leader><Right>", "<Cmd>BufferLineMoveNext<Cr>", desc = "Move Buffer to Right" },
		},
		init = function()
			-- Persistent bufferline positions
			vim.o.sessionoptions = vim.o.sessionoptions .. ",globals"
		end,
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
				desc = "Close Buffer",
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
				"lazy",
				"nvim-tree",
				"quickfix",
				"toggleterm",
				"trouble",
			},
		},
	},

	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<Leader>d",
				"<Cmd>Trouble diagnostics toggle<Cr>",
				desc = "Trouble Diagnostics",
			},
			{
				"<Leader>D",
				"<Cmd>Trouble diagnostics toggle filter.buf=0<Cr>",
				desc = "Trouble Buffer Diagnostics",
			},
			{
				"<Leader>s",
				"<Cmd>Trouble symbols toggle focus=false<Cr>",
				desc = "Trouble Symbols",
			},
			{
				"<Leader>r",
				"<Cmd>Trouble lsp toggle focus=false<Cr>",
				desc = "Trouble LSP References",
			},
			{
				"<Leader>L",
				"<Cmd>Trouble loclist toggle<Cr>",
				desc = "Trouble Location List",
			},
			{
				"<Leader>q",
				"<Cmd>Trouble qflist toggle<Cr>",
				desc = "Trouble Quickfix List",
			},
		},
	},

	{
		"kevinhwang91/nvim-hlslens",
		dependencies = {
			"petertriho/nvim-scrollbar",
		},
		event = "CmdlineEnter",
		keys = { "n", "N", "/" },
		config = function()
			require("scrollbar.handlers.search").setup()
		end,
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
		opts = {
			integration = {
				-- Dynamically offset Fidget's notifications window when the nvim-tree
				-- window is open on the right side + the Fidget window is
				-- "editor"-relative.
				["nvim-tree"] = {
					-- nvim-tree window is open on the left side; this
					-- integration is not needed.
					enable = false,
				},
			},
		},
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
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
			{ "<Leader>fg", "<Cmd>Telescope live_grep<Cr>", desc = "Telescope Grep" },
			{ "<Leader>fr", "<Cmd>Telescope resume<Cr>", desc = "Telescope Resume" },
			{ "<Leader>fb", "<Cmd>Telescope buffers<Cr>", desc = "Telescope Buffers" },
			{ "<Leader>fB", "<Cmd>Telescope vim_bookmarks all<Cr>", desc = "Telescope Bookmarks" },
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
				"<Leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Telescope Files",
			},
		},
		config = true,
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			label = {
				rainbow = {
					enabled = true,
				},
			},
		},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},

	{
		"stevearc/profile.nvim",
		cond = function()
			return os.getenv("NVIM_PROFILE")
		end,
		config = function()
			local prof = require("profile")
			prof.instrument_autocmds()
			prof.instrument("*")

			local function toggle_profile()
				if prof.is_recording() then
					prof.stop()
					vim.ui.input(
						{ prompt = "Save profile to: ", completion = "file", default = "profile.json" },
						function(filename)
							if filename then
								prof.export(filename)
								vim.notify(string.format("Wrote %s", filename))
							end
						end
					)
				else
					vim.notify("Profiling started")
					prof.start("*")
				end
			end
			vim.keymap.set("", "<Leader>P", toggle_profile)
		end,
	},
}
