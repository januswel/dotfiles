" .gvimrc
" setting file for gvim
" this contains visual settings only, use with .vimrc
"
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/02 16:24:24.

" options {{{1
" display & information
set guioptions=er   " show tab like system-native and right scroll bar only
set laststatus=2    " show status line always
set cmdheight=1     " height of command-line is 1 row


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
