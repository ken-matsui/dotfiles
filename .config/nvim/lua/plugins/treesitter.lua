return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'windwp/nvim-ts-autotag',
      'p00f/nvim-ts-rainbow'
    },
    event = { "BufReadPost", "BufNewFile" },
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
}
