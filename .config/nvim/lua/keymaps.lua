--
-- Global
--
local all_modes = {'n', 'i', 'v', 'c', 'o'}

-- Set <Leader> as the space key
vim.g.mapleader = ' '

-- Escape by Ctrl e
vim.keymap.set(all_modes, '<C-e>', '<Esc>')

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

-- Nvim Tree
vim.keymap.set('n', '<C-f>', '<Cmd>NvimTreeFocus<Cr>')

-- Toggle Term
vim.keymap.set('n', '<C-t>', '<Cmd>ToggleTerm<Cr>')

-- Comment.nvim - Ctrl + / => comment
vim.keymap.set('n', '<C-_>', 'gcc', {remap = true})

-- Telescope (Ctrl + o like Cmd + Shift + o in IntelliJ)
vim.keymap.set('n', '<C-o>', require('telescope.builtin').find_files)

--
-- Insert Mode
--

-- Escape by jj & kk
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'kk', '<Esc>')

--
-- Visual Mode
--

vim.keymap.set('v', '<C-]>', '>gv') -- indent
vim.keymap.set('v', '<C-[>', '<gv') -- unindent

-- Comment.nvim - Ctrl + / => comment
vim.keymap.set('v', '<C-/>', 'gcc', {remap = true})
