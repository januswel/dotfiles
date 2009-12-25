" vim autoload file
" Filename:     xterm256.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/26 00:48:16.
" Version:      0.10
" Dependency:
"   This plugin needs following files
"
"   * autoload/color/rgb.vim
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/color/rgb.vim
"
" Refer:
"   http://d.hatena.ne.jp/kakurasan/20080701/p1
"   http://d.hatena.ne.jp/kakurasan/20080703
"
" Remark: {{{1
"   utility function to treat xterm 256 colors
"
"   * color#xterm256#Nr2RGB({nr})
"       return a String in the form of non-capital "#rrggbb".
"
"   * color#xterm256#RGB2Nr({somethinglikeRGB})
"       return a Number that is a xterm color number correspond to specified
"       RGB values. {somethinglikeRGB} is explained by autoload/color/rgb.vim.

" preparations {{{1
" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" constants {{{2
" another script local variable: s:xterm_256colors is defined by the following.

" 256 colors
" the first is 0 and the last is 255
unlockvar s:nr_first
let s:nr_first = 0
lockvar s:nr_first

unlockvar s:nr_last
let s:nr_last = 255
lockvar s:nr_last

" the range of a color value
" lower is 0 and upper is 255
unlockvar s:color_lower
let s:color_lower = 0
lockvar s:color_lower

unlockvar s:color_upper
let s:color_upper = 255
lockvar s:color_upper

" for base16 colors
unlockvar s:base16colors
let s:base16colors = [
            \           [0,    0,    0],
            \           [0xcd, 0,    0],
            \           [0,    0xcd, 0],
            \           [0xcd, 0xcd, 0],
            \           [0,    0,    0xee],
            \           [0xcd, 0,    0xcd],
            \           [0,    0xcd, 0xcd],
            \           [0xe5, 0xe5, 0xe5],
            \           [0x7f, 0x7f, 0x7f],
            \           [0xff, 0,    0],
            \           [0,    0xff, 0],
            \           [0xff, 0xff, 0],
            \           [0x5c, 0x5c, 0xff],
            \           [0xff, 0,    0xff],
            \           [0,    0xff, 0xff],
            \           [0xff, 0xff, 0xff],
            \        ]
lockvar s:base16colors

unlockvar s:numof_base16colors
let s:numof_base16colors = len(s:base16colors)
lockvar s:numof_base16colors

" for grayscale colors
unlockvar s:grayscale_tones
let s:grayscale_tones = [
            \       0x08, 0x12, 0x1C, 0x26, 0x30, 0x3A,
            \       0x44, 0x4E, 0x58, 0x62, 0x6C, 0x76,
            \       0x80, 0x8A, 0x94, 0x9E, 0xA8, 0xB2,
            \       0xBC, 0xC6, 0xD0, 0xDA, 0xE4, 0xEE
            \     ]
lockvar s:grayscale_tones

unlockvar s:grayscale_offset
let s:grayscale_offset = 232
lockvar s:grayscale_offset

" for colorcube colors
unlockvar s:colorcube_levels
let s:colorcube_levels = [0, 0x5f, 0x87, 0xaf, 0xd7, 0xff]
lockvar s:colorcube_levels

unlockvar s:colorcube_offset
let s:colorcube_offset = 16
lockvar s:colorcube_offset

unlockvar s:coefficient_red
let s:coefficient_red = 36
lockvar s:coefficient_red

unlockvar s:coefficient_green
let s:coefficient_green = 6
lockvar s:coefficient_green

unlockvar s:coefficient_blue
let s:coefficient_blue = 1
lockvar s:coefficient_blue

" functions {{{2
function! color#xterm256#Nr2RGB(nr)
    return color#rgb#List2Str(s:Nr2RGB(a:nr))
endfunction

" search the one has shortest distance
function! color#xterm256#RGB2Nr(...)
    " normalize to a List
    let rgb = call('color#rgb#Normalize2List', a:000)

    return s:SearchShortestDistance(rgb)
endfunction

" stuff functions {{{2
function! s:Nr2RGB(nr)
    " assertions
    if type(a:nr) != 0 || a:nr < s:nr_first || s:nr_last < a:nr
        throw 'An argument must be a Number and it is from 0 to 255.'
    endif

    " base16 colors
    if a:nr < s:numof_base16colors
        return s:base16colors[a:nr]
    endif

    " grayscale colors
    if s:grayscale_offset <= a:nr
        let tone = s:grayscale_tones[a:nr - s:grayscale_offset]
        return [tone, tone, tone]
    endif

    " colorcube colors
    return s:ColorCube2RGB(a:nr)
endfunction

" xterm color number is given by the following expression
" nr = Cr * r + Cg * g + Cb * b + offset
" Cr > Cg > Cb
" Cr: coefficient of red
" Cg: coefficient of green
" Cb: coefficient of blue
" r:  a value of red
" g:  a value of green
" b:  a value of blue
function! s:ColorCube2RGB(nr)
    let nr = a:nr - s:colorcube_offset

    let red = nr / s:coefficient_red
    let nr -= s:coefficient_red * red

    let green = nr / s:coefficient_green
    let nr -= s:coefficient_green * green

    let blue = nr / s:coefficient_blue

    return        [
                \   s:colorcube_levels[red],
                \   s:colorcube_levels[green],
                \   s:colorcube_levels[blue],
                \ ]
endfunction

function! s:SearchShortestDistance(rgb)
    " at this point, longest distance must be setted to this variable.
    " 3 is for cubic
    let shortest = pow(s:color_upper - s:color_lower, 2) * 3 + 1
    " an imitation of the index of s:xterm_256colors
    let idx = 0
    for basis in s:xterm_256colors
        let distance = s:CalcCubicDistance(a:rgb, basis)
        if distance < shortest
            " cache the index (is xterm color number) has a shortest distance
            let shortest = distance
            let nr = idx
        endif

        let idx += 1
    endfor

    if exists('nr')
        return nr
    else
        throw 'Not found due to an unknown issue: ' . a:rgb
    endif
endfunction

" manually in-line expansion for cubic
function! s:CalcCubicDistance(p, q)
    return          pow(a:p[0] - a:q[0], 2)
                \ + pow(a:p[1] - a:q[1], 2)
                \ + pow(a:p[2] - a:q[2], 2)
endfunction

" build a List has RGB Lists
function! s:BuildXterm256Colors()
    let result = []
    for nr in range(s:nr_first, s:nr_last)
        call add(result, s:Nr2RGB(nr))
    endfor
    return result
endfunction

" execute codes
unlockvar s:xterm_256colors
let s:xterm_256colors = s:BuildXterm256Colors()
lockvar s:xterm_256colors

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
