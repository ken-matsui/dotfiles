return {
  {
    'github/copilot.vim', -- :Copilot setup
    lazy = true,
    event = 'VeryLazy',
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

  {
    'cappyzawa/trim.nvim', version = 'v0.8.*',
    lazy = true,
    event = 'VeryLazy',
  },

  {
    'vim-scripts/ReplaceWithRegister',
    lazy = true,
    event = 'VeryLazy',
  },

  {
    'MattesGroeger/vim-bookmarks',
    lazy = true,
    event = 'BufRead',
    init = function ()
      vim.g.bookmark_save_per_working_dir = 1
    end,
  },

  {
    'rmagatti/auto-session',
    opts = {
      log_level = 'error',
      auto_session_suppress_dirs = {'~/', '~/Downloads', '/'},
      auto_save_enabled = true,
    },
  },

  {
    'ludovicchabant/vim-gutentags',
    config = function ()
      vim.g.gutentags_cache_dir = vim.fn.stdpath('data')
    end
  },

  {
    'google/vim-glaive',
    dependencies = {
      'google/vim-maktaba',
      'google/vim-codefmt',
    },
    lazy = true,
    ft = {
      'python',
      'rust',
      'java',
    },
    config = function()
      vim.cmd('call glaive#Install()')
      vim.cmd([[
        augroup autoformat_settings
          autocmd FileType python AutoFormatBuffer black
          autocmd FileType rust AutoFormatBuffer rustfmt
          autocmd FileType java AutoFormatBuffer google-java-format
        augroup END
      ]])
    end,
  },
}
