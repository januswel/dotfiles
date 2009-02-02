" TabShift.vim
" This plugin give you the function like 'tabm[ove][!] +N | -N' of Vimperator 
" Author  : janus_wel
" License : New BSD License
" Version : 0.2
"
" History
"   2008/06/12 initial written
"   2008/06/15 correct and compress
"           
" Usage
"   return 0 if failed, 1 if succeeded
"     :call TabShift(1)    shift current tab to right
"     :call TabShift(-2)   shift current tab to left 2

function! TabShift(delta)
    " delta must be signed number 
    if a:delta !~ '^[+-]\?\d\+$' | return 0 | endif

    " calculate overwrap
    let max = tabpagenr('$')
    let pos = (tabpagenr() + a:delta - 1) % max

    " execute with sign correction
    execute 'tabmove' ((pos >= 0) ? pos : pos + max)

    " succeeded
    return 1
endfunction

" vim: ft=vimperator sw=4 sts=4
