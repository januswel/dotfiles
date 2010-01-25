" vim plugin file
" Filename:     zoomfont.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 25.
" Version:      0.18
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
    command -nargs=0 ZoomIn    call <SID>Zoom('+')
endif
if exists(':ZoomOut') != 2
    command -nargs=0 ZoomOut   call <SID>Zoom('-')
endif
if exists(':ZoomReset') != 2
    command -nargs=0 ZoomReset call <SID>Zoom('&')
endif

" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
            \ && !(exists('no_zoomfont_maps') && no_zoomfont_maps)

    if !hasmapto('<Plug>ZoomFontIn', 'n')
        nmap <unique><Leader>+ <Plug>ZoomFontIn
    endif
    if !hasmapto('<Plug>ZoomFontOut', 'n')
        nmap <unique><Leader>- <Plug>ZoomFontOut
    endif
    if !hasmapto('<Plug>ZoomFontReset', 'n')
        nmap <unique><Leader>& <Plug>ZoomFontReset
    endif
endif

nnoremap <silent><Plug>ZoomFontIn    :call <SID>Zoom('+')<CR>
nnoremap <silent><Plug>ZoomFontOut   :call <SID>Zoom('-')<CR>
nnoremap <silent><Plug>ZoomFontReset :call <SID>Zoom('&')<CR>

" varialbles {{{2
" Other script local variables, s:lines_default and s:columns_default are
" defined by the function s:GetDefaults().
" Additionally s:size_default may be changed by s:GetDefaults()
let s:sizes = [8 , 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72]
lockvar s:sizes
let s:size_default = 12
lockvar s:size_default

let s:guifont_delimiter = ','
lockvar s:guifont_delimiter
let s:fontset_delimiter = ':'
lockvar s:fontset_delimiter

" functions {{{2
" 'guifont' example: MS_Gothic:h12:cSHIFTJIS,MS_Mincho:h12:cSHIFTJIS
function! s:Zoom(operator)
    try
        let fonts = split(&guifont, s:guifont_delimiter)
        call map(fonts, 's:ChangeFontSize(a:func, v:val)')
        let &guifont = join(fonts, s:guifont_delimiter)
        " this is additional but make you happy
        if a:operator ==# '&'
            let &lines = s:lines_default
            let &columns = s:columns_default
        endif
    catch '^\(max\|min\)imum$'
        echohl WarningMsg
        echo 'The font size is already ' . v:exception
        echohl None
    endtry
endfunction

" stuff
function! s:ChangeFontSize(operator, font)
    " seek the setting of font size and modify it
    " prepair
    let settings = split(a:font, s:fontset_delimiter)

    " a List to save processed results
    let newsettings = []
    for setting in settings
        try
            let current = s:GetFontSize(setting)
        catch '\v^Unknown$'
            call add(newsettings, setting)
            continue
        endtry

        let new = s:GetNewSize(a:operator, current)
        call add(newsettings, s:FormatFontSize(new))
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
    throw 'Unknown'
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

" just delegate
function! s:GetNewSize(operator, current)
    " determine new size
    if a:operator ==# '+'
        return s:IncreaseSize(a:current)
    elseif a:operator ==# '-'
        return s:DecreaseSize(a:current)
    elseif a:operator ==# '&'
        return s:size_default
    endif
    return a:current
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

" get default settings
function! s:GetDefaults()
    let size_user = s:GetFontSizeUser()
    if !empty(size_user)
        unlockvar s:size_default
        let s:size_default = size_user
        lockvar s:size_default
    endif

    let s:columns_default = &columns
    lockvar s:columns_default

    let s:lines_default = &lines
    lockvar s:lines_default
endfunction

" get the first one of 'guifont'
function! s:GetFontSizeUser()
    " assertion
    if empty(&guifont)
        return ''
    endif

    let font = split(&guifont, s:guifont_delimiter)[0]
    for setting in split(font, s:fontset_delimiter)
        try
            return s:GetFontSize(setting)
        catch '^Unknown$'
            continue
        endtry
    endfor

    return ''
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
