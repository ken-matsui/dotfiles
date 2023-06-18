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
          vim.api.nvim_create_autocmd({ "BufWritePost", "FocusGained" }, {
            callback = function()
              vim.cmd "TSDisable rainbow"
              vim.cmd "TSEnable rainbow"
            end,
          })
        end,
      },
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
        "asm_lsp", -- Assembly (GAS/NASM, GO)
        "bashls", -- Bash
        "clangd", -- C, C++
        "cmake", -- CMake
        "cssls", -- CSS
        "cssmodules_ls", -- CSS Modules
        "denols", -- Deno
        "diagnosticls", -- Diagnostic (general purpose server)
        "dockerls", -- Dockerfile
        "docker_compose_language_service", -- Docker Compose
        "dotls", -- Graphviz
        "efm", -- EFM (general purpose server)
        "gopls", -- Go
        "grammarly", -- Grammarly
        "graphql", -- GraphQL
        "html", -- HTML
        "jsonls", -- JSON
        "jdtls", -- Java
        "texlab", -- LaTeX
        "lua_ls", -- Lua
        "marksman", -- Markdown
        -- "nil_ls", -- Nix
        "pyright", -- Python
        "rome", -- Rome
        "rust_analyzer", -- Rust
        "sqlls", -- SQL
        "taplo", -- TOML
        "tsserver", -- JavaScript, TypeScript
        "typst_lsp", -- Typst
        "yamlls", -- YAML
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
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          }),
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
