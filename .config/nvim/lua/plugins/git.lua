return {
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
}
