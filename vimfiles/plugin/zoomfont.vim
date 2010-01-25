" vim plugin file
" Filename:     zoomfont.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 25.
" Version:      0.21
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" Remark: {{{1
"   This plugin provides the feature to zoom up and down by changing a font
"   size. This works with only win32 environment.
"
"   Following mappings are provided:
"
"       <Leader>+               zoom in
"       <Leader>-               zoom out
"       <Leader>&               reset to default
"
"   Also internal mappings are:
"
"       <Plug>ZoomFontIn        zoom in
"       <Plug>ZoomFontOut       zoom out
"       <Plug>ZoomFontReset     reset to default
"
"   Additionally following commands are available:
"
"       :ZoomIn                 zoom in
"       :ZoomOut                zoom out
"       :ZoomReset              reset to default

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_zoomfont')
    finish
endif
let loaded_zoomfont = 1

" check vim has required features
if !(has('gui') && exists('&guifont') && has('win32'))
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" commands {{{2
if exists(':ZoomIn') != 2
    command -nargs=0 ZoomIn    call <SID>ZoomIn()
endif
if exists(':ZoomOut') != 2
    command -nargs=0 ZoomOut   call <SID>ZoomOut()
endif
if exists(':ZoomReset') != 2
    command -nargs=0 ZoomReset call <SID>ZoomReset()
endif

" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
            \ && !(exists('no_zoomfont_maps') && no_zoomfont_maps)

    if !hasmapto('<Plug>ZoomIn', 'n')
        nmap <unique><Leader>+ <Plug>ZoomIn
    endif
    if !hasmapto('<Plug>ZoomOut', 'n')
        nmap <unique><Leader>- <Plug>ZoomOut
    endif
    if !hasmapto('<Plug>ZoomReset', 'n')
        nmap <unique><Leader>& <Plug>ZoomReset
    endif
endif

nnoremap <silent><Plug>ZoomIn    :call <SID>ZoomIn()<CR>
nnoremap <silent><Plug>ZoomOut   :call <SID>ZoomOut()<CR>
nnoremap <silent><Plug>ZoomReset :call <SID>ZoomReset()<CR>

" varialbles {{{2
" Other script local variables, s:lines_default and s:columns_default are
" defined by the function s:GetDefaults().
" Additionally s:size_default may be changed by s:GetDefaults()
let s:sizes = [8 , 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72]
lockvar s:sizes
let s:size_default_default = 12
lockvar s:size_default_default

let s:guifont_delimiter = ','
lockvar s:guifont_delimiter
let s:fontset_delimiter = ':'
lockvar s:fontset_delimiter

" functions {{{2
function! s:ZoomIn()
    call s:Zoom(function('s:IncreaseSize'))
endfunction

function! s:ZoomOut()
    call s:Zoom(function('s:DecreaseSize'))
endfunction

function! s:ZoomReset()
    call s:Zoom(function('s:ResetSize'))
    " also reset 'lines' and 'columns'
    let &lines = s:lines_default
    let &columns = s:columns_default
endfunction

" 'guifont' example: MS_Gothic:h12:cSHIFTJIS,MS_Mincho:h12:cSHIFTJIS
function! s:Zoom(func)
    try
        let fonts = split(&guifont, s:guifont_delimiter)
        call map(fonts, 's:ChangeFontSize(a:func, v:val)')
        let &guifont = join(fonts, s:guifont_delimiter)
    catch '^\(max\|min\)imum$'
        echohl WarningMsg
        echo 'The font size is already ' . v:exception
        echohl None
    endtry
endfunction

" stuff
function! s:ChangeFontSize(func, font)
    " seek the setting of font size and modify it
    " prepair
    let settings = split(a:font, s:fontset_delimiter)

    " a List to save processed results
    let newsettings = []
    for setting in settings
        let current = s:GetFontSize(setting)
        if current == -1
            call add(newsettings, setting)
            continue
        else
            call add(newsettings, s:FormatFontSize(a:func(current)))
        endif
    endfor

    return join(newsettings, s:fontset_delimiter)
endfunction

" in win32, font size is given in the form of 'hxx'
" pick out font size and convert it into number
function! s:GetFontSize(setting)
    if a:setting =~# '\v^h\d+$'
        return str2nr(a:setting[1:], 10)
    elseif a:setting =~# '\v^h\d+\.\d+$'
        return str2float(a:setting[1:])
    endif
    return -1
endfunction

" formatting by printf() according to a type of size
function! s:FormatFontSize(size)
    if type(a:size) == 0
        return printf('h%d', a:size)
    elseif type(a:size) == 5
        return printf('h%f', a:size)
    endif
    throw 'Unknown'
endfunction

function! s:IncreaseSize(current)
    let bigger = filter(copy(s:sizes), 'a:current < v:val')
    if !empty(bigger)
        return bigger[0]
    else
        throw 'maximum'
    endif
endfunction

function! s:DecreaseSize(current)
    let smaller = filter(copy(s:sizes), 'v:val < a:current')
    if !empty(smaller)
        return smaller[-1]
    else
        throw 'minimum'
    endif
endfunction

function! s:ResetSize(current)
    return s:size_default
endfunction

" get default settings
function! s:GetDefaults()
    try
        let s:size_default = s:GetFontSizeUser()
    catch
        let s:size_default = s:size_default_default
    endtry
    lockvar s:size_default

    let s:columns_default = &columns
    lockvar s:columns_default

    let s:lines_default = &lines
    lockvar s:lines_default
endfunction

" get the first one of 'guifont'
function! s:GetFontSizeUser()
    let font = split(&guifont, s:guifont_delimiter)[0]
    if !empty(font)
        let settings = split(font, s:fontset_delimiter)
        return max(map(settings, 's:GetFontSize(v:val)'))
    else
        throw 'I do not know.'
    endif
endfunction

" autocmds {{{2
augroup zoomfont
    autocmd! zoomfont

    " In order to get values that are setted by .gvimrc
    autocmd VimEnter * call s:GetDefaults()
augroup END

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
