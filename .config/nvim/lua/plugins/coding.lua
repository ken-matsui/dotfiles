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

  -- Highlight arguments
  {
    'm-demare/hlargs.nvim',
    config = true,
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  "MattesGroeger/vim-bookmarks",
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MattesGroeger/vim-bookmarks",
    },
    keys = {
      { '<Leader>b', '<Cmd>Telescope vim_bookmarks all<Cr>', 'n' },
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
        auto_save_enabled = true,
      }

      -- Workaround for NvimTree with auto-session
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'NvimTree' },
        callback = function(args)
          vim.api.nvim_create_autocmd('VimLeavePre', {
            callback = function()
              vim.api.nvim_buf_delete(args.buf, { force = true })
              return true
            end
          })
        end,
      })
    end
  },

  {
    'ludovicchabant/vim-gutentags',
    config = function ()
      vim.g.gutentags_cache_dir = vim.fn.stdpath("data") .. '/ctags'
    end
  },

  {
    'mrjones2014/legendary.nvim',
    version = 'v2.1.0',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    dependencies = { 'kkharji/sqlite.lua' }
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  'mg979/vim-visual-multi',

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
