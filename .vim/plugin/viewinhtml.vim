" vim plugin file
" Filename:     viewinhtml.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.18
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
if exists('loaded_viewinhtml')
    finish
endif
let loaded_viewinhtml = 1

" check vim has required features
if !(has('win32') && has('multi_byte'))
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" commands {{{2
if exists(':ViewInHtml') != 2
    command -nargs=0 -range=% ViewInHtml
                \ <line1>,<line2>call s:ViewInHtml()
endif

" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
    \ && !(exists('no_viewinhtml_maps') && no_viewinhtml_maps)

    if !hasmapto('<Plug>ViewInHtml', 'n')
        nmap <unique><Leader>vh <Plug>ViewInHtml
    endif
endif
nnoremap <silent><Plug>ViewInHtml
            \ :%call <SID>ViewInHtml()<CR>

" functions {{{2
function! s:ViewInHtml() range
    " assertion
    if exists(':TOhtml') != 2
        throw 'command ":TOhtml" is required'
    endif

    let save_shellslash = &shellslash
    if jwlib#shell#GetType() ==# 'cmd'
        " with "cmd.exe", dir delimiter is "\"
        set noshellslash
    else
        set shellslash
    endif

    try
        " generate html
        execute printf('%d,%dTOhtml', a:firstline, a:lastline)

        " when generating html is succeeded, current window will be the one
        " that has generated html.
        if &filetype =~? 'html'
            " change file path and write it
            let tempfile = tempname() . '.html'
            silent execute 'saveas!' tempfile

            " browse html with default http user agent
            let filename = iconv(
                        \   tempfile,
                        \   &encoding,
                        \   jwlib#shell#GetEncoding()
                        \ )
            let filename = shellescape(filename)
            silent call system(filename)

            " delete the buffer and comb out it from the buffer list
            bdelete
        endif
    catch
        echoerr v:exception
    finally
        " be sure and restore the value of 'shellslash'
        let &shellslash = save_shellslash
    endtry
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
