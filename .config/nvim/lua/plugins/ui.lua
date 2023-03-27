return {
  -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- So for api plugins like devicons, we can always set lazy=true
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  {
    'nvim-tree/nvim-tree.lua',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
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
    event = "VeryLazy",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
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
    "utilyre/barbecue.nvim", version = "*",
    event = { "BufReadPost", "BufNewFile" },
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
    },
  },
}
