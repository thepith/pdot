setlocal spell
set spelllang+=sciUS

"voom
nnoremap <leader>vo :Voom markdown<CR>

"write current date
nnoremap <leader>da i<C-R>=strftime("%Y-%m-%d")<CR><Esc>
nnoremap <leader>dt i<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc>

set noswapfile
let g:vimwiki_conceallevel = 1
let g:vimwiki_table_mappings = 0

set conceallevel=1
