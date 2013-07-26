" vim after ftplugin file
" Filename:     vim.vim
" Language:     VIM script
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.10
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" main {{{1
if has('win32')
    setlocal tags+=~/vimfiles/tags
else
    setlocal tags+=~/.vim/tags
endif

if exists('b:undo_ftplugin') && !empty(b:undo_ftplugin)
    let b:undo_ftplugin .= '| setlocal tags<'
else
    let b:undo_ftplugin = 'setlocal tags<'
endif

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
