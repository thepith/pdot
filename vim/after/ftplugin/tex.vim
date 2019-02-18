" Mappings for symbols
inoremap <buffer> `0 \emptyset
inoremap <buffer> `6 \partial
inoremap <buffer> `8 \infty
inoremap <buffer> `= \equiv
inoremap <buffer> `\ \setminus
inoremap <buffer> `. \cdot
inoremap <buffer> `* \times
inoremap <buffer> `< \langle
inoremap <buffer> `> \rangle
inoremap <buffer> `[ \subseteq
inoremap <buffer> `] \supseteq
inoremap <buffer> `( \subset
inoremap <buffer> `) \supset
inoremap <buffer> `A \forall
inoremap <buffer> `E \exists
inoremap <buffer> `jj \downarrow
inoremap <buffer> `jJ \Downarrow
inoremap <buffer> `jk \uparrow
inoremap <buffer> `jK \Uparrow
inoremap <buffer> `jh \leftarrow
inoremap <buffer> `jH \Leftarrow
inoremap <buffer> `jl \rightarrow
inoremap <buffer> `jL \Rightarrow
inoremap <buffer> `a \alpha
inoremap <buffer> `b \beta
inoremap <buffer> `c \chi
inoremap <buffer> `d \delta
inoremap <buffer> `e \epsilon
inoremap <buffer> `f \phi
inoremap <buffer> `g \gamma
inoremap <buffer> `h \eta
inoremap <buffer> `i \iota
inoremap <buffer> `k \kappa
inoremap <buffer> `l \lambda
inoremap <buffer> `m \mu
inoremap <buffer> `n \nu
inoremap <buffer> `p \pi
inoremap <buffer> `q \theta
inoremap <buffer> `r \rho
inoremap <buffer> `s \sigma
inoremap <buffer> `t \tau
inoremap <buffer> `y \psi
inoremap <buffer> `u \upsilon
inoremap <buffer> `w \omega
inoremap <buffer> `z \zeta
inoremap <buffer> `x \xi
inoremap <buffer> `G \Gamma
inoremap <buffer> `D \Delta
inoremap <buffer> `F \Phi
inoremap <buffer> `G \Gamma
inoremap <buffer> `L \Lambda
inoremap <buffer> `P \Pi
inoremap <buffer> `Q \Theta
inoremap <buffer> `S \Sigma
inoremap <buffer> `U \Upsilon
inoremap <buffer> `W \Omega
inoremap <buffer> `X \Xi
inoremap <buffer> `Y \Psi
inoremap <buffer> `ve \varepsilon
inoremap <buffer> `vf \varphi
inoremap <buffer> `vk \varkappa
inoremap <buffer> `vq \vartheta
inoremap <buffer> `vr \varrho
inoremap <buffer> `~ \approx

" to use surround.vim
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
nnoremap <leader>vp :execute("!xdg-open " . expand('%:r').".pdf")<CR>

nnoremap <leader>vp :execute("!xdg-open " . expand('%:r').".pdf")<CR>

"appearance
set spell
set linebreak

"comilation
let b:tex_flavor = 'pdflatex'
compiler tex
let &l:makeprg='make'
" match c-style-errors
set errorformat+=%f:%l:\ %m
" ignore date stamps
set errorformat^=%-G%.%#%\\d%\\+\/%\\d%\\+\/%\\d%\\+\/%\\d%\\+:%\\d%\\+:%\\d%\\+%.%#
function! UsePdflatex()
   let &l:makeprg='pdflatex -interaction=nonstopmode -c-style-errors '.expand('%:t').''
endfunction

function! UseLatexmk()
   let &l:makeprg='latexmk -pdf -interaction=batchmode -quiet -c-style-errors '.expand('%:t').''
endfunction

"voom
nnoremap <leader>vo :Voom latex<CR>

"ALE
let b:ale_linters = ['chktex']
set foldmethod=marker
