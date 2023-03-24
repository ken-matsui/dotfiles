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
  use { "wbthomason/packer.nvim" }

  -- Themes
  use 'nvim-tree/nvim-web-devicons'
  use {
    'akinsho/bufferline.nvim', tag = "v3.*",
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
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
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
      vim.api.nvim_create_autocmd({"VimEnter"}, {
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

  -- Utils
  use 'github/copilot.vim' -- :Copilot setup
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        -- GitLens-like blame line
        current_line_blame = true,
      })
    end
  }
  use {
    'nathanaelkane/vim-indent-guides',
    config = function()
      vim.g.indent_guides_enable_on_vim_startup = true
    end
  }
  use 'jiangmiao/auto-pairs'
  use 'cappyzawa/trim.nvim'
  use {
    'akinsho/toggleterm.nvim', tag = '*',
    config = function()
      require('toggleterm').setup()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
