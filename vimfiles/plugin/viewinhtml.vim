" vim plugin file
" Filename:     viewinhtml.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 03.
" Version:      0.13
" License:      New BSD License
"   See LICENSE.  Note that redistribution is permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" Dependency:
"   This plugin needs following files
"
"   * autoload/jwlib/shell.vim
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/shell.vim
"
" Remark: {{{1
"   This plugin provides the command and mappings to show contents of the
"   current buffer in your favorite http user agent (web browser).
"
"                                                       *:ViewInHtml*
"   :{range}ViewInHtml
"                       Show contents of the current buffer in your favorite
"                       http user agent (web browser). {range} is line number
"                       to show. When {range} is not specified, target is all
"                       of contents.
"
"                                                       *<Plug>ViewInHtml*
"   <Plug>ViewInHtml
"                       An internal mapping in normal mode. Same as
"                       |:ViewInHtml| but target is the all of contents.
"
"   <Leader>vh
"                       When there is no mappings with |<Plug>ViewInHtml|, this
"                       will be mapped to <Plug>ViewInHtml, .

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
                \ <line1>,<line2>call s:ViewInHtmlSS()
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

" constants {{{2
" g:html_font
"   set your favorite font
" g:html_ignore_folding
"   expand fold and convert
" g:html_no_pre
"   use br elements instead of pre elements
" g:html_number_lines
"   if this variable is undefined, the value of 'number' is used.
"   force to display line number
" g:html_use_encoding
"   set the same encoding as 'fileencoding'
let s:defaults = {
            \   'g:html_font':            '"VL Gothic"',
            \   'g:html_ignore_folding':  1,
            \   'g:html_no_pre':          1,
            \   'g:html_number_lines':    1,
            \   'g:html_use_css':         1,
            \   'g:html_use_encoding':    '&encoding',
            \   'g:use_xhtml':            1,
            \ }
lockvar s:defaults

" functions {{{2
" main function
" wrapper function
function! s:ViewInHtml() range
    if exists(':TOhtml') != 2
        throw 'command ":TOhtml" is required'
    endif

    let save_shellslash = &shellslash
    if jwlib#shell#GetType() ==# 'cmd'
        set noshellslash
    else
        set shellslash
    endif

    try
        " setup
        let unletvars = s:SetupTOhtmlVariables(s:defaults)
        " generate html
        execute printf('%d,%dTOhtml', a:firstline, a:lastline)
        " clean up
        call s:CleanupTOhtmlVariables(unletvars)

        " if generating html is succeeded, current window will be the one that
        " has generated html.
        if &filetype =~? 'html'
            " change file path and write it
            let tempfile = tempname() . '.html'
            silent execute 'saveas!' tempfile

            " browse html with default UA
            let filename = iconv(
                        \   tempfile,
                        \   &encoding,
                        \   jwlib#shell#GetEncoding()
                        \ )
            let filename = shellescape(filename)
            silent call system(filename)

            " delete the buffer and comb out it from buffer list
            bdelete
        endif
    catch
        echoerr v:exception
    finally
        let &shellslash = save_shellslash
    endtry
endfunction

" settings for :TOhtml
function! s:SetupTOhtmlVariables(defaults)
    let unletvars = []
    for name in keys(a:defaults)
        if !exists(name)
            call add(unletvars, name)
            execute 'let' name '=' a:defaults[name]
        endif
    endfor
    return unletvars
endfunction

" unlet variables that are defined by this script
function! s:CleanupTOhtmlVariables(vars)
    for var in a:vars
        if exists(var)
            execute 'unlet' var
        endif
    endfor
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
