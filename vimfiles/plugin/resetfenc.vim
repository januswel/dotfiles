" resetfenc.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/08 02:21:55.
" Version:      0.10
" Remark:       if a file contains only ASCII characters,
"               set 'fileencoding' to the value of 'encoding'.
"               most encodings are compatible with ASCII characters or
"               superset of it.

" preparation {{{1
" check if this plugin is already loaded or not
if exists('loaded_resetfenc')
    finish
endif
let loaded_resetfenc = 1

" check vim has required features
if !(has('autocmd') && has('multi_byte'))
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions
function! s:ResetFileEncoding()
    if    &fileencoding !=# &encoding
    \  && search('[^\x01-\x7e]', 'n') == 0
        let &fileencoding = &encoding
    endif
endfunction

" autocmds
augroup resetfileencoding
    autocmd! resetfileencoding

    autocmd BufReadPost * call s:ResetFileEncoding()
augroup END

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
