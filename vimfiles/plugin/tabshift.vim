" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/17 12:01:07.
" Version:      0.24
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
    " assertion
    " suppose the delta is an integer
    if type(a:delta) !=# 0
        echoerr 'An integer is required!!'
        return
    endif

    " calculate overwrap
    let numoftab = tabpagenr('$')
    let pos = (tabpagenr() + a:delta - 1) % numoftab
    " sign correction
    let pos = pos >= 0 ? pos : pos + numoftab

    execute 'tabmove' pos
endfunction

" commands {{{2
if exists(':TabShift') != 2
    command -nargs=1 TabShift call <SID>TabShift(<args>)
endif

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
