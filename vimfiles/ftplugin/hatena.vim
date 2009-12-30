" vim ftplugin file
" Filename:     hatena.vim
" Language:     hatena notation
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.
" Version:      0.11
" License:      New BSD License
"   See LICENSE.  Note that redistribution may be permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setlocal fo<'

setlocal formatoptions=qlM

" vim: ts=4 sw=4 sts=0 et
