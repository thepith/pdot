let g:fortran_free_source=1
let g:fortran_do_enddo=1
let g:fortran_have_tabs=1
let &errorformat="\ forrtl:\ severe\ (%n):\ %m,".&errorformat
let b:wantedfoldmethod="syntax"
setlocal textwidth=132
let g:easy_align_delimiters = {
         \  '!': { 'pattern': '!\+', 'delimiter_align': 'l',
         \         'ignore_groups': ['!Comment']  },
         \ }
