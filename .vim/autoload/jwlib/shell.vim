" vim autoload file
" Filename:     shell.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.14
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" preparations {{{1
" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" constants {{{2
" In this case, we can't use Dictionary for its attribute to exclude the order.
unlockvar s:shelltypes
let s:shelltypes = [
            \   ['cmd', '\vcmd%(\.exe)?'],
            \   ['csh', '\vt?csh%(\.exe)?'],
            \   ['zsh', '\vzsh%(\.exe)?'],
            \   ['sh',  '\v%(ba)?sh%(\.exe)?'],
            \ ]
lockvar s:shelltypes

" functions {{{2
" return string
function! jwlib#shell#GetType()
    for [type, pattern] in s:shelltypes
        if &shell =~? pattern
            return type
        endif
    endfor

    " I don't know
    return
endfunction

" get default encoding of shell
function! jwlib#shell#GetEncoding(...)
    " heuristic
    if jwlib#shell#GetType() ==# 'cmd'
        return 'cp932'
    endif

    " the term may know all
    if exists('&termencoding')
        if !empty(&termencoding) && &encoding !=? &termencoding
            return &termencoding
        endif
    endif

    " changing 'encoding' dynamically may have side effects
    if a:0 && a:1
        " the default value of 'encoding' is fitted with the system, maybe
        let save_encoding = &encoding
        set encoding&
        let result = &encoding
        let &encoding = save_encoding
        return result
    endif

    " I don't know
    return &encoding
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
