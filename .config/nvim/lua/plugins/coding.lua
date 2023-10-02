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
    keys = {
      { '<leader>c', 'gcc', 'n', remap = true },
    },
    config = true,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
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
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    tag = "v2.20.8",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetype_exclude = {
        "help",
        "nvim-tree",
        "lazy",
      },
      char = "",
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
      },
      space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
      },
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
    config = function(_, opts)
      vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

      require("indent_blankline").setup(opts)
    end
  },

  {
    'jiangmiao/auto-pairs',
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    'cappyzawa/trim.nvim',
    event = "VeryLazy",
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

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
      vim.g.gutentags_cache_dir = vim.fn.stdpath("data") .. '/ctags'
    end
  },

  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    opts = {},
  },
  {
    'mrjones2014/legendary.nvim',
    version = 'v2.1.0',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    dependencies = { 'kkharji/sqlite.lua' },
    keys = {
      { '<leader>p', '<Cmd>Legendary<Cr>', 'n', remap = true },
    },
    opts = {
      lazy_nvim = {
        auto_register = true,
      },
    },
  },

  {
    'mg979/vim-visual-multi',
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    'RRethy/vim-illuminate',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes_denylist = {
        'NvimTree',
      },
    },
    config = function (_, opts)
      require('illuminate').configure(opts)

      local highlight = '#354A51' -- material oceanic highlight
      vim.api.nvim_set_hl(0, 'IlluminatedWordText', {
        bg = highlight,
      })
      vim.api.nvim_set_hl(0, 'IlluminatedWordRead', {
        bg = highlight,
      })
      vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', {
        bg = highlight,
      })
    end
  },
}
