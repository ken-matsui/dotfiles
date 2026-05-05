return {
	{
		"NMAC427/guess-indent.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	{
		"dkarter/bullets.vim",
		ft = {
			"markdown",
			"text",
			"gitcommit",
		},
	},

	{
		"farmergreg/vim-lastplace",
		event = "BufReadPre",
	},

	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},

	{
		"tpope/vim-abolish",
		event = "VeryLazy",
	},

	{
		"machakann/vim-sandwich",
		event = "VeryLazy",
	},

	{
		"github/copilot.vim", -- :Copilot setup
		event = "VeryLazy",
		config = function()
			vim.g.copilot_filetypes = {
				NvimTree = false,
			}
		end,
	},

	{
		"numToStr/Comment.nvim",
		dependencies = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				opts = { enable_autocmd = false },
			},
		},
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "x", "o" }, desc = "Comment toggle linewise" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "x", "o" }, desc = "Comment toggle blockwise" },
		},
		opts = function()
			return {
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},

	{
		"MattesGroeger/vim-bookmarks",
		event = "BufRead",
		init = function()
			vim.g.bookmark_save_per_working_dir = 1
		end,
	},

	{
		"vim-scripts/ReplaceWithRegister",
		event = "VeryLazy",
	},

	{
		"rmagatti/auto-session",
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			auto_save = true,
			log_level = "error",
			pre_save_cmds = { "only" },
			session_lens = {
				load_on_setup = false,
			},
			suppressed_dirs = { "~/", "~/Downloads", "/" },
			post_restore_cmds = {
				function()
					-- Restore bufferline positions
					local lazy = require("bufferline.lazy")
					local utils = lazy.require("bufferline.utils") ---@module "bufferline.utils"
					local state = lazy.require("bufferline.state") ---@module "bufferline.state"
					state.custom_sort = utils.restore_positions()
				end,
			},
		},
	},

	{
		"ludovicchabant/vim-gutentags",
		ft = {
			"c",
			"cpp",
		},
		config = function()
			vim.g.gutentags_cache_dir = vim.fn.stdpath("data")
		end,
	},

	{
		"stevearc/conform.nvim",
		version = "v9.*",
		cmd = { "ConformInfo" },
		init = function()
			vim.api.nvim_create_user_command("FormatBuffer", function()
				require("conform").format({ async = true })
			end, { desc = "Format buffer" })
		end,
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				cpp = { "clang-format" },
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
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gvdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GRename",
			"GDelete",
			"GRemove",
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		version = "v1.*",
		event = { "BufReadPre", "BufNewFile" },
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
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "<Leader>gn", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Go to next Git hunk" })

				map("n", "<Leader>gp", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Go to previous Git hunk" })

				-- Actions
				map("n", "<Leader>gs", gitsigns.stage_hunk, { desc = "Stage Git hunk" })
				map("n", "<Leader>gr", gitsigns.reset_hunk, { desc = "Reset Git hunk" })

				map("v", "<Leader>gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage Git hunk" })

				map("v", "<Leader>gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset Git hunk" })

				map("n", "<Leader>gS", gitsigns.stage_buffer, { desc = "Stage Git buffer" })
				map("n", "<Leader>gR", gitsigns.reset_buffer, { desc = "Reset Git buffer" })
				map("n", "<Leader>gP", gitsigns.preview_hunk, { desc = "Preview Git hunk" })
				map("n", "<Leader>gi", gitsigns.preview_hunk_inline, { desc = "Preview Git hunk inline" })

				map("n", "<Leader>gb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Blame Git line" })

				map("n", "<Leader>gd", gitsigns.diffthis, { desc = "Diff Git" })

				map("n", "<Leader>gD", function()
					gitsigns.diffthis("~")
				end, { desc = "Diff Git" })

				-- Text object
				map({ "o", "x" }, "<Leader>gh", gitsigns.select_hunk, { desc = "Select Git hunk" })
			end,
		},
	},

	--
	-- LSP
	--
	{
		"neovim/nvim-lspconfig",
		version = "v2.*",
		cond = function()
			return vim.fn.has("nvim-0.11.3") == 1
		end,
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			-- Use blink.cmp's LSP capabilities, with snippets disabled
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = false
			vim.lsp.config("*", { capabilities = capabilities })

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP buffer-local mappings",
				callback = function(event)
					local bufnr = event.buf
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
					end

					map("n", "K", vim.lsp.buf.hover, "Hover")
					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
					map("n", "gR", vim.lsp.buf.references, "References")
					map("n", "gs", vim.lsp.buf.signature_help, "Signature help")
					map("n", "<F2>", vim.lsp.buf.rename, "Rename")
					map({ "n", "x" }, "<F3>", function()
						vim.lsp.buf.format({ async = true })
					end, "Format")
					map("n", "<F4>", vim.lsp.buf.code_action, "Code action")

					map("n", "gn", function()
						vim.diagnostic.jump({ count = 1 })
					end, "Next diagnostic")
					map("n", "gp", function()
						vim.diagnostic.jump({ count = -1 })
					end, "Previous diagnostic")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.inlayHintProvider then
						map("n", "<Leader>H", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
						end, "Toggle inlay hints")
					end
				end,
			})

			if vim.fn.executable("clangd") == 1 then
				vim.lsp.config("clangd", {
					cmd = {
						"clangd",
						"--suggest-missing-includes",
						"--header-insertion=never",
						"--completion-style=detailed",
						"--clang-tidy",
					},
				})
				vim.lsp.enable("clangd")
			end

			if vim.fn.executable("lua-language-server") == 1 then
				vim.lsp.config("lua_ls", {
					-- https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = {
									"vim",
									"require",
								},
							},
							workspace = {
								-- Make the server aware of Neovim runtime files without
								-- indexing every installed plugin (which is very slow).
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME .. "/lua",
									"${3rd}/luv/library",
								},
							},
							-- Do not send telemetry data containing a randomized but unique identifier
							telemetry = {
								enable = false,
							},
						},
					},
				})
				vim.lsp.enable("lua_ls")
			end

			if vim.fn.executable("rust-analyzer") == 1 then
				vim.lsp.enable("rust_analyzer")
			end

			if vim.fn.executable("pyright") == 1 then
				vim.lsp.enable("pyright")
			elseif vim.fn.executable("pylsp") == 1 then
				vim.lsp.enable("pylsp")
			end
		end,
	},
}
