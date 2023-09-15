set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'michaeldyrynda/carbon'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'michaeljsmith/vim-indent-object'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
call plug#end()

au ColorScheme carbon hi Normal ctermbg=none guibg=none
colorscheme carbon

" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <Leader><CR> :so C:/Users/MON1CLJ/AppData/Local/nvim/init.vim<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>
nnoremap <C-E> :copen<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Quick scope only on finding letters
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"" Send current selection to null register so that pasting keeps the previous one in buffer
vnoremap <leader>p "_dP

"" Send yank to system clipboard
vnoremap <leader>y "+y

"" Send yank to system clipboard, but in normal mode, to allow extras (like selecting a whole paragraph)
nnoremap <leader>y "+y

"" Copy the whole file
nnoremap <leader>Y gg"+yG
