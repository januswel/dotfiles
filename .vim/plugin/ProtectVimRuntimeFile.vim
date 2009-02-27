" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/28 00:03:48.
" Version:      0.11

" set readonly at opening vim runtime file
if has('autocmd') && exists('&readonly')
    function! ProtectRuntimeFile()
        let s:path = '^' . $VIMRUNTIME

        if has('win32')
            if !(exists('+shellslash') && &shellslash == 1)
                let s:path = '^' . escape($VIMRUNTIME, '\')
            endif

            if bufname('') =~ s:path
                setlocal readonly
            endif
        else
            if bufname('') =~# s:path
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
