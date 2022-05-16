
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin()

" List of plugins.
" Make sure you use single quotes

" Shorthand notation
Plug 'jalvesaq/Nvim-R'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim'

" Initialize plugin system
call plug#end()

" Setup radian console
let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1
