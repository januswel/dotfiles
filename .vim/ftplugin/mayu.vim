" Vim ftplugin file
" Language:     mayu
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/04 21:05:05.
" Version:      0.12

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

" indent options
setlocal formatoptions=croql
setlocal comments=:#

" vim: ts=4 sw=4 sts=0 et
