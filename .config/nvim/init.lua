-- Use plain vim
-- when vim was invoked by 'sudo' command
-- or, invoked as 'git difftool'
if vim.fn.exists('$SUDO_USER') == 1 or vim.fn.exists('$GIT_DIR') == 1 then
  return
end

require('options')

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
require("lazy").setup("plugins")

require('keymaps')

-- Must be written at the last.  see :help 'secure'.
vim.opt.secure = true
