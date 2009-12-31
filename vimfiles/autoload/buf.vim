" vim autoload file
" Filename:     buf.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 01.
" Version:      0.12
" License:      New BSD License
"   See LICENSE.  Note that redistribution is permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" Remark:       utility functions for buffer

" preparations {{{1
" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions {{{2
" return bool
function! buf#IsEmpty()
    if line('$') ==# 1 && empty(getline(1))
        return 1
    endif
    return 0
endfunction

" return bool
function! buf#IsModifiable()
    if &modifiable && !&readonly
        return 1
    endif
    return 0
endfunction

" return bool
function! buf#IsNormalType()
    if empty(&buftype)
        return 1
    endif
    return 0
endfunction


" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
