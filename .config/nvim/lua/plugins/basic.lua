return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'dkarter/bullets.vim',

  {
    'rstacruz/vim-closer',
    event = 'InsertEnter',
  },

  {
    'tpope/vim-endwise',
    event = 'InsertEnter',
  },

  {
    'tpope/vim-abolish',
    event = 'VeryLazy',
  },

  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },

  {
    'machakann/vim-sandwich',
    event = 'VeryLazy',
  },

  {
    'mg979/vim-visual-multi',
    event = "VeryLazy",
  },
}
