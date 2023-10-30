return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'dkarter/bullets.vim',

  'farmergreg/vim-lastplace',

  {
    'rstacruz/vim-closer',
    lazy = true,
    event = 'InsertEnter',
  },

  {
    'tpope/vim-endwise',
    lazy = true,
    event = 'InsertEnter',
  },

  {
    'tpope/vim-abolish',
    lazy = true,
    event = 'VeryLazy',
  },

  {
    'tpope/vim-repeat',
    lazy = true,
    event = 'VeryLazy',
  },

  {
    'machakann/vim-sandwich',
    lazy = true,
    event = 'VeryLazy',
  },

  {
    'mg979/vim-visual-multi',
    lazy = true,
    event = "VeryLazy",
  },
}
