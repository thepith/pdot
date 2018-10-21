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

function! VimwikiLinkHandler(link)
  " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
  "   1) [[vfile:~/Code/PythonProject/abc123.py]]
  "   2) [[vfile:./|Wiki Home]]
  let link = a:link
  if link =~# '^vfile:'
    let link = link[1:]
  else
    return 0
  endif
  let link_infos = vimwiki#base#resolve_link(link)
  if link_infos.filename == ''
    echomsg 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    exe 'tabnew ' . fnameescape(link_infos.filename)
    return 1
  endif
endfunction
