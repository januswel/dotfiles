" .gvimrc
" setting file for gvim
" this contains visual settings only, use with .vimrc
"
" author janus_wel <janus.wel.3@gmail.com>
" Last Change: 2009/02/03 05:35:49.

" options -----------------------------------------------------------------
" display & information
set guioptions=er   " show tab like system-native and right scroll bar only
set laststatus=2    " show status line always
set cmdheight=1     " height of command-line is 1 row


" syntax highlight --------------------------------------------------------
syntax enable       " use syntax highlight

" color scheme: Janus.vim
colorscheme Janus   " my color scheme


" script ------------------------------------------------------------------
" change cursor color to red on IME mode
if has('multi_byte_ime') || has('xim')
    highlight CursorIM guibg=Red guifg=NONE
endif


" vim: sw=4 sts=4 ts=4 et
