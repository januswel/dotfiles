" vim plugin file
" Filename:     expandvar.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/23 00:36:56.
" Version:      0.13
" Dependency:
"   This plugin needs following files
"
"   * autoload/buf/replace.vim
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/buf/replace.vim
"
" Remark: {{{1
"   This plugin provides the feature to expand variables or evaluate
"   expressions in the current buffer. When following identifiers in your
"   current buffer, and then hit <Leader>e for expand() or <Leader>E for eval()
"   (these are default key mappings) on these:
"
"       &encoding
"       '%:t'
"       &statusline
"
"   Results will be like fllowings:
"
"       " with <Leader>e
"       " Note: Some options are expanded to an irrelevant values. E.g.
"       "       'statusline'. This is an issue of vim itself.
"       utf-8
"       expandvar.vim
"       vimfiles\plugin\expandvar.vim
"
"       " with <Leader>E
"       utf-8
"       %:t
"       %t

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_expandvar')
    finish
endif
let loaded_expandvar = 1

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
function! s:ExpandVariable()
    return buf#replace#CWORD(function('expand'), '<e-target>')
endfunction

function! s:EvalExpression()
    return buf#replace#CWORD(function('eval'), '<target>')
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
