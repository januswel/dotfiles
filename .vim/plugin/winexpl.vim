" vim plugin file
" Filename:     winexpl.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.51
" Dependency:
"   This plugin needs following files
"
"   autoload/jwlib/shell.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/shell.vim
"
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_winexpl')
    finish
endif
let loaded_winexpl = 1

" check vim has required features
if !(has('win32') && has('multi_byte') && has('modify_fname'))
    finish
endif

" check the system has the required command
if !executable('explorer.exe')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" commands {{{2
if exists(':WinExplorer') != 2
    command -nargs=? -complete=file WinExplorer
                \ call s:WinExplorer('<args>')
endif

" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
    \ && !(exists('no_winexpl_maps') && no_winexpl_maps)

    if !hasmapto('<Plug>WinExplorer')
        nmap <unique><Leader>we <Plug>WinExplorer
    endif
endif
nnoremap <silent><Plug>WinExplorer
            \ :call <SID>WinExplorer()<CR>

" constants {{{2
let s:cmd = '!start explorer.exe'
lockvar s:cmd
let s:opt = '/select,'
lockvar s:opt

" functions {{{2
function! s:WinExplorer(...)
    let save_shellslash = &shellslash
    if jwlib#shell#GetType() ==# 'cmd'
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
                let path = getcwd()
            endif
        else
            let path = fnamemodify(a:1, ':p')
        endif

        if isdirectory(path)
            " when path is directory
            let dir = 1
        endif

        if exists('dir')
            let cmd = s:cmd . ' ' . shellescape(path)
        else
            let cmd = s:cmd . ' ' . s:opt . shellescape(path)
        endif

        let cmd = iconv(cmd, &encoding, jwlib#shell#GetEncoding())
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
