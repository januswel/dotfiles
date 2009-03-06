" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/07 01:35:45.
" Version:      0.20
" Remark:       contribute command to open explorer.exe of win32.

if has('win32') && has('modify_fname')
    function! <SID>OpenWin32Explorer()
        let buffer_path = expand('%:p')
        if buffer_path != ''
            " open explorer and select editing file
            let cmd = '!start explorer /select,' . buffer_path
        else
            " when buffer's filename is empty
            let cmd = '!start explorer ' . getcwd()
        endif

        if has('multi_byte')
            " If 'encoding' option differ from system encoding, this
            " function needs iconv. In Windows, needs +iconv/dyn and
            " iconv.dll (libiconv.dll). See :help iconv-dynamic

            " save 'encoding' to variable
            let cur_encoding = &encoding
            " get default 'encoding'
            set encoding&

            " check
            if cur_encoding != &encoding
                " try to convert
                if has('iconv')
                    let cmd = iconv(cmd, cur_encoding, &encoding)
                else
                    echoerr 'OpenWin32Explorer needs iconv.'
                                \ . ' See :help iconv-dynamic.'
                    return 1
                endif
            endif

            " restore 'encoding'
            let &encoding = cur_encoding
        endif

        execute cmd
    endfunction

    " register command, for convenience
    command! -nargs=0 OpenWin32Explorer call <SID>OpenWin32Explorer()
endif

" vim: ts=4 sw=4 sts=0 et
