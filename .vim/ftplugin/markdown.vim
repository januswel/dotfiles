" vim ftplugin file
" Filename:     markdown.vim
" Language:     vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.10
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
" options {{{2
setlocal shiftwidth=4
setlocal tabstop=4

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
