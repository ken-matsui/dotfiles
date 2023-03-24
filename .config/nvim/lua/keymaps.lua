--
-- Global
--
vim.g.mapleader = ' ' -- Set <Leader> as the space key
local all_modes = {'n', 'i', 'v', 'c', 'o'}

-- Ctrl-e to Esc
vim.keymap.set(all_modes, '<C-e>', '<Esc>')

--
-- Normal Mode
--

-- Visually move cursor
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Move to the beggining of line
vim.keymap.set('n', '<S-h>', '^')
-- Move to the beggining of file
vim.keymap.set('n', '<S-k>', 'gg')
-- Move to the end of line
vim.keymap.set('n', '<S-l>', '$')
-- Move to the end of file
vim.keymap.set('n', '<S-j>', '<S-g>')

-- Indent
vim.keymap.set('n', '<C-]>', '>>_') -- indent
vim.keymap.set('n', '<C-[>', '<<_') -- unindent

-- Paste as matched with current indent
vim.keymap.set('n', 'p', ']p')
vim.keymap.set('n', 'P', ']P')

-- Save changes
vim.keymap.set('n', '<C-w>', '<Cmd>write<Cr>')
-- Quit the current window
vim.keymap.set('n', '<C-q>', '<Cmd>quit<Cr>')
-- Exit (same as :x, :wq)
vim.keymap.set('n', '<C-x>', '<Cmd>exit<Cr>')

--
-- Visual Mode
--

vim.keymap.set('v', '<C-]>', '>gv') -- indent
vim.keymap.set('v', '<C-[>', '<gv') -- unindent
