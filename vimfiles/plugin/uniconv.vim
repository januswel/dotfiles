" vim plugin file
" Filename:     uniconv.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/21 12:46:54.
" Version:      0.11
" Dependency:
"   This plugin needs autoload/unicode.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/unicode.vim
"
" Remark:       This plugin provides the feature to convert <cword> to form of
"               UTF-8 literal string (like "\xc2\xa9" for "©") or search
"               pattern (like "\%xe9\%x99\%xbd" for "陽").

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_uniconv')
    finish
endif
let loaded_uniconv = 1

" check vim has required features
if !has('multi_byte')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
    \ && !(exists('no_uniconv_maps') && no_uniconv_maps)

    if !hasmapto('<Plug>Uniconv2Utf8Literal')
        nmap <unique><Leader>ul
                    \ <Plug>Uniconv2Utf8Literal
    endif
    if !hasmapto('<Plug>Uniconv2Utf8Pattern')
        nmap <unique><Leader>up
                    \ <Plug>Uniconv2Utf8Pattern
    endif
endif

nnoremap <silent><Plug>Uniconv2Utf8Literal
            \ :silent call <SID>ToUtf8Literal()<CR>
nnoremap <silent><Plug>Uniconv2Utf8Pattern
            \ :silent call <SID>ToUtf8Pattern()<CR>

" functions {{{2
function! s:ToUtf8Literal()
    return s:ReplaceCword(function('unicode#GetLiteral'))
endfunction

function! s:ToUtf8Pattern()
    return s:ReplaceCword(function('unicode#GetPattern'))
endfunction

" stuff
function! s:ReplaceCword(func)
    " assertion
    if matchstr(getline('.'), '.', col('.') - 1) ==# ' '
        return
    endif

    let target = expand('<cword>')
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
    normal! "_ciw=r
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
