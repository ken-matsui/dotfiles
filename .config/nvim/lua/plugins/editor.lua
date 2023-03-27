return {
  -- Syntax Highlight
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      'windwp/nvim-ts-autotag',
      'p00f/nvim-ts-rainbow'
    },
    build = ':TSUpdate',
    opts = {
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
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = true,
      },
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      ensure_installed = {
        "asm_lsp",
        "bashls",
        "clangd",
        "cmake",
        "neocmake",
        "cssls",
        "cssmodules_ls",
        "unocss",
        "denols",
        "diagnosticls",
        "dockerls",
        "docker_compose_language_service",
        "dotls",
        "efm",
        "grammarly",
        "html",
        "jsonls",
        "jdtls",
        "quick_lint_js",
        "tsserver",
        "vtsls",
        "ltex",
        "texlab",
        "lua_ls",
        "marksman",
        "prosemd_lsp",
        "remark_ls",
        "zk",
        "jedi_language_server",
        "pyre",
        "pyright",
        "sourcery",
        "pylsp",
        "ruff_lsp",
        "rome",
        "sqlls",
        "sqls",
        "taplo",
        "tsserver",
        "vtsls",
        "yamlls",
      },
    },
    config = function(_, opts)
      -- Automatically install servers listed in opts.ensure_installed
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "nvim-tree/nvim-web-devicons",
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
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
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
