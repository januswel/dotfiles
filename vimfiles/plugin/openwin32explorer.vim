" vim plugin file
" Filename:     openwin32explorer.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/28 02:45:45.
" Version:      0.31
" Remark:       contribute command to open explorer.exe of win32.

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_openwin32explorer')
    finish
endif
let loaded_openwin32explorer = 1

" check vim has required features
if !(has('win32') && has('multi_byte') && has('modify_fname'))
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
function! s:ConvertEncodingToSystemDefault(orig_str)
    let str = a:orig_str

    if has('multi_byte')
        " If 'encoding' option differ from system encoding, this
        " function needs iconv. In Windows, needs +iconv/dyn and
        " iconv.dll (libiconv.dll). See :help iconv-dynamic

        " error flag
        let error = 0

        " save 'encoding' to variable
        let cur_encoding = &encoding
        " get default 'encoding'
        set encoding&

        " check
        if cur_encoding != &encoding
            " try to convert
            if has('iconv')
                let str = iconv(str, cur_encoding, &encoding)
            else
                let error = 1
            endif
        endif

        " restore 'encoding'
        let &encoding = cur_encoding

        if error
            throw 'Feature +iconv is needed.'
                        \ . ' See :help iconv-dynamic.'
        endif
    endif

    return str
endfunction

function! s:OpenWin32Explorer()
    let buffer_path = expand('%:p')
    if buffer_path != ''
        " open explorer and select editing file
        let cmd = '!start explorer /select,' . buffer_path
    else
        " when buffer's filename is empty
        let cmd = '!start explorer ' . getcwd()
    endif

    try
        execute s:ConvertEncodingToSystemDefault(cmd)
    catch
        echoerr 'OpenWin32Explorer.vim: ' . v:exception
    endtry
endfunction

" register command, for convenience
command! -nargs=0 OpenWin32Explorer call <SID>OpenWin32Explorer()

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
