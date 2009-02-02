" wrapper function for keywords in 'complete' and omni completion
function! InsertTabWrapper()
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
