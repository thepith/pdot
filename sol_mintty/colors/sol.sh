pre=""
post=""
if [ -z ${SOLVAR+x} ]; then echo "SOLVAR is not set. Changing to dark."; export SOLVAR="dark"; fi

if [ ! -z ${TMUX+x} ]; then
   pre='\ePtmux;\e'
   post='\'
fi

if [ "$SOLVAR" = "dark" ]; then
   echo -ne "$pre"'\e]10;#839496\a\e\'"$post"  # Foreground   -> base0
   echo -ne "$pre"'\e]11;#002B36\a\e\'"$post"  # Background   -> base03
elif [ "$SOLVAR" = "light" ]; then
   echo -ne  "$pre"'\e]10;#657B83\a\e\'"$post"  # Foreground   -> base00
   echo -ne  "$pre"'\e]11;#FDF6E3\a\e\'"$post"  # Background   -> base3
fi

echo -ne "$pre"'\e]12;#DC322F\a\e\'"$post"  # Cursor       -> red
echo -ne "$pre"'\e]4;0;#073642\a\e\'"$post"  # black        -> Base02
echo -ne "$pre"'\e]4;1;#DC322F\a\e\'"$post"  # red          -> red
echo -ne "$pre"'\e]4;2;#859900\a\e\'"$post"  # green        -> green
echo -ne "$pre"'\e]4;3;#B58900\a\e\'"$post"  # yellow       -> yellow
echo -ne "$pre"'\e]4;4;#268BD2\a\e\'"$post"  # blue         -> blue
echo -ne "$pre"'\e]4;5;#D33682\a\e\'"$post"  # magenta      -> magenta
echo -ne "$pre"'\e]4;6;#2AA198\a\e\'"$post"  # cyan         -> cyan
echo -ne "$pre"'\e]4;7;#EEE8D5\a\e\'"$post"  # white        -> Base2
echo -ne "$pre"'\e]4;8;#002B36\a\e\'"$post"  # bold black   -> Base03
echo -ne "$pre"'\e]4;9;#CB4B16\a\e\'"$post"  # bold red     -> orange
echo -ne "$pre"'\e]4;10;#586E75\a\e\'"$post"  # bold green   -> base01 *
echo -ne "$pre"'\e]4;11;#657B83\a\e\'"$post"  # bold yellow  -> base00 *
echo -ne "$pre"'\e]4;12;#839496\a\e\'"$post"  # bold blue    -> base0 *
echo -ne "$pre"'\e]4;13;#6C71C4\a\e\'"$post"  # bold magenta -> violet
echo -ne "$pre"'\e]4;14;#93A1A1\a\e\'"$post"  # bold cyan    -> base1 *
echo -ne "$pre"'\e]4;15;#FDF6E3\a\e\'"$post"  # bold white   -> Base3

