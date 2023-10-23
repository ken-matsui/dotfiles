return {
  {
    'github/copilot.vim', -- :Copilot setup
    event = "InsertEnter",
    config = function ()
      vim.g.copilot_filetypes = {
        NvimTree = false,
      }
    end
  },

  {
    'numToStr/Comment.nvim',
    lazy = true,
    config = true,
  },

  --
  -- Git
  --
  {
    'lewis6991/gitsigns.nvim',
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
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})
      end,
    },
  },
  {
    'rhysd/conflict-marker.vim',
    event = "VeryLazy",
  },

  {
    'cappyzawa/trim.nvim',
    tag = "v0.8.1",
    event = "VeryLazy",
  },

  {
    'rstacruz/vim-closer',
    event = "InsertEnter",
  },
  {
    'tpope/vim-endwise',
    event = "InsertEnter",
  },
  {
    'tpope/vim-surround',
    event = "VeryLazy",
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    'vim-scripts/ReplaceWithRegister',
    event = "VeryLazy",
  },

  {
    "MattesGroeger/vim-bookmarks",
    event = 'BufRead',
    init = function ()
      vim.g.bookmark_save_per_working_dir = 1
    end,
  },

  {
    'rmagatti/auto-session',
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = {"~/", "~/Downloads", "/"},
      auto_save_enabled = true,
    },
  },

  {
    'ludovicchabant/vim-gutentags',
    config = function ()
      vim.g.gutentags_cache_dir = vim.fn.stdpath("data")
    end
  },

  {
    'mg979/vim-visual-multi',
    event = "VeryLazy",
  },

  'dkarter/bullets.vim',

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
