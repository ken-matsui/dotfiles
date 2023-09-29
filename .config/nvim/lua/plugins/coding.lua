return {
  {
    'github/copilot.vim', -- :Copilot setup
    event = "VeryLazy",
  },

  {
    'numToStr/Comment.nvim',
    lazy = true,
    keys = {
      { '<leader>c', 'gcc', 'n', remap = true },
      -- Ctrl + / => comment
      { '<C-_>', 'gcc', 'n', remap = true },
      { '<C-/>', 'gcc', 'v', remap = true },
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
    config = function ()
      vim.g.bookmark_save_per_working_dir = 1
    end
  },
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MattesGroeger/vim-bookmarks",
    },
    keys = {
      { '<Leader>vb', '<Cmd>Telescope vim_bookmarks all<Cr>', 'n' },
    },
    opts = function ()
      require('telescope').load_extension('vim_bookmarks')
    end
  },

  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = {"~/", "~/Downloads", "/"},
      }
    end
  },

  {
    'ludovicchabant/vim-gutentags',
    config = function ()
      vim.g.gutentags_cache_dir = vim.fn.stdpath("data") .. '/ctags'
    end
  },

  {
    'RRethy/vim-illuminate',
    event = { "BufReadPost", "BufNewFile" },
    config = function ()
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
