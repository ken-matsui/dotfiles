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
      view = {
        width = 25,
      },
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
    'akinsho/bufferline.nvim', version = "v3.*",
    event = "VeryLazy",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
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
    "utilyre/barbecue.nvim",
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
    opts = {
      handlers = {
        gitsigns = true,
      },
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "ray-x/cmp-treesitter",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip", version = "1.*",
        config = function()
          require("luasnip.loaders.from_vscode").load()
        end,
      },
      "onsails/lspkind-nvim",
    },
    opts = function()
      local cmp = require("cmp")

      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })

      return {
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Esc>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          }),
        }),
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "treesitter" },
        }),
        formatting = {
          format = require('lspkind').cmp_format({}),
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
    },
    keys = {
      { '<Leader>f', '<Cmd>Telescope live_grep<Cr>', 'n' },
    },
    opts = {
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
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    lazy = true,
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
}
