" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/17 11:48:35.
" Version:      0.22
" Remark:       This plugin give you the function like
"               'tabm[ove][!] +N | -N' of Vimperator
" History:      2008/06/12 initial written
"               2008/06/15 correct and compress
" Usage:
"   :call TabShift(1)   " shift current tab to right
"   :call TabShift(-2)  " shift current tab to left 2

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_tabshift')
    finish
endif
let loaded_tabshift = 1

" check vim has required features
if !has('windows')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions {{{2
function! s:TabShift(delta)
    " delta must be signed number
    if a:delta !~ '^[+-]\?\d\+$' | return 0 | endif

    " calculate overwrap
    let max = tabpagenr('$')
    let pos = (tabpagenr() + a:delta - 1) % max

    " execute with sign correction
    execute 'tabmove' ((pos >= 0) ? pos : pos + max)
endfunction

" commands {{{2
command -nargs=1 TabShift call <SID>TabShift(<args>)

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
