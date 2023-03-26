return {
  --
  -- Themes
  --

  -- the colorscheme should be available when starting Neovim
  {
    'marko-cerovac/material.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.g.material_style = 'deep ocean'
      vim.cmd.colorscheme('material')
    end,
  },

  -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- So for api plugins like devicons, we can always set lazy=true
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 25,
        },
      })

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
    config = function()
      require("bufferline").setup({
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
      })
    end,
  },

  {
    'SmiteshP/nvim-gps',
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = true,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'SmiteshP/nvim-gps',
    },
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

  --
  -- Syntax
  --

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all",
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        rainbow = {
          enable = true,
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'windwp/nvim-ts-autotag',
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'p00f/nvim-ts-rainbow',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },

  --
  -- Completion
  --

  -- use 'nvim-lua/completion-nvim'
  -- use {
    -- 'nvim-treesitter/completion-treesitter',
    -- requires = {
      -- 'nvim-treesitter/nvim-treesitter',
      -- 'haorenW1025/completion-nvim'
    -- },
    -- config = function()
      -- vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
    -- end
  -- }
  
  --
  -- Utils
  --

  'github/copilot.vim', -- :Copilot setup
  {
    'numToStr/Comment.nvim',
    lazy = true,
    keys = {
      -- Ctrl + / => comment
      { '<C-_>', 'gcc', 'n', remap = true },
      { '<C-/>', 'gcc', 'v', remap = true },
    },
    config = true,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        -- GitLens-like blame line
        current_line_blame = true,
      })
    end,
  },
  {
    'nathanaelkane/vim-indent-guides',
    config = function()
      vim.g.indent_guides_enable_on_vim_startup = true
    end,
  },
  'jiangmiao/auto-pairs',
  'cappyzawa/trim.nvim',
  {
    'akinsho/toggleterm.nvim', version = '*',
    lazy = true,
    keys = {
      { '<C-t>', '<Cmd>ToggleTerm<Cr>', 'n' },
    },
    config = true,
  },
  {
    'nvim-telescope/telescope.nvim', version = '0.1.1',
    lazy = true,
    keys = {
      -- like Cmd + Shift + o on IntelliJ
      { '<C-o>', '<Cmd>Telescope find_files<Cr>', 'n' },
      -- like Cmd + Shift + f on IntelliJ
      { '<C-f>', '<Cmd>Telescope live_grep<Cr>', 'n' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
