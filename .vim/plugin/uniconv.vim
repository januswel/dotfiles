" vim plugin file
" Filename:     uniconv.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.20
" Dependency:
"   This plugin needs following files
"
"   autoload/jwlib/unicode.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/unicode.vim
"   autoload/jwlib/buf/replace.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/buf/replace.vim
"
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

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

    if !hasmapto('<Plug>Uniconv2Utf8Literal', 'v')
        vmap <unique><Leader>uul
                    \ <Plug>Uniconv2Utf8Literal
    endif
    if !hasmapto('<Plug>Uniconv2Utf8Pattern', 'v')
        vmap <unique><Leader>uup
                    \ <Plug>Uniconv2Utf8Pattern
    endif
    if !hasmapto('<Plug>Uniconv2CodePointLiteral', 'v')
        vmap <unique><Leader>ucl
                    \ <Plug>Uniconv2CodePointLiteral
    endif
    if !hasmapto('<Plug>Uniconv2CodePointPattern', 'v')
        vmap <unique><Leader>ucp
                    \ <Plug>Uniconv2CodePointPattern
    endif
    if !hasmapto('<Plug>Uniconv2Name', 'n')
        nmap <unique><Leader>un
                    \ <Plug>Uniconv2Name
    endif
endif

vnoremap <silent><Plug>Uniconv2Utf8Literal
            \ <Esc>:silent call <SID>ToUtf8Literal()<CR>
vnoremap <silent><Plug>Uniconv2Utf8Pattern
            \ <Esc>:silent call <SID>ToUtf8Pattern()<CR>
vnoremap <silent><Plug>Uniconv2CodePointLiteral
            \ <Esc>:silent call <SID>ToCodePointLiteral()<CR>
vnoremap <silent><Plug>Uniconv2CodePointPattern
            \ <Esc>:silent call <SID>ToCodePointPattern()<CR>
nnoremap <silent><Plug>Uniconv2Name
            \ :silent call <SID>ToName()<CR>

" functions {{{2
function! s:ToUtf8Literal()
    return jwlib#buf#replace#VisualHighlighted(
                \   function('jwlib#unicode#GetLiteral'),
                \   '<target>', 'x',
                \ )
endfunction

function! s:ToUtf8Pattern()
    return jwlib#buf#replace#VisualHighlighted(
                \   function('jwlib#unicode#GetPattern'),
                \   '<target>', 'x',
                \ )
endfunction

function! s:ToCodePointLiteral()
    return jwlib#buf#replace#VisualHighlighted(
                \   function('jwlib#unicode#GetLiteral'),
                \   '<target>', 'u',
                \ )
endfunction

function! s:ToCodePointPattern()
    return jwlib#buf#replace#VisualHighlighted(
                \   function('jwlib#unicode#GetPattern'),
                \   '<target>', 'u',
                \ )
endfunction

function! s:ToName()
    return jwlib#buf#replace#Char(
                \   function('jwlib#unicode#GetName'),
                \   '<target>'
                \ )
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
