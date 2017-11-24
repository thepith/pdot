setlocal spell
set spelllang+=sciUS

"voom
nnoremap <leader>vo :Voom markdown<CR>

"calendar
nnoremap <leader>ca :Calendar<CR>

"write current date
nnoremap <leader>da i<C-R>=strftime("%Y-%m-%d")<CR><Esc>
nnoremap <leader>dt i<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc>

set noswapfile
let g:vimwiki_conceallevel = 0
set conceallevel=0
