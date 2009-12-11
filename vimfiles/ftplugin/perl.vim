" Vim ftplugin file
" Language:     Perl
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/11 19:19:30.
" Version:      0.12

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" for make
compiler perl

" kludge
" TODO: make the patch and send it to the maintainer of perl compiler plugin
"
" A file path may contain spaces (e.g. "C:\Documents and Settings"), thus %
" needs to be tucked by double quotations like "%", in win32 (with cmd.exe).
" And there is no need to specify a target file at the compiler plugin,
" so I remove % from 'makeprg'.
let &l:makeprg = substitute(&l:makeprg, '%', '', 'g')

" vim: ts=4 sw=4 sts=0 et
