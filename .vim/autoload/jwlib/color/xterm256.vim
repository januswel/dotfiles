" vim autoload file
" Filename:     xterm256.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.25
" Dependency:
"   This plugin needs following files
"
"   autoload/jwlib/color/rgb.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/color/rgb.vim
"
" Refer:
"   http://d.hatena.ne.jp/kakurasan/20080701/p1
"   http://d.hatena.ne.jp/kakurasan/20080703
"
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" constants {{{2
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
            \       0x08, 0x12, 0x1c, 0x26, 0x30, 0x3a,
            \       0x44, 0x4e, 0x58, 0x62, 0x6c, 0x76,
            \       0x80, 0x8a, 0x94, 0x9e, 0xa8, 0xb2,
            \       0xbc, 0xc6, 0xd0, 0xda, 0xe4, 0xee
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
function! jwlib#color#xterm256#Nr2RGB(nr)
    return jwlib#color#rgb#List2Str(s:Nr2RGB(a:nr))
endfunction

function! jwlib#color#xterm256#RGB2Nr(...)
    " normalize to a List
    let rgb = call('jwlib#color#rgb#Normalize2List', a:000)

    " search the one has shortest distance
    return s:SearchShortestDistance(rgb)
endfunction

" stuff functions {{{2
" for jwlib#color#xterm256#Nr2RGB() {{{3
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

" for jwlib#color#xterm256#RGB2Nr() {{{3
function! s:SearchShortestDistance(rgb)
    let [b16_nr, b16_d] = s:SearchBase16Colors(a:rgb)
    if b16_d == 0
        return b16_nr
    endif

    let [gs_nr, gs_d] = s:SearchGrayScaleColors(a:rgb)
    if gs_d == 0
        return gs_nr
    endif

    let [cc_nr, cc_d] = s:SearchColorCubeColors(a:rgb)

    " youngest number is prior
    if b16_d <= cc_d && b16_d <= gs_d
        return b16_nr
    elseif cc_d <= gs_d
        return cc_nr
    else
        return gs_nr
    endif

    throw 'Unknown issue'
endfunction

function! s:SearchBase16Colors(rgb)
    " manually in-line expansion
    let distances = map(copy(s:base16colors),
                \       'abs(a:rgb[0] - v:val[0])'
                \   . '+ abs(a:rgb[1] - v:val[1])'
                \   . '+ abs(a:rgb[2] - v:val[2])')
    let nr = index(distances, min(distances))
    return [nr, distances[nr]]
endfunction

function! s:SearchGrayScaleColors(rgb)
    " manually in-line expansion
    let distances = map(copy(s:grayscale_tones),
                \       'abs(a:rgb[0] - v:val)'
                \   . '+ abs(a:rgb[1] - v:val)'
                \   . '+ abs(a:rgb[2] - v:val)')
    let nr = index(distances, min(distances))
    return [nr + s:grayscale_offset, distances[nr]]
endfunction

function! s:SearchColorCubeColors(rgb)
    " manually in-line expansion from function
    let distances = map(copy(s:colorcube_levels),
                \       'abs(a:rgb[0] - v:val)')
    let r = index(distances, min(distances))
    let distances = map(copy(s:colorcube_levels),
                \       'abs(a:rgb[1] - v:val)')
    let g = index(distances, min(distances))
    let distances = map(copy(s:colorcube_levels),
                \       'abs(a:rgb[2] - v:val)')
    let b = index(distances, min(distances))

    " see comments of s:ColorCube2RGB() for details of this expression
    let nr =        s:coefficient_red   * r
                \ + s:coefficient_green * g
                \ + s:coefficient_blue  * b
                \ + s:colorcube_offset

    " manually in-line expansion
    let distance =   abs(a:rgb[0] - s:colorcube_levels[r])
                \  + abs(a:rgb[1] - s:colorcube_levels[g])
                \  + abs(a:rgb[2] - s:colorcube_levels[b])

    return [nr, distance]
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=4
