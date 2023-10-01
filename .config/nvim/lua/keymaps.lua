--
-- Normal Mode
--

-- Treat ; as :
vim.keymap.set('n', ';', ':')

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
vim.keymap.set('n', '<Leader>]', '>>') -- indent
vim.keymap.set('n', '<Leader>[', '<<') -- unindent

-- Paste as matched with current indent
vim.keymap.set('n', 'p', ']p')
vim.keymap.set('n', 'P', ']P')

-- Buffer navigation
vim.keymap.set('n', '<Leader>h', '<Cmd>bprev<Cr>')
vim.keymap.set('n', '<Leader>l', '<Cmd>bnext<Cr>')
vim.keymap.set('n', '<Leader>w', '<Cmd>bdelete<Cr>')

--
-- Insert Mode
--

-- Escape by jj & kk
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'kk', '<Esc>')

--
-- Visual Mode
--

vim.keymap.set('v', '<Tab>', '>gv') -- indent
vim.keymap.set('v', '<S-Tab>', '<gv') -- unindent
