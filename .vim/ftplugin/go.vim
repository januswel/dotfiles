" vim ftplugin file
" Filename:     go.vim
" Language:     golang
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" License:      MIT License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   https://github.com/januswel/<VIMREPO>/blob/master/LICENSE

" preparations {{{1
" check if this ftplugin is already loaded or not
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
            \ && !(exists('no_ftgo_maps') && no_example_maps)

    " hasmapto() and <unique> are required to avoid overlap
    if !hasmapto('<Plug>(run-by-go-run)', 'n')
        nmap <unique><buffer><LocalLeader>r
                    \ <Plug>(run-by-go-run)
    endif
endif

nnoremap <script><silent><buffer><Plug>(run-by-go-run)
            \ :call <SID>RunByGoRun()<CR>

" compiler {{{2
compiler go

" functions {{{2
if !exists('*s:RunByGoRun')
    function s:RunByGoRun()
        let s:target = expand('%:p')
        try
            silent execute 'new +1,$!go\ run\ ' . s:target
            silent execute 'setlocal buftype=nofile'
            silent execute 'setlocal bufhidden=hide'
            silent execute 'setlocal noswapfile'
        catch
            echoerr v:exception
        endtry
    endfunction
endif

" options {{{2
" for ftplugin files
setlocal formatoptions-=t
setlocal formatoptions+=rol

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
