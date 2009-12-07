" .gvimrc
" setting file for gvim
" this contains visual settings only, use with .vimrc
"
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/08 04:40:10.

" options {{{1
" display & information
set guioptions=         " show no gui components
set laststatus=2        " show status line always
set cmdheight=1         " height of command-line is 1 row
set langmenu=ja.utf-8   " language and encoding of menu
if has('gui_win32')
    " if VL Gothic will be found in the system, use MS Gothic
    set guifont=VL_Gothic:h12:cSHIFTJIS,MS_Gothic:h12:cSHIFTJIS
endif

" for East Asian Width Class Ambiguous
if exists('&ambiwidth')
    set ambiwidth=auto
endif

" syntax highlight {{{1
syntax enable       " use syntax highlight

" color scheme: Janus.vim
colorscheme Janus   " my color scheme


" script {{{1
" change cursor color to red on IME mode
if has('multi_byte_ime') || has('xim')
    highlight CursorIM guibg=Red guifg=NONE
endif

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
