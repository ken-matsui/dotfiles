return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = "BufReadPre",
    opts = {
      -- GitLens-like blame line
      current_line_blame = true,
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr=true, desc='GitNextHunk' })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr=true, desc='GitPrevHunk' })

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk, { desc = 'GitStageHunk' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = 'GitResetHunk' })
        map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'GitStageHunk' })
        map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'GitResetHunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'GitStageBuffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'GitUndoStageHunk' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'GitResetBuffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'GitPreviewHunk' })
        map('n', '<leader>gb', function() gs.blame_line{full=true} end, { desc = 'GitBlameLine' })
        map('n', '<leader>gd', gs.diffthis, { desc = 'GitDiffThis' })
        map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = 'GitDiffThis' })
        map('n', '<leader>gt', gs.toggle_deleted, { desc = 'GitToggleDeleted' })

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'GitSelectHunk' })
      end,
    },
  },

  {
    'rhysd/conflict-marker.vim',
    lazy = true,
    event = "VeryLazy",
  },
}
