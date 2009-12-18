" vim plugin file
" Filename:     tabshift.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/17 12:02:14.
" Version:      0.25
" Remark: {{{1
"   This plugin provides the command to move the current tabpage around by
"   specifying an integer, like ":tabm[ove][!] +N | -N" of Vimperator.
"
"   This command can be specified only a signed or unsigned integer. In order
"   to move the tabpage to the left, hit the following command:
"
"       :TabShift -1
"
"   When an integer that make the tabpage the left of first one or the right of
"   last one is specified this command, the tabpage will wrap. Thus the
"   following command make the tabpage that is far-right the third tabpage:
"
"       :TabShift 3

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