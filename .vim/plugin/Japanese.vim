" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/11 08:20:24.
" Version:      0.11
" Remark:       decision encoding and fileencoding[s] and ambiwidth

" detection character encoding automatically
" refer : http://www.kawaz.jp/pukiwiki/?vim#cb691f26
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif

if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'

    " check which iconv can perform eucJP-ms
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    " check which iconv can perform JISX0213
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif

    " build fileencodings
    if &encoding ==# 'utf-8'
        set fileencodings-=cp932
        set fileencodings-=iso-2022-jp-3
        set fileencodings-=eucjp-ms
        set fileencodings-=euc-jisx0213
        let &fileencodings = s:enc_jis . ',' . s:enc_euc . ',cp932,' . &fileencodings
    else
        let &fileencodings = &fileencodings . ',' . s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings . ',' . s:enc_euc
        endif
    endif
    " clear variables
    unlet s:enc_euc
    unlet s:enc_jis
endif

" if Japanese is not contained, set fileencoding to value of encoding
if has('autocmd')
    function! s:ReCheckFileEncoding()
        if &fileencoding != &encoding && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding = &encoding
        endif
    endfunction

    augroup ReCheckFileEncoding
        autocmd! ReCheckFileEncoding
        autocmd BufReadPost * call <SID>ReCheckFileEncoding()
    augroup END
endif

" for East Asia double width characters
if exists('&ambiwidth')
    set ambiwidth=double
endif

" vim: ts=4 sw=4 sts=0 et
