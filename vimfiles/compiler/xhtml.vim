" Vim compiler file
" Compiler:     xhtml
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/11 11:34:59.
" Version:      0.12

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
