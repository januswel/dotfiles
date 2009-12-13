" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/13 14:30:58.
" Version:      0.11
" Remark:       cleanup buffer list. delete listed but unloaded buffer from
"               buffer list.

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

" vim: ts=4 sw=4 sts=0 et
