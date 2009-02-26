" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/25 23:38:13.
" Version:      0.20

" wrapper function for keywords in 'complete' and omni completion
function! SmartComplete()
    " select next item if completion window is exist
    if pumvisible()
        return "\<C-n>"
    endif

    " previous column of the cursor
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return ""
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<C-n>"
    else
        return "\<C-x>\<C-o>"
    endif
endfunction

" vim: st=4 sw=4 sts=0 et
