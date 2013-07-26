" vim ftplugin file
" Filename:     avisynth.vim
" Language:     AviSynth
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.16
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparation {{{1
if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
            \ && !(exists('no_ftavisynth_maps') && no_example_maps)
    if !hasmapto('<Plug>VirtualDub', 'n')
        nmap <unique><buffer><LocalLeader>v
                    \ <Plug>VirtualDub
    endif

    if !hasmapto('<Plug>X264YouTube', 'n')
        nmap <unique><buffer><LocalLeader>xy
                    \ <Plug>X264YouTube
    endif

    if !hasmapto('<Plug>X264Nico', 'n')
        nmap <unique><buffer><LocalLeader>xn
                    \ <Plug>X264Nico
    endif

    if !hasmapto('<Plug>LameCBR192', 'n')
        nmap <unique><buffer><LocalLeader>lc
                    \ <Plug>LameCBR192
    endif

    if !hasmapto('<Plug>LameV2', 'n')
        nmap <unique><buffer><LocalLeader>lv
                    \ <Plug>LameVBR190
    endif
endif

nnoremap <script><silent><buffer><Plug>VirtualDub
            \ :silent !start virtualdub "%"<CR>
nnoremap <script><silent><buffer><Plug>X264YouTube
            \ :silent !start x264_2pass_youtube.bat "%"<CR>
nnoremap <script><silent><buffer><Plug>X264Nico
            \ :silent !start x264_2pass_nico.bat "%"<CR>
nnoremap <script><silent><buffer><Plug>LameCBR192
            \ :silent !start lame_cbr_192.bat "%"<CR>
nnoremap <script><silent><buffer><Plug>LameVBR190
            \ :silent !start lame_vbr_190.bat "%"<CR>

" options {{{2
" AviSynth recognize only cp932 and CRLF
setlocal fileencoding=cp932
setlocal fileformat=dos

" indent options
setlocal formatoptions=croql
setlocal cindent
setlocal cinoptions=(0,u0,W4,m1
setlocal comments=s1:[*,mb:*,ex:*],s1:/*,mb:*,ex:*/,:#

" compiler {{{2
" for make
compiler avisynth

" undo {{{2
let b:undo_ftplugin = 'setlocal fenc< ff< fo< cin< cino< com<'

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
