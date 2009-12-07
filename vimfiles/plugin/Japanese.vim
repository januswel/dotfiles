" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/08 02:05:58.
" Version:      0.12
" Remark:       decision fileencoding and ambiwidth

" if Japanese is not contained, set fileencoding to value of encoding
if has('autocmd')
    function! s:ReCheckFileEncoding()
        if &fileencoding != &encoding && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding = &encoding
        endif
    endfunction

    augroup ReCheckFileEncoding
        autocmd! ReCheckFileEncoding
        autocmd BufReadPost * call s:ReCheckFileEncoding()
    augroup END
endif

" for East Asia double width characters
if exists('&ambiwidth')
    set ambiwidth=double
endif

" vim: ts=4 sw=4 sts=0 et
