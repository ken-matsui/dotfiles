--
-- Global
--
vim.g.mapleader = ' ' -- Set <Leader> as the space key
-- local all_modes = {'n', 'i', 'v', 'c', 'o'}
-- vim.keymap.set(all_modes, '', '')

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
vim.keymap.set('n', '<S-]>', '>>_') -- indent
vim.keymap.set('n', '<S-[>', '<<_') -- unindent

-- Paste as matched with current indent
vim.keymap.set('n', 'p', ']p')
vim.keymap.set('n', 'P', ']P')

-- Save changes
vim.keymap.set('n', '<S-w>', '<Cmd>write<Cr>')
-- Quit the current window
vim.keymap.set('n', '<S-q>', '<Cmd>quit<Cr>')
-- Exit (same as :x, :wq)
vim.keymap.set('n', '<S-x>', '<Cmd>exit<Cr>')

-- Nvim Tree
vim.keymap.set('n', '<S-f>', '<Cmd>NvimTreeFocus<Cr>')

-- Toggle Term
vim.keymap.set('n', '<S-t>', '<Cmd>ToggleTerm<Cr>')

--
-- Insert Mode
--

-- Escape by jj & kk
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'kk', '<Esc>')

--
-- Visual Mode
--

vim.keymap.set('v', '<S-]>', '>gv') -- indent
vim.keymap.set('v', '<S-[>', '<gv') -- unindent
