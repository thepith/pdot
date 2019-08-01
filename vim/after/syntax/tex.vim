unlet b:current_syntax
syntax include @PYTHON syntax/python.vim
let b:current_syntax = 'tex'

syntax cluster PYTHON remove=pythonEscape
syntax cluster PYTHON remove=pythonBEscape
syntax cluster PYTHON remove=pythonBytesEscape
syntax cluster PYTHON add=@NoSpell


syntax match texStatement /\\py[bsc]\?/ contained nextgroup=texPythontexArg
syntax region texPythontexArg matchgroup=Delimiter
         \ start='{' end='}'
         \ contains=@PYTHON
syntax region texPythontexArg matchgroup=Delimiter
         \ start='\z([#@]\)' end='\z1'
         \ contains=@PYTHON

syntax cluster texDocGroup add=texZonePythontex
syntax cluster texDocGroup add=texZonePy
syntax cluster texMathZoneX add=texZonePy
syntax region texZonePythontex
         \ start='\\begin{pyblock}'rs=s
         \ end='\\end{gnuplot}'re=e
         \ keepend
         \ transparent
         \ contains=texBeginEnd,texBeginEndModifier,@PYTHON
syntax region texZonePythontex
         \ start='\\begin{pycode}'rs=s
         \ end='\\end{pycode}'re=e
         \ keepend
         \ transparent
         \ contains=texBeginEnd,texBeginEndModifier,@PYTHON

syn match texZonePy "\\py\=\(\[.\{-}\]\)\=\s*{.\{-}}"	contains=texStatement,texInputCurlies,@PYTHON

syn region texRefZone		matchgroup=texStatement start="\\bibentry{"		end="}\|%stopzone\>"	contains=@texRefGroup

syn region texRefZone		matchgroup=texStatement start="\\ref{"		end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone		matchgroup=texStatement start="\\refeq{"		end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone		matchgroup=texStatement start="\\ce{"		end="}\|%stopzone\>"	contains=@texRefGroup

syn region texRefZone		matchgroup=texStatement start="\\email{"		end="}\|%stopzone\>"	contains=@texRefGroup

syn region texRefZone		matchgroup=texStatement start="\\setcounter{"		end="}\|%stopzone\>"	contains=@texRefGroup
