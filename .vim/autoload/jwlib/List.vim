" vim autoload file
" Filename:     List.vim
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
function! jwlib#List#Flatten(list)
    " assetion
    if type(a:list) == 3
        throw 'A List is required: ' . a:list
    endif

    let result = []
    for item in a:list
        let typeofitem = type(item)
        if     typeofitem == 3 " List
            " faster than extend() ?
            let result += jwlib#List#Flatten(item)
        else
            call add(result, item)
        endif
        " need for various types
        unlet item
    endfor
    return result
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
