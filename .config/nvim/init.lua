-- Load Vim configuration
local config_home = os.getenv("XDG_CONFIG_HOME") or "~/.config"
vim.cmd("set runtimepath^=" .. config_home .. "/vim runtimepath+=" .. config_home .. "/vim/after")
vim.o.packpath = vim.o.runtimepath
vim.cmd("source " .. config_home .. "/vim/vimrc")

-- Enable fast cache loading
if vim.loader then
	vim.loader.enable()
end

-- Disable netrw at the very start of init.lua (nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

-- Highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})

vim.api.nvim_create_user_command("CloseAll", function()
	vim.cmd("cclose") -- Close quickfix window
	vim.cmd("lclose") -- Close location list window

	-- Close NvimTree
	if package.loaded["nvim-tree"] then
		require("nvim-tree.api").tree.close()
	end

	-- Close Outline
	if package.loaded["outline"] then
		vim.cmd("OutlineClose")
	end

	-- Close all Trouble windows
	if package.loaded["trouble"] then
		local trouble = require("trouble")
		while trouble.is_open() do
			trouble.close()
		end
	end
end, { desc = "Close All Sub-windows" })
vim.api.nvim_set_keymap(
	"n",
	"<Leader>c",
	"<Cmd>CloseAll<CR>",
	{ silent = true, noremap = true, desc = "Close All Sub-windows" }
)

require("config.lazy")

-- Must be written at the last.  see :help 'secure'.
vim.opt.secure = true
