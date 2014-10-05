" vim indent file
" Filename:     powershell.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" License:      MIT License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   https://github.com/januswel/dotfiles/blob/master/LICENSE

" preparations {{{1
" check if this indent file is already loaded or not
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" options {{{2
setlocal tabstop<
setlocal shiftwidth<
setlocal expandtab
setlocal softtabstop<

setlocal nocindent
setlocal autoindent
setlocal nosmartindent
setlocal indentkeys+=0)
setlocal indentkeys-=0#
setlocal indentexpr=GetPowerShellIndent()

if exists("*GetPowerShellIndent")
  finish
endif

" variables {{{2
let b:undo_indent = 'setlocal ' . join([
            \   'tabstop<',
            \   'shiftwidth<',
            \   'expandtab<',
            \   'softtabstop<',
            \   'cindent<',
            \   'autoindent<',
            \   'smartindent<',
            \   'indentkeys<',
            \   'indentexpr<',
            \ ])

" functions {{{2
function! GetPowerShellIndent()
    let lnum = prevnonblank(v:lnum - 1)
    if lnum ==# 0
        return 0
    endif

    let pnum = prevnonblank(lnum - 1)

    let ind = indent(lnum)
    let line = getline(lnum)

    if line =~# '\s*@\={'
        if line !~# '}\s*$'
            let ind += &l:shiftwidth
        endif
    elseif line =~# '^\s*@\=('
        if line !~# ')\s*$'
            let ind += &l:shiftwidth
        endif
    endif

    let pine = line
    let line = getline(v:lnum)
    if line =~# '^\s*}'
        let ind -= &l:shiftwidth
    elseif line =~# '^\s*)'
        let ind -= &l:shiftwidth
    endif

    return ind
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
