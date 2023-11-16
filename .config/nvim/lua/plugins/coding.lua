return {
  {
    'github/copilot.vim', -- :Copilot setup
    lazy = true,
    event = 'VeryLazy',
    config = function ()
      vim.g.copilot_filetypes = {
        NvimTree = false,
      }
    end
  },

  {
    'jackMort/ChatGPT.nvim',
    lazy = true,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim'
    },
    keys = {
      { '<Leader>cc', '<Cmd>ChatGPT<Cr>', 'n', desc = 'ChatGPT' },
      { '<Leader>ce', '<Cmd>ChatGPTEditWithInstruction<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTEditWithInstruction' },
      { '<Leader>cg', '<Cmd>ChatGPTRun grammar_correction<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun grammar_correction' },
      { '<Leader>ct', '<Cmd>ChatGPTRun translate<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun translate' },
      { '<Leader>ck', '<Cmd>ChatGPTRun keywords<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun keywords' },
      { '<Leader>cd', '<Cmd>ChatGPTRun docstring<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun docstring' },
      { '<Leader>ca', '<Cmd>ChatGPTRun add_tests<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun add_tests' },
      { '<Leader>co', '<Cmd>ChatGPTRun optimize_code<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun optimize_code' },
      { '<Leader>cs', '<Cmd>ChatGPTRun summarize<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun summarize' },
      { '<Leader>cf', '<Cmd>ChatGPTRun fix_bugs<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun fix_bugs' },
      { '<Leader>cx', '<Cmd>ChatGPTRun explain_code<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun explain_code' },
      { '<Leader>cr', '<Cmd>ChatGPTRun code_readability_analysis<Cr>', mode = { 'n', 'v' }, desc = 'ChatGPTRun code_readability_analysis' },
    },
    config = function()
      require('chatgpt').setup({
        api_key_cmd = 'op read -n op://Personal/OpenAI/credential'
      })
    end,
  },

  {
    'numToStr/Comment.nvim',
    lazy = true,
    config = true,
  },

  {
    'cappyzawa/trim.nvim', version = 'v0.8.*',
    lazy = true,
    event = 'VeryLazy',
  },

  {
    'vim-scripts/ReplaceWithRegister',
    lazy = true,
    event = 'VeryLazy',
  },

  {
    'MattesGroeger/vim-bookmarks',
    lazy = true,
    event = 'BufRead',
    init = function ()
      vim.g.bookmark_save_per_working_dir = 1
    end,
  },

  {
    'rmagatti/auto-session',
    opts = {
      log_level = 'error',
      auto_session_suppress_dirs = {'~/', '~/Downloads', '/'},
      auto_save_enabled = true,
    },
  },

  {
    'ludovicchabant/vim-gutentags',
    config = function ()
      vim.g.gutentags_cache_dir = vim.fn.stdpath('data')
    end
  },

  {
    'rust-lang/rust.vim',
    lazy = true,
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
