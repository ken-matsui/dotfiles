if 0 | endif

" Use plain vim
" when vim was invoked by 'sudo' command
" or, invoked as 'git difftool'
if exists('$SUDO_USER') || exists('$GIT_DIR')
  finish
endif

if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

let files = split(glob("~/.config/nvim/rc/" . "*.vim"))

for file in files
	execute 'source' file
endfor

" Must be written at the last.  see :help 'secure'.
set secure
