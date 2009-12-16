" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/16 16:29:36.
" Version:      0.17
" Remark:       This plugin provides the command ":SweepBufList", mappings
"               "<Leader>sb" and "<Plug>SweepBufList" to sweep buffer list.
"               Deleting buffers are listed but unloaded ones.

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_sweepbuflist')
    finish
endif
let loaded_sweepbuflist = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" commands {{{2
if exists(':SweepBufList') != 2
    command SweepBufList call <SID>SweepBufList()
endif

" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
    \ && !(exists('no_sweepbuflist_maps') && no_sweepbuflist_maps)

    if !hasmapto('<Plug>SweepBufList', 'n')
        nmap <silent><unique><Leader>sb
                    \ <Plug>SweepBufList|:buffers<CR>
    endif
endif

nnoremap <silent><Plug>SweepBufList
            \ :silent call <SID>SweepBufList()<CR>

" functions {{{2
function! s:SweepBufList()
    let lastbuf = bufnr('$')
    let targets = []
    let nr = 1
    while nr <= lastbuf
        if buflisted(nr) && !bufloaded(nr)
            call add(targets, nr)
        endif
        let nr += 1
    endwhile

    if !empty(targets)
        execute 'bdelete ' . join(targets)
    endif
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
