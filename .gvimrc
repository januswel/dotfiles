" .gvimrc
" janus_wel <janus.wel.3@gmail.com>

" options {{{1
" display & information
set lines=25        " typical
set columns=90      " margin for 'number' and 'foldcolumn'
set cmdheight=1     " MacVim $VIM/gvimrc overwrites my .vimrc settings
set guioptions=c    " show no GUI components

" no way to use a mouse
set mouse=
set nomousefocus
set mousehide

" font
if has('win32')
    " When VL Gothic isn't found in the system, use MS Gothic.
    set guifont=VL_Gothic:h12:cSHIFTJIS,MS_Gothic:h12:cSHIFTJIS
    set linespace=0
endif
if has('mac')
    set guifont=VL_Gothic:h16
    set linespace=0
endif


" syntax highlight {{{1
syntax enable       " use syntax highlight

" color scheme: Janus.vim
colorscheme Janus   " my color scheme

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
