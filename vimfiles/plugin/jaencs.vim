" jaencs.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/09 23:51:37.
" Version:      0.12
" Remark:       determin 'fileencodings' depending on 'encoding'
"               automatically, with Japanese encodings.
"               work with the file that is one of following encodings.
"                   - utf-8
"                   - cp932
"                   - sjis
"                   - euc-jp
"                   - euc-jisx0213
"                   - eucjp-ms
"                   - iso-2022-jp
"                   - iso-2022-jp-3
" Acknowledgement:
"   thinca
"       He told me the implementation of the value "guess" and show me ropes to
"       specify characters by using byte codes
"           - http://d.hatena.ne.jp/thinca/20091208/1260265376
"           - http://d.hatena.ne.jp/thinca/20091208/1260264053

" preparation {{{1
" check if this plugin is already loaded or not
if exists('loaded_jaencs')
    finish
endif
let loaded_jaencs = 1

" check vim has the required feature
if !(has('iconv') && has('autocmd'))
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main: {{{1
" variables {{{2
" default names of encoding
let s:cp932 = ['cp932']
let s:eucjp = ['euc-jp']
let s:jisx  = ['iso-2022-jp']
let s:bom   = ['ucs-bom']
let s:utf   = ['utf-8']

" functions {{{2
" check if iconv supports JIS X 0213
" "iso-2022-jp-3" is the superset of "iso-2022-jp"
" "eucjp-ms" and "euc-jisx0213" are the superset of "euc-jp"
" but "euc-jp" can be specified the 'encoding'
function! s:CheckIconvCapability()
    " use U+3327 "SQUARE TON" and U+3326 "SQUARE DORU"
    let test_ms   = iconv("\xe3\x8c\xa7\xe3\x8c\xa6", 'utf-8', 'eucjp-ms')
    let test_jisx = iconv("\xe3\x8c\xa7\xe3\x8c\xa6", 'utf-8', 'euc-jisx0213')
    let correct = "\xad\xc5\xad\xcb"
    if test_ms ==# correct
        return [['eucjp-ms', 'euc-jp'], ['iso-2022-jp-3']]
    elseif test_jisx ==# correct
        return [['euc-jisx0213', 'euc-jp'], ['iso-2022-jp-3']]
    else
        return [['euc-jp'], ['iso-2022-jp']]
    endif
endfunction

function! s:FileEncodingSet()
    " the order is important
    " test for a while
    return s:jisx + s:eucjp + s:cp932 + s:bom + s:utf
endfunction

function! s:GetOptimalFileEncodings()
    " get the order of fileencodings
    let result = s:FileEncodingSet()

    " remove the one as same as &encoding
    let idx = match(result, &encoding)
    if idx != -1
        call remove(result, idx)
    endif

    return join(result, ',')
endfunction

" autocmd {{{2
augroup jaencs
    autocmd! jaencs

    autocmd VIMEnter,EncodingChanged *
        \ let &fileencodings = s:GetOptimalFileEncodings()
augroup END

" execute codes {{{2
" once on ahead
let [s:eucjp, s:jisx] = s:CheckIconvCapability()

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
