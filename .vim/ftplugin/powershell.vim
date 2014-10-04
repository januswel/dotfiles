" vim ftplugin file
" Filename:     powershell.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" License:      MIT License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   https://github.com/januswel/dotfiles/blob/master/LICENSE

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
setlocal formatoptions-=t
setlocal formatoptions+=rol

setlocal comments=sr:<#,mb:*,ex:#>,:#

" variables {{{2
let b:undo_ftplugin = 'setlocal ' . join([
            \   'formatoptions<',
            \   'comments<',
            \ ])

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
