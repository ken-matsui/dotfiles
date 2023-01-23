-- Bootstrap Packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Automatically run :PackerCompile
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Specify plugins
return require('packer').startup(function(use)
  -- Themes
  use 'kyazdani42/nvim-web-devicons'
  use {
    'akinsho/bufferline.nvim', tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require("bufferline").setup() end
  }
  use {
    'SmiteshP/nvim-gps',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function() require('nvim-gps').setup() end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
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
            { gps.get_location, cond = gps.is_available },
          },
        },
      }
    end
  }
  use {
    'marko-cerovac/material.nvim',
    requires = 'nvim-lualine/lualine.nvim',
    config = function()
      vim.g.material_style = 'deep ocean'
      vim.cmd('colorscheme material')
    end
  }
  use {
    'sidebar-nvim/sidebar.nvim',
    config = function()
      require('sidebar-nvim').setup({
        open = true,
      })
    end
  }

  -- Syntax
  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
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
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter-context',
    requires = 'nvim-treesitter/nvim-treesitter'
  }
  use {
    'windwp/nvim-ts-autotag',
    requires = 'nvim-treesitter/nvim-treesitter'
  }
  use {
    'p00f/nvim-ts-rainbow',
    requires = 'nvim-treesitter/nvim-treesitter'
  }

  -- Completion
  use 'haorenW1025/completion-nvim'
  use {
    'nvim-treesitter/completion-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter',
      'haorenW1025/completion-nvim'
    },
    config = function()
      vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
    end
  }

  -- Utils
  use 'tpope/vim-commentary'
  use 'machakann/vim-highlightedyank'
  use 'jiangmiao/auto-pairs'
  use 'cappyzawa/trim.nvim'
  use 'github/copilot.vim'
  use {
    'bronson/vim-trailing-whitespace',
    config = function()
      vim.cmd('autocmd BufWritePre * :%s/\\s\\+$//e')
    end
  }
  use {
    'akinsho/toggleterm.nvim', tag = 'v1.*',
    config = function() require('toggleterm').setup() end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
