" vim plugin file
" Filename:     uniconv.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/21 12:55:27.
" Version:      0.12
" Dependency:
"   This plugin needs following files
"
"   * autoload/unicode.vim
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/unicode.vim
"   * autoload/buf/replace.vim
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/buf/replace.vim
"
" Remark: {{{1
"   This plugin provides the feature to convert highlighted area in visual mode
"   to form of UTF-8 literal string or search pattern by some key mappings
"   (default):
"
"       "\x6b\xc3\xb6\x6e\x69\x67" for "könig" by <Leader>ul
"       "\%xc2\%xa9"               for "©"    by <Leader>up
"
"   Following internal mappings are also added.
"
"       <Plug>Uniconv2Utf8Literal
"       <Plug>Uniconv2Utf8Pattern

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
        vmap <unique><Leader>ul
                    \ <Plug>Uniconv2Utf8Literal
    endif
    if !hasmapto('<Plug>Uniconv2Utf8Pattern', 'v')
        vmap <unique><Leader>up
                    \ <Plug>Uniconv2Utf8Pattern
    endif
endif

vnoremap <silent><Plug>Uniconv2Utf8Literal
            \ <Esc>:silent call <SID>ToUtf8Literal()<CR>
vnoremap <silent><Plug>Uniconv2Utf8Pattern
            \ <Esc>:silent call <SID>ToUtf8Pattern()<CR>

" functions {{{2
function! s:ToUtf8Literal()
    return buf#replace#VisualHighlighted(
                \   function('unicode#GetLiteral'),
                \   '<target>', 'x',
                \ )
endfunction

function! s:ToUtf8Pattern()
    return buf#replace#VisualHighlighted(
                \   function('unicode#GetPattern'),
                \   '<target>', 'x',
                \ )
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
