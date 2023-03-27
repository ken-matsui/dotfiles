return {
  -- Treesitter (Syntax Highlight)
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
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

  -- LSP (Language Server Protocol)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
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
      local mlsp = require("mason-lspconfig")
      mlsp.setup({ ensure_installed = opts.ensure_installed })
      mlsp.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = true,
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
          format = function(entry, vim_item)
            if vim.tbl_contains({ 'path' }, entry.source.name) then
              local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
          end,
        },
      }
    end,
  },
}
