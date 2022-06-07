-- File encoding
vim.opt.encoding = 'utf-8'

-- Don't create backup
vim.cmd('set nowritebackup')
vim.cmd('set nobackup')
vim.cmd('set noswapfile')
vim.opt.backupdir = vim.opt.backupdir - '.'

-- Show column number
vim.opt.number = true

-- Highlight column number
vim.opt.cursorline = true
vim.cmd('hi clear CursorLine')

-- Visualize invisible string
vim.opt.list = true
vim.opt.listchars = 'eol:$,tab:>-,trail:~,extends:>,precedes:<'

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- Exchange tab to spaces.
vim.opt.expandtab = true
vim.opt.softtabstop = 0

-- Always display statusline.
vim.opt.laststatus = 2

-- Enable true color
if vim.fn.exists('+termguicolors') == 1 then
  vim.opt.termguicolors = true
end
