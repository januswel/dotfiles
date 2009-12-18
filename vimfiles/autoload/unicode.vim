" vim autoload file
" Filename:     unicode.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/18 14:57:43.
" Version:      0.18
" Refer:        http://d.hatena.ne.jp/krogue/20080616/1213590577
"               http://homepage1.nifty.com/nomenclator/unicode/ucs_utf.htm
" Remark: {{{1
"   This autoload script provides following functions. All functions take the
"   character under the cursor as the target.
"
"   * unicode#GetUtf8ByteSequence()
"       return the list that has numbers of UTF-8 byte sequence
"   * unicode#GetUtf8ByteSequenceStr()
"       return the string of UTF-8 byte sequence
"   * unicode#GetUnicodeCodePoint()
"       return the number of Unicode code point
"   * unicode#GetPattern({type})
"       return the search pattern of the character. See |/\%x| |/\%u| |/\%U|.
"       {type} can be one of following values:
"
"       "x"         A string in form of "\%x.."
"       "u" or "U"  A string in form of "\%u...." or "\%U........"
"                 Appropreate one will be chosen.
"
"       Calling with no arguments is possible, then return a string in form of
"       "\%x..".
"   * unicode#GetLiteral({type})
"       return the literal of the character. See |expr-quote|. {type} can be
"       one of following values:
"
"       "x"         A string in form of "\x.."
"       "X"         A string in form of "\X.."
"       "u"         A string in form of "\u...."
"       "U"         A string in form of "\U...."
"
"       Calling with no arguments is possible, then return a string in form of
"       "\%x..".

" preparation {{{1
" check vim has the required feature
if !has('multi_byte')
    echoerr 'Vim does not have the required feature +multi_byte.'
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" for display {{{2
" like the normal command "g8"
function! unicode#GetUtf8ByteSequenceStr()
    let utf8 = unicode#GetUtf8ByteSequence()
    let result = []
    for byte in utf8
        call add(result, printf('%02x', byte))
    endfor
    return join(result)
endfunction

" return the pattern in form of "\%x..", "\%u...." and "\%U........"
function! unicode#GetPattern(...)
    if empty(a:000) || a:1 ==# 'x'
        let result = []
        for byte in unicode#GetUtf8ByteSequence()
            call add(result, printf('\%%x%02x', byte))
        endfor
        return join(result, '')
    elseif a:1 ==? 'u'
        let unicode = unicode#GetUnicodeCodePoint()
        if unicode <= 0xffff
            return printf('\%%u%04x', unicode)
        else
            return printf('\%%U%08x', unicode)
        endif
    endif
endfunction

" return the literal in form of "\x..", "\X..", "\u...." or "\U...."
" see :help expr-quote
function! unicode#GetLiteral(...)
    if empty(a:000)
        return s:GetTwoHexadecimalLiteral(0)
    elseif a:1 ==# 'x'
        return s:GetTwoHexadecimalLiteral(0)
    elseif a:1 ==# 'X'
        return s:GetTwoHexadecimalLiteral(1)
    elseif a:1 ==? 'u'
        let unicode = unicode#GetUnicodeCodePoint()
        if unicode <= 0xffff
            return printf('\%s%04x', a:1, unicode)
        else
            echoerr printf(
                \ "Can't convert to a literal in form \\u: U+%08x",
                \ unicode)
        endif
    endif
endfunction

" stuff
function! s:GetTwoHexadecimalLiteral(case)
    let template = a:case ? '\X%02x' : '\x%02x'
    let result = []
    for byte in unicode#GetUtf8ByteSequence()
        call add(result, printf(template, byte))
    endfor

    return join(result, '')
endfunction

" about UTF-8 byte sequence {{{2
function! unicode#GetUtf8ByteSequence()
    let char = matchstr(getline('.'), '.', col('.') - 1)
    if char == ''
        return [0]
    endif

    let bytes = iconv(char, &encoding, 'utf-8')
    let numof = strlen(bytes)
    let result = []
    let i = 0
    while i < numof
        call add(result, char2nr(bytes[i]))
        let i += 1
    endwhile

    return result
endfunction

" about Unicode code point {{{2
function! unicode#GetUnicodeCodePoint()
    " inverse transform to Unicode code point
    let utf8 = unicode#GetUtf8ByteSequence()
    let idx = len(utf8) - 1
    " the condition is determined by a number of byte sequence
    let conditions = s:conditions[idx]

    " check if the byte sequence is valid or not
    for condition in conditions
        let i = 0
        for [lower, upper] in condition
            if (lower <= utf8[i]) || (utf8[i] <= upper)
                return s:funcs[idx](utf8)
            endif
            let i += 1
        endfor
    endfor

    throw 'Found the malformed utf-8 byte sequence: ' . utf8
endfunction

" stuff
function! s:OneByteToUnicode(utf8)
    " 0xxxxxxx -> 00000000-0xxxxxxx
    return a:utf8[0]
endfunction
function! s:TwoBytesToUnicode(utf8)
    " 110xxxxx 10yyyyyy -> 00000xxx-xxyyyyyy
    return  s:RS(s:LS(a:utf8[0], 0x08), 0x20) * 0x0100
        \ + s:LS(a:utf8[0], 0x40) + s:RS(s:LS(a:utf8[1], 0x04), 0x04)
endfunction
function! s:ThreeBytesToUnicode(utf8)
    " 1110xxxx 10yyyyyy 10zzzzzz -> xxxxyyyy-yyzzzzzz
    return  (s:LS(a:utf8[0], 0x10) + s:RS(s:LS(a:utf8[1], 0x04), 0x10)) * 0x0100
        \ +  s:LS(a:utf8[1], 0x40) + s:RS(s:LS(a:utf8[2], 0x04), 0x04)
endfunction
function! s:FourBytesToUnicode(utf8)
    " 11110www 10xxxxxx 10yyyyyy 10zzzzzz -> 00000000-000wwwxx-xxxxyyyy-yyzzzzzzz
    return  (s:RS(s:LS(a:utf8[0], 0x20), 0x08) + s:RS(s:LS(a:utf8[1], 0x04), 0x40)) * 0x010000
        \ + (s:LS(a:utf8[1], 0x10) + s:RS(s:LS(a:utf8[2], 0x04), 0x10)) * 0x0100
        \ +  s:LS(a:utf8[1], 0x40) + s:RS(s:LS(a:utf8[2], 0x04), 0x04)
endfunction

" left shift (8 bits)
function! s:LS(nr, bits)
    return a:nr * a:bits % 0x0100
endfunction
" right shift
function! s:RS(nr, bits)
    return a:nr / a:bits
endfunction

" constants
" the List that has Funcrefs to calculate Unicode code point
let s:funcs = [
                \ function('s:OneByteToUnicode'),
                \ function('s:TwoBytesToUnicode'),
                \ function('s:ThreeBytesToUnicode'),
                \ function('s:FourBytesToUnicode'),
            \ ]
lockvar s:funcs

" conditions that be used to check if the byte sequence are valid or not
let s:conditions = [
            \ [[[0, 0x7f]]],
            \ [[[0xc2, 0xdf], [0x80, 0xbf]]],
            \ [
                \ [[0xe0, 0xe0], [0xa0, 0xbf], [0x80, 0xbf]],
                \ [[0xe1, 0xec], [0x80, 0xbf], [0x80, 0xbf]],
                \ [[0xed, 0xed], [0x80, 0x9f], [0x80, 0xbf]],
                \ [[0xee, 0xef], [0x80, 0xbf], [0x80, 0xbf]],
            \ ],
            \ [
                \ [[0xf0, 0xf0], [0x90, 0xbf], [0x80, 0xbf], [0x80, 0xbf]],
                \ [[0xf1, 0xf3], [0x80, 0xbf], [0x80, 0xbf], [0x80, 0xbf]],
                \ [[0xf4, 0xf4], [0x80, 0x8f], [0x80, 0xbf], [0x80, 0xbf]],
            \ ],
        \ ]
lockvar s:conditions

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
