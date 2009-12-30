" vim autoload file
" Filename:     replace.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.
" Version:      0.11
" License:      New BSD License
"   See LICENSE.  Note that redistribution is permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" Dependency:
"   This plugin needs following files
"
"   * autoload/util.vim
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/util.vim
"
" Remark: {{{1
"   This script provides functions to replace a specified area to the result of
"   execution with a specified function. Following functions will be defined
"   specifically:
"
"       * buf#replace#Char({Funcref}, ...)
"           target is a character under the cursor
"       * buf#replace#CWORD({Funcref}, ...)
"           target is a <cWORD>
"       * buf#replace#VisualHighlighted({Funcref}, ...)
"           target is highlighted area in visual mode
"
"   All these functions require {Funcref} that is a reference of a function to
"   return a string. And arguments of the function referred by {Funcref} can be
"   passed continuously. Additionally, this special arguments "<target>" and
"   "<e-target>" are available. The "<target>" will be expanded the target of
"   above functions. The "<e-target>" will be also expanded but then evaluated,
"   use this when you wanna treat the target as an identifier (e.g. variables,
"   option names etc).
"
"   Following codes are simple use:
"
"       function Tuck(char, cover)
"           return a:cover + a:char + a:cover
"       endfunction
"       call buf#replace#Char(function('Tuck'), '<target>', '%')
"
"   These codes tuck a character under the cursor with "%" (This is overdone
"   for just tucking. Use a mapping.). You can see examples of above functions
"   in expandvar.vim and uniconv.vim:
"
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/plugin/expandvar.vim
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/plugin/uniconv.vim

" preparations {{{1
" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions {{{2
function! buf#replace#Char(func, ...)
    let args = [
                \ function('s:GetChar'),
                \ function('s:SetChar'),
                \ a:func
                \ ]
    let args += a:000
    return call(function('s:Replace'), args)
endfunction

function! buf#replace#CWORD(func, ...)
    let args = [
                \ function('s:GetCWORD'),
                \ function('s:SetCWORD'),
                \ a:func
                \ ]
    let args += a:000
    return call(function('s:Replace'), args)
endfunction

function! buf#replace#VisualHighlighted(func, ...)
    let args = [
                \ function('s:GetVisualHighlighted'),
                \ function('s:SetVisualHighlighted'),
                \ a:func
                \ ]
    let args += a:000
    return call(function('s:Replace'), args)
endfunction

" stuff functions {{{2
" common and important function
" special arguments
"   "<target>":   expanded to the target of each functions.
"   "<e-target>": expanded to the target of each functions and evaluate it.
function! s:Replace(getfunc, setfunc, func, ...)
    try
        " get the target (character|string)
        let target = a:getfunc()

        " build arguments
        let args = []
        for arg in a:000
            if arg ==# '<target>'
                call add(args, target)
            elseif arg ==# '<e-target>'
                call add(args, eval(target))
            else
                call add(args, arg)
            endif
        endfor

        " get the result of the convert function
        let result = call(a:func, args)

        " if the result is List or Dictionary, convert it to string
        let t = type(result)
        if t ==# 3 || t ==# 4
            let r = string(result)
        else
            let r = result
        endif

        " cut the target and paste the expanded result
        call a:setfunc(r)
    catch
        echoerr util#GetExceptionMessages()
        return
    endtry
endfunction

" for buf#replace#Char()
function! s:GetChar()
    return matchstr(getline('.'), '.', col('.') - 1)
endfunction

function! s:SetChar(r)
    normal! "_cl=a:r
endfunction

" for buf#replace#CWORD()
function! s:GetCWORD()
    " assertion
    if matchstr(getline('.'), '.', col('.') - 1) ==# ' '
        return ' '
    endif

    return expand('<cWORD>')
endfunction

function! s:SetCWORD(r)
    normal! "_ciW=a:r
endfunction

" for buf#replace#VisualHighlighted()
function! s:GetVisualHighlighted()
    let save_reg_z = @z
    normal! gv"zy
    let result = @z
    let @z = save_reg_z

    return result
endfunction

function! s:SetVisualHighlighted(r)
    normal! gv"_c=a:r
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
