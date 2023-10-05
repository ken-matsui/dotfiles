return {
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

  -- Syntax Highlight
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        "bash",
        "dockerfile",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "python",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },

      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },

  -- C/C++ Syntax Highlight
  {
    'bfrg/vim-cpp-modern',
    event = { "BufReadPost", "BufNewFile" },
    config = function ()
      -- Enable highlighting of C++11 attributes
      vim.g.cpp_attributes_highlight = 1

      -- Highlight struct/class member variables (affects both C and C++ files)
      vim.g.cpp_member_highlight = 1
    end
  },

  -- Highlight arguments
  {
    'm-demare/hlargs.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },
}
