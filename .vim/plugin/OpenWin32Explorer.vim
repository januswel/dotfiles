" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/06 20:49:27.
" Version:      0.10
" Remark:       contribute function and command
"               to open explorer.exe of win32.

if has('win32')
    function! OpenWin32Explorer(system_encoding)
        let buffer_path = expand('%:p')
        if buffer_path != ''
            " open explorer and select editing file
            let cmd = '!start explorer /select,' . buffer_path
        else
            " when buffer's filename is empty
            let cmd = '!start explorer ' . getcwd()
        endif

        " if 'encofing' option differ from system encoding, this function
        " needs iconv !! in Windows, needs +iconv/dyn and iconv.dll
        " (libiconv.dll). see :help iconv-dynamic
        if &encoding != a:system_encoding
            if has('iconv')
                let cmd = iconv(cmd, &encoding, a:system_encoding)
            else
                echoerr 'OpenWin32Explorer needs iconv.'
                            \ . ' See :help iconv-dynamic.'
                return 1
            endif
        endif

        execute cmd
    endfunction

    " register command, for convenience
    command! -nargs=1 OpenWin32Explorer call OpenWin32Explorer(<args>)
endif

" vim: ts=4 sw=4 sts=0 et
