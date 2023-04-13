return {
  {
    'github/copilot.vim', -- :Copilot setup
    event = "VeryLazy",
  },

  {
    'numToStr/Comment.nvim',
    lazy = true,
    keys = {
      { '<leader>c', 'gcc', 'n', remap = true },
      -- Ctrl + / => comment
      { '<C-_>', 'gcc', 'n', remap = true },
      { '<C-/>', 'gcc', 'v', remap = true },
    },
    config = true,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- GitLens-like blame line
      current_line_blame = true,
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetype_exclude = {
        "help",
        "nvim-tree",
        "lazy",
      },
      char = "",
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
      },
      space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
      },
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
    config = function(_, opts)
      vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

      require("indent_blankline").setup(opts)
    end
  },

  {
    'jiangmiao/auto-pairs',
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    'cappyzawa/trim.nvim',
    event = "VeryLazy",
  },
}
