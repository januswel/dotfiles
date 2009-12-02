" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/09 02:28:09.
" Version:      0.30
" Remark:       function that return keys to activate complete depending to
"               the situation.

if has('insert_expand')
    function! SmartComplete()
        " select next item if completion window is exist
        if pumvisible()
            return "\<C-n>"
        endif

        if &omnifunc != ''
            " omni completion
            return "\<C-x>\<C-o>"
        elseif &filetype == 'vim'
            " vim functions, special variables etc
            return "\<C-x>\<C-v>"
        elseif &filetype == 'perl'
            " perl has a lot of included files...
            return "\<C-n>"
        else
            " keyword completion(only in current buffer and included files)
            return "\<C-x>\<C-i>"
        endif
    endfunction
endif

" vim: ts=4 sw=4 sts=0 et
