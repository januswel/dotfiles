" vim autoload file
" Filename:     rgb.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 03.
" Version:      0.17
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions {{{2
function! jwlib#color#rgb#Normalize2List(...)
    " assertions {{{3
    if empty(a:000)
        throw 'There are no arguments.'
    endif " }}}3

    let rgblist = []
    for arg in a:000
        let typeofarg = type(arg)
        if     typeofarg == 0   " Number {{{3
            if s:IsValidNr(arg)
                call add(rgblist, arg)
                if len(rgblist) == 3
                    return rgblist
                endif
            else
                throw 'Out of RGB value: ' . string(arg)
            endif
        elseif typeofarg == 1   " String {{{3
            if arg =~# '\v^#%(\x{3}|\x{6})$'
                " the form of "#rgb" or "#rrggbb"
                return s:Str2List(arg[1:])
            elseif arg =~# '\v^\x{6}$'
                " the form of "rrggbb"
                return s:Str2List(arg)
            elseif arg =~# '\v^0x\x+$'
                " the form of "0x.."
                let nr = str2nr(arg, 16)
                if s:IsValidNr(nr)
                    call add(rgblist, nr)
                    if len(rgblist) == 3
                        return rgblist
                    endif
                endif
            elseif arg =~# '\v^\d+$'
                let nr = str2nr(arg, 10)
                if s:IsValidNr(nr)
                    call add(rgblist, nr)
                    if len(rgblist) == 3
                        return rgblist
                    endif
                endif
            else
                throw 'Unknown form: ' . string(arg)
            endif
        elseif typeofarg == 3   " List {{{3
            " assertion
            if !empty(rgblist)
                throw 'Too many arguments: ' . string(a:000)
            endif

            " FIXME: kludge
            " catch exceptions and rethrow those in order to avoid E171.
            try
                " recursive call
                return call('jwlib#color#rgb#Normalize2List', arg)
            catch
                throw v:exception
            endtry
        elseif typeofarg == 4   " Dictionary {{{3
            " assertion
            if !empty(rgblist)
                throw 'Too many arguments: ' . string(a:000)
            endif

            " FIXME: kludge
            " catch exceptions and rethrow those in order to avoid E171.
            try
                return s:Dict2List(arg)
            catch
                throw v:exception
            endtry
        else                    " Others {{{3
            " other types are invalid
            throw 'Unsupposed type: ' . string(arg)
            " }}}3
        endif

        " This is required for a List within the a:000
        unlet arg
    endfor

    throw 'Too few arguments: ' . string(a:000)
endfunction

function! jwlib#color#rgb#List2Str(rgb, ...)
    " assertions {{{3
    if type(a:rgb) != 3 || len(a:rgb) != 3
        throw 'A List that has 3 Number items is required'
    endif
    for color in a:rgb
        if type(color) != 0
            throw 'A List that has 3 Number items is required'
        endif
    endfor

    " option analysis {{{3
    let sharp = 0
    let capital = 0
    let tri = 0
    if empty(a:000)
        " default
        " the form of "#rrggbb"
        let sharp = 1
    else
        for char in split(a:1, '\zs')
            if char ==# '#'
                " the cap "#" is added
                let sharp = 1
            elseif char ==# 'x'
                " non-capital
                let capital = 0
            elseif char ==# 'X'
                " capital
                let capital = 1
            elseif char ==# '3'
                " the form of "rgb"
                let tri = 1
            elseif char ==# '6'
                " the form of "rrggbb"
                let tri = 0
            else
                throw 'Unknown option: ' . char
            endif
        endfor
    endif

    " build template {{{3
    let template = ''
    if sharp
        let template .= '#'
    endif
    if tri
        let template .= '%x%x%x'
    else
        let template .= '%02x%02x%02x'
    endif
    if capital
        let template = substitute(template, 'x', 'X', 'g')
    endif " }}}3

    " formatting
    if tri
        return printf(template,
                    \ a:rgb[0] / 16,
                    \ a:rgb[1] / 16,
                    \ a:rgb[2] / 16)
    else
        return printf(template, a:rgb[0], a:rgb[1], a:rgb[2])
    endif
endfunction

" stuff functions {{{2
function! s:Str2List(rgb)
    let length = len(a:rgb)
    if length == 6
        return        [
                    \   str2nr(a:rgb[0:1], '16'),
                    \   str2nr(a:rgb[2:3], '16'),
                    \   str2nr(a:rgb[4:5], '16'),
                    \ ]
    elseif length == 3
        return        [
                    \   str2nr(a:rgb[0], '16') * 16,
                    \   str2nr(a:rgb[1], '16') * 16,
                    \   str2nr(a:rgb[2], '16') * 16,
                    \ ]
    endif

    throw 'Unknown form: ' . string(a:rgb)
endfunction

function! s:Dict2List(rgb)
    for key in keys(a:rgb)
        if key ==? 'r' || key ==? 'red'
            if !exists('red')
                let red = a:rgb[key]
            else
                throw 'Specifying a red factor overlap: ' . string(a:rgb)
            endif
        elseif key ==? 'g' || key ==? 'green'
            if !exists('green')
                let green = a:rgb[key]
            else
                throw 'Specifying a green factor overlap: ' . string(a:rgb)
            endif
        elseif key ==? 'b' || key ==? 'blue'
            if !exists('blue')
                let blue = a:rgb[key]
            else
                throw 'Specifying a blue factor overlap: ' . string(a:rgb)
            endif
        else
            throw 'Unknown key: ' . key
        endif
    endfor

    if exists('red') && exists('green') && exists('blue')
        return jwlib#color#rgb#Normalize2List(red, green, blue)
    else
        throw 'Too few arguments: ' . string(a:rgb)
    endif
endfunction

function! s:IsValidNr(nr)
    if 0 <= a:nr && a:nr <= 0xff
        return 1
    endif
    return 0
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=4
