" vim plugin file
" Filename:     fencdef.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 13.
" Version:      0.16
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" Remark: {{{1
"   If a file contains only ASCII characters, set 'fileencoding' to the value
"   of 'encoding'. Most encodings are compatible with ASCII characters or
"   superset of it.

" preparation {{{1
" check if this plugin is already loaded or not
if exists('loaded_fencdef')
    finish
endif
let loaded_fencdef = 1

" check vim has required features
if !(has('autocmd') && has('multi_byte'))
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions
function! s:ResetFileEncoding2Default()
    try
        let def = s:GetDefault()
    catch
        echoerr v:exception
    endtry
    if               &fileencoding !=# def
                \ && search('[^\x01-\x7e]', 'n') == 0
        let &fileencoding = def
    endif
endfunction

function! s:GetDefault()
    if exists('g:fencdef_default')
        if type(g:fencdef_default) == 1
            return g:fencdef_default
        else
            throw 'A String is required: ' . g:fencdef_default
        endif
    endif
    return &encoding
endfunction

" autocmds
augroup fencdef
    autocmd! fencdef

    autocmd BufReadPost * call s:ResetFileEncoding2Default()
augroup END

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
