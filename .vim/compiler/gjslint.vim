" vim compiler file
" Filename:     gjslint.vim
" Language:     javascript
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
if exists('current_compiler')
    finish
endif
let current_compiler = 'avisynth'

if exists(':CompilerSet') != 2
    command -nargs=* CompilerSet setlocal <args>
endif

" main {{{1
CompilerSet makeprg=gjslint\ --nobeep
CompilerSet errorformat=%-P%>-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ %t:%n:\ %m,%-Q

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
