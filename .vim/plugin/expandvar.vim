" vim plugin file
" Filename:     expandvar.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.19
" Dependency:
"   This plugin needs following files
"
"   autoload/jwlib/buf/replace.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/buf/replace.vim
"
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

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
    if !hasmapto('<Plug>ExpandVariable', 'n')
        nmap <unique><Leader>ev
                    \ <Plug>ExpandVariable
    endif

    if !hasmapto('<Plug>EvalExpression', 'n')
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
    return jwlib#buf#replace#CWORD(function('expand'), '<e-target>')
endfunction

function! s:EvalExpression()
    return jwlib#buf#replace#CWORD(function('eval'), '<target>')
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
