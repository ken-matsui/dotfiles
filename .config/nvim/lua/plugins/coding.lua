return {
	-- Detect shiftwidth and expandtab automatically
	"tpope/vim-sleuth",

	"dkarter/bullets.vim",

	"farmergreg/vim-lastplace",

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
		"windwp/nvim-autopairs",
		event = "InsertEnter",
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
		"vim-scripts/ReplaceWithRegister",
		lazy = true,
		event = "VeryLazy",
	},

	{
		"rmagatti/auto-session",
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			log_level = "error",
			auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
			auto_save_enabled = true,
			pre_save_cmds = {
				"cclose",
				"lclose",
				"NvimTreeClose",
				"TroubleCloseAll",
				function() -- Close outline
					if vim.fn.exists(":OutlineClose") == 2 then
						vim.cmd("OutlineClose")
					end
				end,
			},
			session_lens = {
				load_on_setup = false,
			},
		},
	},

	{
		"ludovicchabant/vim-gutentags",
		config = function()
			vim.g.gutentags_cache_dir = vim.fn.stdpath("data")
		end,
	},

	{
		"stevearc/conform.nvim",
		cond = function()
			return vim.fn.has("nvim-0.10") == 1
		end,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt" },
				java = { "google-java-format" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},

	--
	-- Git
	--

	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufReadPre",
		opts = {
			-- GitLens-like blame line
			current_line_blame = true,
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "<Leader>Gn", function()
					if vim.wo.diff then
						return "<Leader>Gn"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Go to next Git hunk" })

				map("n", "<Leader>Gp", function()
					if vim.wo.diff then
						return "<Leader>Gp"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Go to previous Git hunk" })

				-- Actions
				map("n", "<Leader>Gs", gs.stage_hunk, { desc = "Stage Git hunk" })
				map("n", "<Leader>Gr", gs.reset_hunk, { desc = "Reset Git hunk" })
				map("v", "<Leader>Gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage Git hunk" })
				map("v", "<Leader>Gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset Git hunk" })
				map("n", "<Leader>GS", gs.stage_buffer, { desc = "Stage Git buffer" })
				map("n", "<Leader>Gu", gs.undo_stage_hunk, { desc = "Undo stage Git hunk" })
				map("n", "<Leader>GR", gs.reset_buffer, { desc = "Reset Git buffer" })
				map("n", "<Leader>GP", gs.preview_hunk, { desc = "Preview Git hunk" })
				map("n", "<Leader>Gb", function()
					gs.blame_line({ full = true })
				end, { desc = "Blame Git line" })
				map("n", "<Leader>Gd", gs.diffthis, { desc = "Diff Git" })
				map("n", "<Leader>GD", function()
					gs.diffthis("~")
				end, { desc = "Diff Git" })
				map("n", "<Leader>Gt", gs.toggle_deleted, { desc = "Toggle Git deleted" })

				-- Text object
				map({ "o", "x" }, "<Leader>Gh", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Git hunk" })
			end,
		},
	},

	{
		"akinsho/git-conflict.nvim",
		version = "v2.*",
		config = true,
	},

	--
	-- LSP
	--
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
			-- Disable snippets
			lspconfig.util.default_config.capabilities.textDocument.completion.completionItem.snippetSupport = false

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
			require("lspconfig").lua_ls.setup({})
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}
