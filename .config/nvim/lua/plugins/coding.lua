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

  {
    'lewis6991/gitsigns.nvim',
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
  'rhysd/conflict-marker.vim',

  {
    "lukas-reineke/indent-blankline.nvim",
    tag = "v3.3.2",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IBLYellow", { fg = "#E5C07B" })
      end)

      local highlight = {
        "CursorColumn",
        "Whitespace",
      }

      require("ibl").setup({
        exclude = {
          filetypes = {
            "nvim-tree",
            "lazy",
          },
        },
        indent = {
          highlight = highlight,
          char = "▏",
        },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
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
    end
  },

  {
    'cappyzawa/trim.nvim',
    tag = "v0.8.1",
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
      vim.g.gutentags_cache_dir = vim.fn.stdpath("data")
    end
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

  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
