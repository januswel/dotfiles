" Vim ftplugin file
" Language:     AviSynth
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/24 14:44:29.
" Version:      0.12

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

" AviSynth recognize only cp932
setlocal fileencoding=cp932
setlocal fileformat=dos

" indent options
setlocal formatoptions=croql
setlocal cindent
setlocal cinoptions=(0,u0,W4,m1
setlocal comments=s1:[*,mb:*,ex:*],s1:/*,mb:*,ex:*/,:#
