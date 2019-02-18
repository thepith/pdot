function! DOIToBib(doi)
   let bib=system('curl -s -LH "Accept: text/bibliography; style=bibtex" http://dx.doi.org/'.a:doi.' | sed "s/, *\([a-zA-Z0-9-]*\) *= */,\n    \L\1 = /g"')
   return bib
endfunction

" command! -nargs=1 GetFromDOI o<C-r>=DOIToBib(<f-args>)<C-M>p
command! -nargs=1 GetFromDOI :normal "=DOIToBib(<f-args>)<Cr>p
nnoremap <leader>gd :GetFromDOI<space>
