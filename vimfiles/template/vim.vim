" vim '%:p:h:t' file
" Filename:     '%:t'
" Language:     <Example>
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 30.
" Version:      0.10
" License:      VIM LICENSE.  See |license|.
" Dependency:
"   This plugin requires following files
"
"   autoload/example.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/example.vim

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_example')
    finish
endif
let loaded_example = 1

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
" define functions
function! Example()
    " some codes
endfunction

" autocmd
augroup Example
    autocmd! Example

    autocmd FileType vim :echo 'Example'
    autocmd BufNew,BufReadPost *.vim :echo 'Example'
augroup END

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
