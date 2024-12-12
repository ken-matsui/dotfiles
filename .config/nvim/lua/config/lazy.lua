-- Bootstrap lazy.nvim
local config_home = os.getenv("XDG_CONFIG_HOME") or "~/.config"
local lazy_home = config_home .. "/nvim/lazy"

local lazypath = lazy_home .. "/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local function disable_plugins_for_large_files()
	local max_filesize = 1024 * 1024 -- 1 MB
	local filepath = vim.fn.expand("%:p")
	local filesize = vim.fn.getfsize(filepath)
	if filesize > max_filesize then
		-- Disable treesitter
		vim.cmd("TSBufDisable")
	end
end

-- Autocmd to check file size on BufRead
vim.api.nvim_create_autocmd("BufRead", {
	callback = disable_plugins_for_large_files,
	desc = "Disable heavy plugins for large files",
})

require("lazy").setup({
	root = lazy_home,
	spec = {
		{ import = "plugins" },
	},
	change_detection = {
		notify = false,
	},
})
