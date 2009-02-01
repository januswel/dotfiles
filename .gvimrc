" .gvimrc
" Last Change: 2009/02/01 14:17:41.

" options -----------------------------------------------------------------
" display & information
set guioptions=er   " show tab like system-native and right scroll bar only
set showtabline=2   " show tab bar always
set number          " show line numbers
set noruler         " not show row and column number of cursor
set title           " display file name to edit
set laststatus=2    " show status line always
set showmode        " show mode name
set cmdheight=1     " height of command-line is 1 row
set background=dark " low impact for eye
set nolist          " not show space characters (tab, line break)
set showmatch       " show pair parenthesis, bracket
set scrolloff=3     " above and below cursor number is 3 line
" filename [filetype][fileencoding:fileformat][RO]?[+]?    column:line/all-line[ percentage-of-buffer%]
set statusline=%t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L[%3p%%]

" syntax highlight --------------------------------------------------------
syntax enable       " use syntax highlight

" color scheme: Janus.vim
colorscheme Janus   " my color scheme


" vim: sw=4 sts=4 ts=4 et
