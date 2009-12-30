" vim ftplugin file
" Filename:     mayu.vim
" Language:     mayu
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.
" Version:      0.14
" License:      New BSD License
"   See LICENSE.  Note that redistribution may be permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setlocal formatoptions< comments<'

" indent options
setlocal formatoptions=croql
setlocal comments=:#

" vim: ts=4 sw=4 sts=0 et
