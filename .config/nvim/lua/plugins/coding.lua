return {
	{
		"github/copilot.vim", -- :Copilot setup
		lazy = true,
		event = "VeryLazy",
		config = function()
			vim.g.copilot_filetypes = {
				NvimTree = false,
			}
		end,
	},

	{
		"numToStr/Comment.nvim",
		lazy = true,
		config = true,
	},

	{
		"cappyzawa/trim.nvim",
		version = "v0.8.*",
		lazy = true,
		event = "VeryLazy",
	},

	{
		"MattesGroeger/vim-bookmarks",
		lazy = true,
		event = "BufRead",
		init = function()
			vim.g.bookmark_save_per_working_dir = 1
		end,
	},

	{
		"rmagatti/auto-session",
		opts = {
			log_level = "error",
			auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
			auto_save_enabled = true,
		},
	},

	{
		"ludovicchabant/vim-gutentags",
		config = function()
			vim.g.gutentags_cache_dir = vim.fn.stdpath("data")
		end,
	},

	{
		"google/vim-glaive",
		dependencies = {
			"google/vim-maktaba",
			"google/vim-codefmt",
		},
		lazy = true,
		ft = {
			"python",
			"rust",
			"lua",
		},
		config = function()
			vim.cmd("call glaive#Install()")
			vim.cmd([[
				augroup autoformat_settings
					autocmd FileType python AutoFormatBuffer black
					autocmd FileType rust AutoFormatBuffer rustfmt
					autocmd FileType lua AutoFormatBuffer stylua
				augroup END
			]])
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- Add cmp_nvim_lsp capabilities settings to lspconfig
			lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig.util.default_config.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- Executes the callback function every time a
			-- language server is attached to a buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end,
			})

			require("lspconfig").clangd.setup({})
		end,
	},
}
