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
				end, { expr = true, desc = "GitNextHunk" })

				map("n", "<Leader>Gp", function()
					if vim.wo.diff then
						return "<Leader>Gp"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "GitPrevHunk" })

				-- Actions
				map("n", "<Leader>Gs", gs.stage_hunk, { desc = "GitStageHunk" })
				map("n", "<Leader>Gr", gs.reset_hunk, { desc = "GitResetHunk" })
				map("v", "<Leader>Gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "GitStageHunk" })
				map("v", "<Leader>Gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "GitResetHunk" })
				map("n", "<Leader>GS", gs.stage_buffer, { desc = "GitStageBuffer" })
				map("n", "<Leader>Gu", gs.undo_stage_hunk, { desc = "GitUndoStageHunk" })
				map("n", "<Leader>GR", gs.reset_buffer, { desc = "GitResetBuffer" })
				map("n", "<Leader>GP", gs.preview_hunk, { desc = "GitPreviewHunk" })
				map("n", "<Leader>Gb", function()
					gs.blame_line({ full = true })
				end, { desc = "GitBlameLine" })
				map("n", "<Leader>Gd", gs.diffthis, { desc = "GitDiffThis" })
				map("n", "<Leader>GD", function()
					gs.diffthis("~")
				end, { desc = "GitDiffThis" })
				map("n", "<Leader>Gt", gs.toggle_deleted, { desc = "GitToggleDeleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSelectHunk" })
			end,
		},
	},

	{
		"rhysd/conflict-marker.vim",
		lazy = true,
		event = "VeryLazy",
	},
}
