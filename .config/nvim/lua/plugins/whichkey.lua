-- Load which-key.nvim at last

return {
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    config = true,
  },
}
