" vim autoload file
" Filename:     Dictionary.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.10
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions {{{2
function! jwlib#Dictionary#2Str(dict, ...)
    " assertion
    if type(a:dict) != 4
        throw 'A Dictionary is required: ' . string(a:dict)
    endif

    if !empty(a:000)
        if a:0 == 1
            let d1 = a:1
            let d2 = a:1
        else
            let d1 = a:1
            let d2 = a:2
        endif
    else
        let d1 = ':'
        let d2 = ','
    endif

    let result = []
    for [key, val] in items(a:dict)
        call add(result, key . d1 . string(val))
        unlet val
    endfor
    return join(result, d2)
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
