return {
  -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- So for api plugins like devicons, we can always set lazy=true
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      sort_by = "case_sensitive",
      view = {
        width = 25,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)

      -- Auto open
      local function open_nvim_tree(data)
        -- don't open nvim-tree when creating git commit message
        local IGNORED_FT = {
          "gitcommit",
        }
        -- &ft
        local filetype = vim.bo[data.buf].ft
        -- skip ignored filetypes
        if vim.tbl_contains(IGNORED_FT, filetype) then
          return
        end
        -- open the tree, find the file but don't focus it
        require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
      end
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = open_nvim_tree
      })

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
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = "VeryLazy",
    config = {
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
    'SmiteshP/nvim-gps',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    lazy = true,
    config = true,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'SmiteshP/nvim-gps',
    },
    event = "VeryLazy",
    config = function()
      local gps = require('nvim-gps')
      require('lualine').setup {
        options = {
          theme = 'material',
        },
        sections = {
          lualine_c = {
            {
              gps.get_location,
              cond = gps.is_available,
            },
          },
        },
      }
    end,
  },
}
