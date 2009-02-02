" misc functions

" return absolute number
function! Absolute(number)
    return (a:number > 0) ? a:number : a:number * -1
endfunction

" vim: ft=vimperator sw=4 sts=4
