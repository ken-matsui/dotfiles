if &compatible
  set nocompatible
endif

function! s:source_rc(path, ...) abort
  let use_global = get(a:000, 0, !has('vim_starting'))
  let abspath = resolve(expand('~/.config/nvim/rc/' . a:path))
  if !use_global
    execute 'source' fnameescape(abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let content = map(readfile(abspath),
        \ 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')
  " create tempfile and source the tempfile
  let tempfile = tempname()
  try
    call writefile(content, tempfile)
    execute 'source' fnameescape(tempfile)
  finally
    if filereadable(tempfile)
      call delete(tempfile)
    endif
  endtry
endfunction

" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

" Pythonの設定
let g:python_host_prog=$PYENV_ROOT.'/shims/python2.7'
let g:python3_host_prog=$PYENV_ROOT.'/shims/python3.5'

call s:source_rc('dein.rc.vim')
call s:source_rc('mappings.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('filetype.rc.vim')

