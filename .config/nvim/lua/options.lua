-- Set file encoding as UTF-8
vim.opt.encoding = 'utf-8'

-- Don't create backup
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = 'yes'

-- Show column number
vim.opt.number = true

-- Highlight column number
vim.opt.cursorline = true

-- Visualize invisible string
vim.opt.list = true
-- vim.opt.listchars:append 'space:⋅'
vim.opt.listchars = {
  eol = '$',
  tab = '>-',
  trail = '~',
  extends = '>',
  precedes = '<',
}

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
if vim.fn.has('unnamedplus') == 1 then
  vim.opt.clipboard = 'unnamedplus'
else
  vim.opt.clipboard = 'unnamed'
end

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
