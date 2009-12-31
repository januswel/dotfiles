" vim rc file for GUI
" Filename:     .gvimrc
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.
" Remark:       This file must contains only visual settings for GUI.
"               Use with .vimrc.

" options {{{1
" display & information
set lines=25            " typical
set columns=90          " margin for 'number' and 'foldcolumn'
set guioptions=         " show no GUI components
set laststatus=2        " show status line always
set cmdheight=1         " height of command-line is 1 row
set langmenu=ja.utf-8   " language and encoding of menu
if has('win32')
    " When VL Gothic isn't found in the system, use MS Gothic.
    set guifont=VL_Gothic:h12:cSHIFTJIS,MS_Gothic:h12:cSHIFTJIS
    set linespace=0

    " no way to use a mouse
    set mouse=
    set nomousefocus
    set mousehide
endif

" for East Asian Width Class Ambiguous
if exists('&ambiwidth')
    set ambiwidth=auto
endif

" syntax highlight {{{1
syntax enable       " use syntax highlight

" color scheme: Janus.vim
colorscheme Janus   " my color scheme

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
