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

-- Ctags
vim.keymap.set('n', '<C-g>', '<C-]>', {noremap = true}) -- goto
vim.keymap.set('n', '<C-b>', '<C-t>', {noremap = true}) -- back

-- Indent
vim.keymap.set('n', '<Leader>]', '>>', {noremap = true, silent = true}) -- indent
vim.keymap.set('n', '<Leader>[', '<<', {noremap = true, silent = true}) -- unindent

-- Paste as matched with current indent
vim.keymap.set('n', 'p', ']p')
vim.keymap.set('n', 'P', ']P')

--
-- Insert Mode
--

-- Escape by jj & kk
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'kk', '<Esc>')

--
-- Visual Mode
--

vim.keymap.set('v', '<Leader>]', '>gv', {noremap = true, silent = true}) -- indent
vim.keymap.set('v', '<Leader>[', '<gv', {noremap = true, silent = true}) -- unindent
