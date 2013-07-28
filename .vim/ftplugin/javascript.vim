" vim ftplugin file
" Filename:     javascript.vim
" Language:     javascript
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

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
            \ && !(exists('no_ftjavascript_maps') && no_example_maps)

    " hasmapto() and <unique> are required to avoid overlap
    if !hasmapto('<Plug>ModifyByFixJsStyle', 'n')
        nmap <unique><buffer><LocalLeader>m
                    \ <Plug>ModifyByFixJsStyle
    endif
endif

" modify by fixjsstyle
nnoremap <script><silent><buffer><Plug>ModifyByFixJsStyle
            \ :call <SID>ModifyByFixJsStyle()<CR>

" options {{{2
" insert comment strings and indent automatically
setlocal comments=sr:/*,mb:*,ex:*/,://

" synonymous with :setlocal formatoptions=croql
" don't use = operator with formatoptions
" see :help 'formatoptions'
setlocal formatoptions-=t
setlocal formatoptions+=rol



" compiler {{{2
compiler gjslint

" functions {{{2
" filter by fixjsstyle
if !exists('*s:ModifyByFixJsStyle')
    function s:ModifyByFixJsStyle()
        " save positions
        let pos = s:SavePositions()

        let tempfile = tempname() . '.js'
        silent call writefile(getbufline(bufname('%'), 1, '$'), tempfile)

        try
            " use fixjsstyle as filter
            silent! execute '!fixjsstyle' tempfile

            1,$delete "_
            execute 'read' tempfile
            1delete "_

            " restore positions
            call s:RestorePositions(pos)
        catch
            echoerr v:exception
        finally
            call delete(tempfile)
        endtry
    endfunction
endif

" save cursor and screen positions
" pair up this function with s:RestorePositions
if !exists('*s:SavePositions')
    function s:SavePositions()
        " cursor pos
        let cursor = getpos('.')

        " screen pos
        normal! H
        let screen = getpos('.')

        return [screen, cursor]
    endfunction
endif

" restore cursor and screen positions
" pair up this function with s:SavePositions
if !exists('*s:RestorePositions')
    function s:RestorePositions(pos)
        " screen
        call setpos('.', a:pos[0])

        " cursor
        normal! zt
        call setpos('.', a:pos[1])
    endfunction
endif

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
