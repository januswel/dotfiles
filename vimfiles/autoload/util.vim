" vim autoload file
" Filename:     util.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/21 12:37:47.
" Version:      0.10
" Remark: {{{1
"   This autoload file provides utility functions.
"
"       * util#GetExceptionMessages()
"           returns an exception message. An message from vim is normalized as
"           if it is in interactive operation. See |catch-errors|.

" preparations {{{1
" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions {{{2
function! util#GetExceptionMessages()
    return substitute(v:exception, '^Vim.*:\(E\d\+\)', '\1', 'I')
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
