return {
  -- Syntax Highlight
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      {
        "HiPhish/nvim-ts-rainbow2",
        config = function()
          -- HACK: https://github.com/p00f/nvim-ts-rainbow/issues/112#issuecomment-1310835936
          vim.cmd "autocmd BufNewFile,BufReadPost * TSDisable rainbow | TSEnable rainbow | TSDisable rainbow | TSEnable rainbow | TSDisable rainbow | TSEnable rainbow"
          vim.cmd "autocmd BufWritePost * TSDisable rainbow | TSEnable rainbow"
        end,
      },
    },
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        "bash",
        "dockerfile",
        "html",
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
      rainbow = {
        enable = true,
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
  'bfrg/vim-cpp-modern',

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
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
        }),
        formatting = {
          format = require('lspkind').cmp_format({}),
        },
      }
    end,
  },
}
