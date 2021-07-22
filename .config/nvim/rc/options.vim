" File encoding
set encoding=utf-8

" Don't create backup
set nowritebackup
set nobackup
set noswapfile
set backupdir-=.

" Show column number
set number

" Highlight column number
set cursorline
hi clear CursorLine

" Visualize invisible string
set list
set listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%
set listchars=tab:>\ ,trail:-,eol:⏎

"
set tabstop=4
set shiftwidth=4
" Exchange tab to spaces.
set expandtab
set softtabstop=0

" Always display statusline.
set laststatus=2

" Enable true color
if exists('+termguicolors')
  set termguicolors
endif

