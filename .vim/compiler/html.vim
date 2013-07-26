" vim compiler file
" Filename:     html.vim
" Compiler:     html
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.10
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

if exists('current_compiler')
    finish
endif
let current_compiler = 'html'

if exists(':CompilerSet') != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=tidy\ -raw\ -quiet\ -errors\ --gnu-emacs\ yes\ --accessibility-check\ 3\ --new-blocklevel-tags\ svg,circle
CompilerSet errorformat=%f:%l:%c:\ %t%*[^:]:\ %m

" vim: ts=4 sw=4 sts=0 et
