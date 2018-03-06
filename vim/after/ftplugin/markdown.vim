setlocal spell
packadd vim-markdown
packadd VOom
" vim-markdown
nnoremap <leader>vo :Toc<CR>
let g:vim_markdown_new_list_item_indent = 3

" from https://github.com/gabrielelana/vim-markdown/blob/master/autoload/markdown.vim
" {{{ SWITCH STATUS
function! markdown#SwitchStatus()
  let l:current_line = getline('.')
  if match(l:current_line, '^\s*[*\-+] \[ \]') >= 0
    call setline('.', substitute(l:current_line, '^\(\s*[*\-+]\) \[ \]', '\1 [x]', ''))
    return
  endif
  if match(l:current_line, '^\s*[*\-+] \[x\]') >= 0
    call setline('.', substitute(l:current_line, '^\(\s*[*\-+]\) \[x\]', '\1', ''))
    return
  endif
  if match(l:current_line, '^\s*[*\-+] \(\[[x ]\]\)\@!') >= 0
    call setline('.', substitute(l:current_line, '^\(\s*[*\-+]\)', '\1 [ ]', ''))
    return
  endif
  if match(l:current_line, '^\s*#\{1,5}\s') >= 0
    call setline('.', substitute(l:current_line, '^\(\s*#\{1,5}\) \(.*$\)', '\1# \2', ''))
    return
  endif
  if match(l:current_line, '^\s*#\{6}\s') >= 0
    call setline('.', substitute(l:current_line, '^\(\s*\)#\{6} \(.*$\)', '\1# \2', ''))
    return
  endif
endfunction
nnoremap <C-@> :call markdown#SwitchStatus()<CR>
" }}}

nnoremap <leader>N / *\* \[ \]<CR>
