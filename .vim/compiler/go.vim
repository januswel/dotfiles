" vim compiler file
" Filename:     go.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" License:      MIT License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   https://raw.githubusercontent.com/januswel/<repo name>/master/LICENSE
"}}}1

" preparations {{{1
if exists('current_compiler')
    finish
endif
let current_compiler = 'go'

if exists(':CompilerSet') != 2
    command -nargs=* CompilerSet setlocal <args>
endif

" main {{{1
CompilerSet makeprg=go\ build
CompilerSet errorformat=%f:%l:\ %t%*[^:]:\ %m


" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
