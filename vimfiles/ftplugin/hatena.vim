" Vim ftplugin file
" Language:     hatena notation
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/11 17:05:56.
" Version:      0.10

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setlocal fo<'

setlocal formatoptions=qlM

" vim: ts=4 sw=4 sts=0 et
