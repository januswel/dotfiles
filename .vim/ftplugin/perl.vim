" Vim ftplugin file
" Language:     Perl
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/26 15:36:51.
" Version:      0.10

" for make
compiler perl

" Windows need double quotation for %
" file path may contain spaces (e.g. "C:\Documents and Settings")
if has('win32')
    let &l:makeprg = substitute(&l:makeprg, '%', '"%"', 'g')
endif
