" vim '%:p:h:t' file
" Filename:     '%:t'
" Language:     <Example>
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.10
" Dependency:
"   This plugin requires following files
"
"   autoload/jwlib/example.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/example.vim
"
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_example')
    finish
endif
let loaded_example = 1

" check if this ftplugin is already loaded or not
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" check vim has required features
if !(has('win32') && exists('&guifont'))
    finish
endif

" check the system has the required command
if !executable('ls')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" commands {{{2
" use exists() to check the command is already defined or not
" return value 2 tells that the command matched completely exists
if exists(':Example') != 2
    command -nargs=0 -range=% -bang Example call <SID>Example
endif

" mappings {{{2
" check global variables that specify the plugin is allowed to define mappings
if !(exists('no_plugin_maps') && no_plugin_maps)
            \ && !(exists('no_example_maps') && no_example_maps)

    " hasmapto() and <unique> are required to avoid overlap
    if !hasmapto('<Plug>Example')
        nmap <unique><Leader>example <Plug>Example
    endif
endif

" <script> and <SID> are used by vim internally
" consider to use :silent if you inhibit messages from vim
nnoremap <silent><Plug>Example :call <SID>Example

" functions {{{2
function! s:Example(...)
    if empty(a:000)
        throw 'There is no argument.'
    elseif a:0 > 1
        throw 'Too many arguments: ' . string(a:000)
    endif

    echo a:1
endfunction

" autocmds {{{2
augroup example
    autocmd! example

    autocmd FileType vim :echo 'Example'
    autocmd BufNew,BufReadPost *.vim :echo 'Example'
augroup END

" stuffs {{{2
" get the character under the cursor, byte / multibyte
call getline('.')[col('.') - 1]
call matchstr(getline('.'), '.', col('.') - 1)

" change encoding
if has('iconv')
    call iconv('something', &encoding, 'utf-8')
endif

" converting exceptions that are thrown by Vim
" see :help catch-errors
call substitute(v:exception, '^Vim.*:\(E\d\+\)', '\1', 'I')

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
