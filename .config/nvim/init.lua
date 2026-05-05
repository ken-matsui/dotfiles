-- Enable fast cache loading first, before any require()
if vim.loader then
	vim.loader.enable()
end

-- Disable unused built-in plugins to shave startup time
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_man = 1

-- Load Vim configuration
local config_home = os.getenv("XDG_CONFIG_HOME") or "~/.config"
vim.cmd("set runtimepath^=" .. config_home .. "/vim runtimepath+=" .. config_home .. "/vim/after")
vim.o.packpath = vim.o.runtimepath
vim.cmd("source " .. config_home .. "/vim/vimrc")

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

-- Highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})

if os.getenv("NVIM_NO_PLUGINS") ~= "1" then
	require("config.lazy")
end

-- Must be written at the last.  see :help 'secure'.
vim.opt.secure = true
