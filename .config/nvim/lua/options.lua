-- Enable fast cache loading
vim.loader.enable()

-- Set file encoding as UTF-8
vim.opt.encoding = 'utf-8'

-- Disable netrw at the very start of init.lua (nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Don't create backup
vim.opt.backup = false
vim.opt.writebackup = false

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = 'yes'

-- Show column number
vim.opt.number = true

-- Highlight column number
vim.opt.cursorline = true

-- Visualize invisible string
vim.opt.list = true
vim.opt.listchars = {
  eol = '$',
  tab = '>-',
  trail = '~',
  extends = '>',
  precedes = '<',
}

-- Indentation
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.softtabstop = 0

-- Always display statusline.
vim.opt.laststatus = 2

-- Enable true color
vim.opt.termguicolors = true

-- Yank texts to system clipboard
if vim.fn.has('unnamedplus') == 1 then
  vim.opt.clipboard = 'unnamedplus'
else
  vim.opt.clipboard = 'unnamed'
end

-- Set <Leader> as the space key
vim.g.mapleader = ' '

-- Load ctags if exists
vim.o.tags = "./tags;"

-- Highlight yanked region
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {timeout = 500}
  end
})

-- Return to last edit position when opening files
vim.cmd([[
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
]])

-- Recognize .def files as C++
vim.cmd [[ autocmd BufNewFile,BufRead *.def set syntax=cpp ]]
