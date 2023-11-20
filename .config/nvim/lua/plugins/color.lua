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
    lazy = true,
    event = 'BufReadPre',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'comment',
        'dockerfile',
        'html',
        'java',
        'javascript',
        'json',
        'llvm',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'rust',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'yaml',
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
    lazy = true,
    ft = { 'c', 'cpp' },
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
    lazy = true,
    event = 'BufReadPre',
    config = true,
  },

  -- Indentation
  {
    'lukas-reineke/indent-blankline.nvim', version = 'v3.*',
    lazy = true,
    event = 'BufReadPost',
    config = function()
      local hooks = require('ibl.hooks')
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'IBLYellow', { fg = '#E5C07B' })
      end)

      require('ibl').setup({
        exclude = {
          filetypes = {
            'nvim-tree',
            'lazy',
          },
        },
        indent = {
          char = '▏',
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          highlight = {
            'IBLYellow',
          },
        },
      })
    end
  },

  -- Highlight the same word
  {
    'RRethy/vim-illuminate',
    lazy = true,
    event = 'BufReadPost',
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

  -- Dim inactive window
  {
    'sunjon/Shade.nvim',
    lazy = true,
    event = 'VeryLazy',
    opts = {
      overlay_opacity = 50,
      opacity_step = 1,
    },
  },
}
