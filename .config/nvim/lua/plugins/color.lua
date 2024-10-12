return {
	-- the colorscheme should be available when starting Neovim
	{
		"marko-cerovac/material.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.g.material_style = "deep ocean"
			vim.cmd.colorscheme("material")
		end,
	},

	-- Syntax Highlight
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"comment",
				"c",
				"cpp",
				"dockerfile",
				"html",
				"java",
				"javascript",
				"json",
				"llvm",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
			highlight = {
				enable = true,
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	-- Highlight arguments
	{
		"m-demare/hlargs.nvim",
		lazy = true,
		event = "BufReadPre",
		config = true,
	},

	-- Indentation
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "v3.*",
		lazy = true,
		event = "BufReadPost",
		config = function()
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "IBLYellow", { fg = "#E5C07B" })
			end)

			require("ibl").setup({
				exclude = {
					filetypes = {
						"nvim-tree",
						"lazy",
					},
				},
				indent = {
					char = "▏",
					smart_indent_cap = false,
				},
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
					highlight = {
						"IBLYellow",
					},
				},
			})
		end,
	},

	-- Highlight the same word
	{
		"RRethy/vim-illuminate",
		lazy = true,
		event = "BufReadPost",
		opts = {
			filetypes_denylist = {
				"NvimTree",
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local highlight = "#354A51" -- material oceanic highlight
			vim.api.nvim_set_hl(0, "IlluminatedWordText", {
				bg = highlight,
			})
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", {
				bg = highlight,
			})
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", {
				bg = highlight,
			})
		end,
	},
}
