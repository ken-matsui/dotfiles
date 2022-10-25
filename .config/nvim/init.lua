-- Use plain vim
-- when vim was invoked by 'sudo' command
-- or, invoked as 'git difftool'
if vim.fn.exists('$SUDO_USER') == 1 or vim.fn.exists('$GIT_DIR') == 1 then
  return
end

require('mappings')
require('options')

-- require('plugins')
-- vim.cmd([[
  -- augroup packer_user_config
    -- autocmd!
    -- autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  -- augroup end
-- ]])

-- Must be written at the last.  see :help 'secure'.
vim.opt.secure = true
