" vim ftplugin file
" Filename:     avisynth.vim
" Language:     AviSynth
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.
" Version:      0.15
" License:      New BSD License
"   See LICENSE.  Note that redistribution may be permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setlocal fenc< ff< fo< cin< cino< com<'

" AviSynth recognize only cp932 and CRLF
setlocal fileencoding=cp932
setlocal fileformat=dos

" indent options
setlocal formatoptions=croql
setlocal cindent
setlocal cinoptions=(0,u0,W4,m1
setlocal comments=s1:[*,mb:*,ex:*],s1:/*,mb:*,ex:*/,:#

" vim: ts=4 sw=4 sts=0 et
