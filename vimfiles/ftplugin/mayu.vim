" Vim ftplugin file
" Language:     mayu
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/11 17:13:36.
" Version:      0.13

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setlocal formatoptions< comments<'

" indent options
setlocal formatoptions=croql
setlocal comments=:#

" vim: ts=4 sw=4 sts=0 et
