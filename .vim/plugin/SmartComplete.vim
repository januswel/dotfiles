" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/09 02:22:41.
" Version:      0.21
" Remark:       function that return keys to activate complete depending to
"               the situation.

if has('insert_expand')
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
endif

" vim: ts=4 sw=4 sts=0 et
