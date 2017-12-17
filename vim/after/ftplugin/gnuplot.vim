let &l:keywordprg='gnuplot -e help\'
setlocal commentstring =#\ %s

if !filereadable("Makefile")
   let &makeprg='gnuplot '.expand("%")
endif
