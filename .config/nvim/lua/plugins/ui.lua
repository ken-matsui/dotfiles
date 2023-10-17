return {
  -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- So for api plugins like devicons, we can always set lazy=true
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<Leader>s', '<Cmd>NvimTreeFindFileToggle<Cr>', 'n' },
    },
    opts = {
      sort_by = "case_sensitive",
      diagnostics = {
        enable = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    },
  },

  {
    'akinsho/bufferline.nvim', version = "v4.*",
    event = "VeryLazy",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<Leader>h', '<Cmd>BufferLineCyclePrev<Cr>', 'n' },
      { '<Leader>l', '<Cmd>BufferLineCycleNext<Cr>', 'n' },
      { '<Leader>1', '<Cmd>BufferLineGoToBuffer 1<Cr>', 'n' },
      { '<Leader>2', '<Cmd>BufferLineGoToBuffer 2<Cr>', 'n' },
      { '<Leader>3', '<Cmd>BufferLineGoToBuffer 3<Cr>', 'n' },
      { '<Leader>4', '<Cmd>BufferLineGoToBuffer 4<Cr>', 'n' },
      { '<Leader>5', '<Cmd>BufferLineGoToBuffer 5<Cr>', 'n' },
      { '<Leader>6', '<Cmd>BufferLineGoToBuffer 6<Cr>', 'n' },
      { '<Leader>7', '<Cmd>BufferLineGoToBuffer 7<Cr>', 'n' },
      { '<Leader>8', '<Cmd>BufferLineGoToBuffer 8<Cr>', 'n' },
      { '<Leader>9', '<Cmd>BufferLineGoToBuffer 9<Cr>', 'n' },
      { '<Leader><Left>', '<Cmd>BufferLineMovePrev<Cr>', 'n' },
      { '<Leader><Right>', '<Cmd>BufferLineMoveNext<Cr>', 'n' },
    },
    opts = {
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
      },
    },
  },

  {
    "utilyre/barbecue.nvim", version = "v1.2.0",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },

  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        theme = 'material',
      },
      extensions = {
        'nvim-tree',
        'toggleterm',
      },
    },
  },

  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = true,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "ray-x/cmp-treesitter",
      "onsails/lspkind-nvim",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<Esc>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          }),
        }),
        sources = cmp.config.sources({
          { name = "buffer" },
          { name = "path" },
          { name = "treesitter" },
        }),
        formatting = {
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
          }),
        },
      }
    end,
  },

  {
    'nvim-telescope/telescope.nvim', version = '0.1.3',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      "tom-anders/telescope-vim-bookmarks.nvim",
      "debugloop/telescope-undo.nvim",
    },
    keys = {
      { '<Leader>f', '<Cmd>Telescope live_grep<Cr>', 'n' },
      { '<Leader>b', '<Cmd>Telescope vim_bookmarks all<Cr>', 'n' },
      { '<Leader>u', '<Cmd>Telescope undo<Cr>', 'n' },
    },
    opts = {
      defaults = {
        file_ignore_patterns = {".git"},
      },
      pickers = {
        live_grep = {
          additional_args = function (opts)
            return {"--hidden"}
          end
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        },
      }
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('vim_bookmarks')
      require('telescope').load_extension('undo')
    end,
  },
  {
    'prochri/telescope-all-recent.nvim',
    lazy = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      "kkharji/sqlite.lua"
    },
    keys = {
      { '<Leader>o', function() require('telescope.builtin').find_files() end, 'n' },
    },
    config = true,
  },
}
