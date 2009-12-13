" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/13 14:34:35.
" Version:      0.12
" Remark:       cleanup buffer list. delete listed but unloaded buffer from
"               buffer list.

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_sweepbuflist')
    finish
endif
let loaded_sweepbuflist = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
function! s:SweepBufList()
    let numof_buffer = bufnr('$')
    let l:b = 1
    while l:b <= numof_buffer
        if buflisted(l:b) && !bufloaded(l:b)
            execute 'bdelete ' . l:b
        endif
        let l:b = l:b + 1
    endwhile
endfunction

command! SweepBufList call <SID>SweepBufList()

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
