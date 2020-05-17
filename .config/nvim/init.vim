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

let g:false = 0
let g:true = 1

augroup MyAutoCmd
  autocmd!
augroup END

function! s:glob(from, pattern)
  return split(globpath(a:from, a:pattern), "[\r\n]")
endfunction

function! s:source(from, ...)
  let found = g:false
  for pattern in a:000
    for script in s:glob(a:from, pattern)
      execute 'source' escape(script, ' ')
      let found = g:true
    endfor
  endfor
  return found
endfunction

function! s:load(...) abort
  let base = expand($HOME.'/.config/nvim/rc')
  let found = g:true

  if len(a:000) > 0
    " Stop to load
    if index(a:000, g:false) != -1
      return g:false
    endif
    for file in a:000
      if !s:source(base, file)
        let found = s:source(base, '*[0-9]*_'.file)
      endif
    endfor
  else
    " Load all files starting with number
    let found = s:source(base, '*[0-9]*_*.vim')
  endif

  return found
endfunction

let g:python_host_prog = '/usr/bin/python' " system python2
let g:python3_host_prog = '/usr/local/bin/python3' " homebrew python3

call s:load('dein.vim')
call s:load('filetype.vim')
call s:load('mappings.vim')
call s:load('options.vim')
call s:load('view.vim')

" Must be written at the last.  see :help 'secure'.
set secure
