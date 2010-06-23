" vim ftplugin file
" Filename:     perl.vim
" Language:     Perl
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jun 23.
" Version:      0.14
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" fold {{{2
function! PerlFoldLevel(lnum)
    let line = getline(a:lnum)

    " modeline
    if line =~# '\v^#\s*<vim>'
        return 0
    endif

    " __END__
    if line =~# '\v\C^__END__$'
        return '>1'
    endif

    " sub routine
    if line =~# '\v\s*<%(sub|BEGIN|END)>'
        return '>1'
    endif

    " POD
    if line =~# '\v\C^\=<%(head\d|over|pod|begin)>'
        return '>2'
    endif

    return '='
endfunction

setlocal foldmethod=expr
setlocal foldexpr=PerlFoldLevel(v:lnum)
setlocal foldcolumn=3

" compiler {{{2
compiler perl

" kludge
" TODO: make the patch and send it to the maintainer of perl compiler plugin
"
" A file path may contain spaces (e.g. "C:\Documents and Settings"), thus %
" needs to be tucked by double quotations like "%", in win32 (with cmd.exe).
" And there is no need to specify a target file at the compiler plugin,
" so I remove % from 'makeprg'.
let &l:makeprg = substitute(&l:makeprg, '%', '', 'g')

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
