" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/27 00:06:07.
" Version:      0.10

" set readonly at opening vim runtime file
if has('autocmd') && exists('&readonly')
    function! ProtectRuntimeFile()
        if has('win32')
            if bufname('') =~ '^' . escape($VIMRUNTIME, '\')
                setlocal readonly
            endif
        else
            if bufname('') =~# '^' . $VIMRUNTIME
                setlocal readonly
            endif
        endif
    endfunction

    augroup ProtectRuntimeFile
        autocmd! ProtectRuntimeFile
        autocmd BufReadPost * call ProtectRuntimeFile()
    augroup END
endif

" vim: st=4 sw=4 sts=0 et
