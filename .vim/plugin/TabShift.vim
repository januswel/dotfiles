" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/26 15:26:08.
" Version:      0.20
" Remark:       This plugin give you the function like
"               'tabm[ove][!] +N | -N' of Vimperator
" History:      2008/06/12 initial written
"               2008/06/15 correct and compress
" Usage:
"   :call TabShift(1)   " shift current tab to right
"   :call TabShift(-2)  " shift current tab to left 2

function! TabShift(delta)
    " delta must be signed number
    if a:delta !~ '^[+-]\?\d\+$' | return 0 | endif

    " calculate overwrap
    let max = tabpagenr('$')
    let pos = (tabpagenr() + a:delta - 1) % max

    " execute with sign correction
    execute 'tabmove' ((pos >= 0) ? pos : pos + max)
endfunction

" vim: st=4 sw=4 sts=0 et
