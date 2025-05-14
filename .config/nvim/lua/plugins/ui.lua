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
			{
				"<Leader>w",
				function()
					-- Close and visually move left.  This is more intuitive because this
					-- avoids jumping around buffers when closing current buffers depending
					-- on the buffer numbers.
					local cur_buf_num = vim.api.nvim_get_current_buf()
					vim.cmd("BufferLineCyclePrev")
					vim.cmd("bdelete " .. cur_buf_num)
				end,
				desc = "Close Buffer",
			},
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

	-- Better Quickfix
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	-- Modifiable Quickfix
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
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
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "1.*",
			},
			"tom-anders/telescope-vim-bookmarks.nvim",
		},
		keys = {
			{ "<Leader>fg", "<Cmd>Telescope live_grep_args<Cr>", desc = "Telescope Grep" },
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
					additional_args = function()
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
				live_grep_args = {
					auto_quoting = true,
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("vim_bookmarks")
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
