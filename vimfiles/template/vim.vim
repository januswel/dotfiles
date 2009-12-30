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

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
