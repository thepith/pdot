let &l:keywordprg='gnuplot -e help\'
setlocal commentstring =#\ %s

nnoremap <leader>vp :execute("!sumatra " . expand('%:r').".pdf")<CR>
if !filereadable("Makefile")
   let &makeprg='gnuplot '.expand("%")
endif
