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
      { '<Leader>s', '<Cmd>NvimTreeToggle<Cr>', 'n' },
    },
    opts = {
      sort_by = "case_sensitive",
      view = {
        width = 25,
      },
      diagnostics = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)

      -- Auto close
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd "quit"
          end
        end
      })
    end,
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
    "utilyre/barbecue.nvim", version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      show_dirname = false,
      show_basename = false,
    },
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

  {
    'akinsho/toggleterm.nvim', version = '*',
    lazy = true,
    keys = {
      { '<C-t>', '<Cmd>ToggleTerm<Cr>', 'n' },
    },
    config = true,
  },

  {
    'nvim-telescope/telescope.nvim', version = '0.1.3',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      -- like Cmd + Shift + o on IntelliJ
      { '<C-o>', '<Cmd>Telescope find_files<Cr>', 'n' },
      -- like Cmd + Shift + f on IntelliJ
      { '<C-f>', '<Cmd>Telescope live_grep<Cr>', 'n' },
    },
  },
}
