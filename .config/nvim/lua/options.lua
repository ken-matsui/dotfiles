-- File encoding
vim.opt.encoding = 'utf-8'

-- Don't create backup
vim.o.nowritebackup = true
vim.o.nobackup = true
vim.o.noswapfile = true
vim.opt.backupdir = vim.opt.backupdir - '.'

-- Show column number
vim.opt.number = true

-- Highlight column number
vim.opt.cursorline = true

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

-- Yank texts to system clipboard
if vim.fn.has('unnamedplus') then
  vim.opt.clipboard = 'unnamedplus'
else
  vim.opt.clipboard = 'unnamed'
end

-- Return to last edit position when opening files
vim.cmd([[
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
]])
