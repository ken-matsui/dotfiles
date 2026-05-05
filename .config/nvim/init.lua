-- Enable fast cache loading first, before any require()
if vim.loader then
	vim.loader.enable()
end

-- Disable unused built-in plugins to shave startup time
for _, plugin in ipairs({
	"netrw",
	"netrwPlugin",
	"gzip",
	"tar",
	"tarPlugin",
	"zip",
	"zipPlugin",
	"tutor_mode_plugin",
	"2html_plugin",
	"man",
}) do
	vim.g["loaded_" .. plugin] = 1
end

-- Load shared Vim configuration from ~/.config/vim
local config_home = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
vim.opt.runtimepath:prepend(config_home .. "/vim")
vim.opt.runtimepath:append(config_home .. "/vim/after")
vim.o.packpath = vim.o.runtimepath
vim.cmd.source(config_home .. "/vim/vimrc")

-- Always show the signcolumn so diagnostics don't shift the text
vim.opt.signcolumn = "yes"

-- Highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		local hl = vim.hl or vim.highlight
		hl.on_yank({ timeout = 500 })
	end,
})

if vim.env.NVIM_NO_PLUGINS ~= "1" then
	require("config.lazy")
end

-- Must be written at the last.  see :help 'secure'.
vim.opt.secure = true
