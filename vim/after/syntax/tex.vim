unlet b:current_syntax
syntax include @PYTHON syntax/python.vim
let b:current_syntax = 'tex'

syntax cluster PYTHON remove=pythonEscape
syntax cluster PYTHON remove=pythonBEscape
syntax cluster PYTHON remove=pythonBytesEscape

syntax match texStatement /\\py[bsc]\?/ contained nextgroup=texPythontexArg
syntax region texPythontexArg matchgroup=Delimiter
         \ start='{' end='}'
         \ contains=@PYTHON,@NoSpell
syntax region texPythontexArg matchgroup=Delimiter
         \ start='\z([#@]\)' end='\z1'
         \ contains=@PYTHON,@NoSpell

syntax cluster texDocGroup add=texZonePythontex
syntax region texZonePythontex
         \ start='\\begin{pyblock}'rs=s
         \ end='\\end{gnuplot}'re=e
         \ keepend
         \ transparent
         \ contains=texBeginEnd,texBeginEndModifier,@PYTHON,@NoSpell
syntax region texZonePythontex
         \ start='\\begin{pycode}'rs=s
         \ end='\\end{pycode}'re=e
         \ keepend
         \ transparent
         \ contains=texBeginEnd,texBeginEndModifier,@PYTHON,@NoSpell

syn region texRefZone		matchgroup=texStatement start="\\bibentry{"		end="}\|%stopzone\>"	contains=@texRefGroup
