# Nord theme.
set -l BLK "0B"
set -l CHR "0B"
set -l DIR "04"
set -l EXE "06"
set -l REG "00"
set -l HARDLINK "06"
set -l SYMLINK "06"
set -l MISSING "00"
set -l ORPHAN "09"
set -l FIFO "06"
set -l SOCK "0B"
set -l OTHER "06"
set -gx NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

set -gx NNN_BMS "p:$HOME/projects/;c:$HOME/projects/configs/;n:$HOME/projects/configs/neovim/.config/nvim/lua"