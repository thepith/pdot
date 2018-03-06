let &l:keywordprg='gnuplot -e help\'
packadd gnuplot.vim
setlocal commentstring =#\ %s

nnoremap <leader>vp :execute("!xdg-open " . expand('%:r').".pdf")<CR>
if !filereadable("Makefile")
   let &makeprg='gnuplot '.expand("%")
endif
