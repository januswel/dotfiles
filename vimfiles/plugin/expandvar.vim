" expandvar.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/14 14:49:06.
" Version:      0.10
" Remark:       This plugin provides the feature to expand variables or
"               evaluate expressions in the current buffer.

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_example')
    finish
endif
let loaded_example = 1

" check vim has required features
if !(has('win32') && exists('&guifont'))
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
    \ && !(exists('no_expandvar_maps') && no_expandvar_maps)
    if !hasmapto('<Plug>ExpandVariable')
        nmap <unique><Leader>ev
                    \ <Plug>ExpandVariable
    endif

    if !hasmapto('<Plug>EvalExpression')
        nmap <unique><Leader>ee
                    \ <Plug>EvalExpression
    endif
endif

nnoremap <silent><Plug>ExpandVariable
            \ :silent call <SID>ExpandVariable()<CR>
nnoremap <silent><Plug>EvalExpression
            \ :silent call <SID>EvalExpression()<CR>

" functions {{{2
" expanding a variable
function! s:GetExpanded(varname)
    execute 'let result = expand(' . a:varname . ')'
    return result
endfunction

function! s:ExpandVariable()
    return s:ReplaceCWORD(function('s:GetExpanded'))
endfunction

" evaluating an expression
function! s:GetEvaluated(expression)
    execute 'let result = eval("' . escape(a:expression, '"') . '")'
    return result
endfunction

function! s:EvalExpression()
    return s:ReplaceCWORD(function('s:GetEvaluated'))
endfunction

" common
function! s:ReplaceCWORD(func)
    " assertion
    if matchstr(getline('.'), '.', col('.') - 1) ==# ' '
        return
    endif

    let target = expand('<cWORD>')
    try
        let result = a:func(target)
    catch
        echoerr s:GetExceptionMessages()
        return
    endtry

    " if the result is List or Dictionary, convert it to string
    let t = type(result)
    if t ==# 3 || t ==# 4
        let r = string(result)
    else
        let r = result
    endif

    " cut the expression and paste the expanded result
    normal! "_ciW=r
endfunction

function! s:GetExceptionMessages()
    return substitute(v:exception, '^Vim.*:\(E\d\+\)', '\1', 'I')
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
