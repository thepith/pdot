" Mappings for symbols
imap `0 \emptyset
imap `6 \partial
imap `8 \infty
imap `= \equiv
imap `\ \setminus
imap `. \cdot
imap `* \times
imap `< \langle
imap `> \rangle
imap `[ \subseteq
imap `] \supseteq
imap `( \subset
imap `) \supset
imap `A \forall
imap `E \exists
imap `jj \downarrow
imap `jJ \Downarrow
imap `jk \uparrow
imap `jK \Uparrow
imap `jh \leftarrow
imap `jH \Leftarrow
imap `jl \rightarrow
imap `jL \Rightarrow
imap `a \alpha
imap `b \beta
imap `c \chi
imap `d \delta
imap `e \epsilon
imap `f \phi
imap `g \gamma
imap `h \eta
imap `i \iota
imap `k \kappa
imap `l \lambda
imap `m \mu
imap `n \nu
imap `p \pi
imap `q \theta
imap `r \rho
imap `s \sigma
imap `t \tau
imap `y \psi
imap `u \upsilon
imap `w \omega
imap `z \zeta
imap `x \xi
imap `G \Gamma
imap `D \Delta
imap `F \Phi
imap `G \Gamma
imap `L \Lambda
imap `P \Pi
imap `Q \Theta
imap `S \Sigma
imap `U \Upsilon
imap `W \Omega
imap `X \Xi
imap `Y \Psi
imap `ve \varepsilon
imap `vf \varphi
imap `vk \varkappa
imap `vq \vartheta
imap `vr \varrho

" to use surround.vim
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

"appearance
set spell
set linebreak
let g:tex_comment_nospell= 1

"comilation
let b:tex_flavor = 'pdflatex'
compiler tex
if !filereadable("Makefile")
   " Find the main TeX file
   if !exists("w:TexMainFile")
      let w:TexMainFile = expand("%")
   endif
   let &makeprg='pdflatex -interaction=nonstopmode -c-style-errors '.w:TexMainFile
endif
set errorformat+=%f:%l:\ %m

function! SetTexMain(InTexMainFile)
   let w:TexMainFile = a:InTexMainFile
endfunction
