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
		branch = "main",
		lazy = false,
		dependencies = {
			"RRethy/nvim-treesitter-endwise",
		},
		build = ":TSUpdate",
		opts = {
			parsers = {
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
		},
		config = function(_, opts)
			local treesitter = require("nvim-treesitter")
			local notify = vim.notify_once or vim.notify
			if not treesitter.install then
				notify("Run :Lazy sync nvim-treesitter to switch nvim-treesitter to main", vim.log.levels.WARN)
				return
			end

			treesitter.setup()
			if vim.fn.executable("tree-sitter") == 1 then
				treesitter.install(opts.parsers)
			else
				notify("nvim-treesitter main requires the tree-sitter CLI to install parsers", vim.log.levels.WARN)
			end

			local parser_by_lang = {}
			for _, parser in ipairs(opts.parsers) do
				parser_by_lang[parser] = true
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match)
					if not lang or not parser_by_lang[lang] then
						return
					end

					if (lang == "c" or lang == "cpp") and vim.api.nvim_buf_line_count(args.buf) > 50000 then
						vim.notify(
							"Treesitter disabled for large file: " .. vim.api.nvim_buf_get_name(args.buf),
							vim.log.levels.WARN
						)
						return
					end

					local ok = pcall(vim.treesitter.start, args.buf, lang)
					if ok then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	-- Indentation
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "v3.*",
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
		event = "BufReadPost",
		opts = {
			providers = {
				"lsp",
				-- "treesitter", too slow
				"regex",
			},
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
