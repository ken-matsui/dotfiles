-- Load Vim configuration
vim.cmd("set runtimepath^=~/.config/vim runtimepath+=~/.config/vim/after")
vim.o.packpath = vim.o.runtimepath
vim.cmd("source ~/.config/vim/vimrc")

-- Enable fast cache loading
if vim.loader then
	vim.loader.enable()
end

-- Disable netrw at the very start of init.lua (nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

-- Tmux integration (tmux-window-name)
local uv = vim.loop
vim.api.nvim_create_autocmd({ "VimEnter", "VimLeave" }, {
	callback = function()
		if vim.env.TMUX_WINDOW_NAME_SCRIPT then
			uv.spawn(vim.env.TMUX_WINDOW_NAME_SCRIPT, {})
		end
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})

-- Must be written at the last.  see :help 'secure'.
vim.opt.secure = true
