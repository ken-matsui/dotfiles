let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin()

Plug 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1

Plug 'vim-airline/vim-airline-themes'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'jiangmiao/auto-pairs'

Plug 'bronson/vim-trailing-whitespace'
autocmd BufWritePre * :%s/\s\+$//e

Plug 'tpope/vim-commentary'

Plug 'machakann/vim-highlightedyank'

Plug 'cappyzawa/trim.nvim'

Plug 'github/copilot.vim'

call plug#end()
