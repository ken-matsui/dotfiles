-- Enable fast cache loading
vim.loader.enable()

-- Set file encoding as UTF-8
vim.opt.encoding = 'utf-8'
-- Enable true color
vim.opt.termguicolors = true

-- Disable netrw at the very start of init.lua (nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Don't create backup
vim.opt.backup = false
vim.opt.writebackup = false

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = 'yes'

-- Show relative column number
vim.opt.number = true
vim.opt.relativenumber = true

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

-- Save files when focus lost
vim.cmd [[ autocmd FocusLost * silent! wa ]]

-- Recognize .def files as C++
vim.cmd [[ autocmd BufNewFile,BufRead *.def set syntax=cpp ]]

-- Change background color when focus lost
vim.cmd [[ autocmd FocusLost * hi Normal guibg=#1A1C29 ]] -- material deep ocean bg + brightness
vim.cmd [[ autocmd FocusGained * hi Normal guibg=#0F111A ]] -- material deep ocean bg
