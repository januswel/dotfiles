" vim plugin file
" Filename:     openwin32explorer.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/28 02:51:30.
" Version:      0.41
" Dependency:
"   This plugin needs following files
"
"   * autoload/shell.vim
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/shell.vim
"
" Remark:       contribute command to open explorer.exe of win32.

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_openwin32explorer')
    finish
endif
let loaded_openwin32explorer = 1

" check vim has required features
if !(has('win32') && has('multi_byte') && has('modify_fname'))
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" commands {{{2
if exists(':OpenWin32Explorer') != 2
    command -nargs=? -complete=dir OpenWin32Explorer
                \ call s:OpenWin32Explorer('<args>')
endif

" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
    \ && !(exists('no_win32util_maps') && no_example_maps)

    if !hasmapto('<Plug>OpenWin32Explorer')
        nmap <unique><Leader>oe <Plug>OpenWin32Explorer
    endif
endif
nnoremap <silent><Plug>OpenWin32Explorer
    \ :call <SID>OpenWin32Explorer()<CR>

" functions {{{2
function! s:OpenWin32Explorer(...)
    let save_shellslash = &shellslash
    if shell#GetType() ==# 'cmd'
        set noshellslash
    else
        set shellslash
    endif

    try
        if empty(a:000)
            " open explorer and select editing file
            let path = expand('%:p')
            if empty(path)
                " when buffer name is empty
                let dir = getcwd()
                unlet path
            endif
        else
            let dir = fnamemodify(a:1, ':p')
        endif

        if exists('dir')
            let cmd = '!start explorer ' . shellescape(dir)
        else
            let cmd = '!start explorer /select,' . shellescape(path)
        endif

        let cmd = iconv(cmd, &encoding, shell#GetEncoding())
        silent execute cmd
    catch
        echoerr v:exception
    finally
        let &shellslash = save_shellslash
    endtry
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
