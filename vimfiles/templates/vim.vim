" Vim (ftplugin|plugin|syntax) file
" Language:     <Example>
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/25 23:19:01.
" Version:      0.10
" Remark:       <Example>

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

" vim: ts=4 sw=4 sts=0 et
