return {
  {
    'github/copilot.vim', -- :Copilot setup
    event = "VeryLazy",
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
  'airblade/vim-gitgutter',
  'rhysd/conflict-marker.vim',
  {
    'APZelos/blamer.nvim',
    init = function ()
      vim.g.blamer_enabled = 1
    end,
  },

  {
    'cappyzawa/trim.nvim',
    tag = "v0.8.1",
    event = "VeryLazy",
  },

  'rstacruz/vim-closer',
  'tpope/vim-endwise',
  'tpope/vim-surround',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'vim-scripts/ReplaceWithRegister',

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
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
