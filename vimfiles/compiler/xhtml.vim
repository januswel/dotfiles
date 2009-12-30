" vim compiler file
" Filename:     xhtml.vim
" Compiler:     xhtml
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.
" Version:      0.13
" License:      New BSD License
"   See LICENSE.  Note that redistribution is permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

if exists('current_compiler')
    finish
endif
let current_compiler = 'xhtml'

if exists(':CompilerSet') != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=tidy\ -raw\ -quiet\ -errors\ --gnu-emacs\ yes\ --accessibility-check\ 3
CompilerSet errorformat=%f:%l:%c:\ %t%*[^:]:\ %m

" vim: ts=4 sw=4 sts=0 et
