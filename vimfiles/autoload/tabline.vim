" vim autoload file
" Filename:     tabline.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 01.
" Version:      0.12
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" Remark: {{{1
"   This script provides functions to be setted to 'tabline'.  See :help
"   setting-tabline.
"
"   There are 3 kind of functions. The first is for tabline - functions to build
"   the form of tabline.
"
"       * NormalTabLine():  the imitation of default
"       * NoMouseTabLine(): no identifiers for mouse operation
"
"   The second is for tablabel - functions to determine the label of each
"   tabpages.
"
"       * FileNameTabLabel():       filename only
"       * FilePathTabLabel():       filepath in short form
"       * ExtAndFileTypeTabLabel(): file extention and filetype
"
"   The last is helper functions.
"
"       * GetTabpageInfo(): return a Dictionary has following keys
"           - buflist:  a List of buffers are included by the tabpage
"           - modified: when the tabpage has a modified buffer, return 1
"                                           no modified buffer, return 0
"           - bufnr:    a number of the current buffer in the tabpage
"       * BuildTabpageIndicator(): return string has following indicators
"           - a number of buffers that be included a tabpage but when its value
"             is bigger than 1
"           - a modifier '+' when the tabpage has a modified buffer
"
"   In order to set these functions to 'tabline', write like following codes in
"   your .vimrc:
"
"       set tabline=%!tabline#NormalTabLine('tabline#FileNameTabLabel')
"
"   Of course using the combination of your function and above one is possible.
"
"       set tabline=%!YourTabLine('tabline#FilePathTabLabel')

" variables {{{1
let s:noexts = ['nofile', 'quickfix', 'help']
let s:shortenpattern = ':gs?\(\.\.\|[^\\/]\)[^\\/]*\([\\/]\)?\1\2?'

" functions {{{1
" tablines {{{2
function tabline#NormalTabLine(labelfunc)
    let tabpages = []
    let selected = tabpagenr()
    let nr = 1
    let last = tabpagenr('$')
    while nr <= last
        let tabpage = []

        " collect informations of the tabpage
        let info = tabline#GetTabpageInfo(nr)
        let info.selected = nr == selected ? 1 : 0

        " set the tabpage number (for mouse clicks)
        call add(tabpage, printf('%%%dT', nr))

        " the label is made by the function that is specified
        " a:labelfunc
        call add(tabpage, call(a:labelfunc, [info]))

        call add(tabpages, join(tabpage, ''))
        let nr += 1
    endwhile

    " after the last tab fill with TabLineFill and reset tab page nr
    call add(tabpages, '%#TabLineFill#%T')
    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        call add(tabpages, '%=%#TabLine#%999XX')
    endif

    return join(tabpages, '')
endfunction

function tabline#NoMouseTabLine(labelfunc)
    let tabpages = []
    let selected = tabpagenr()
    let nr = 1
    let last = tabpagenr('$')
    while nr <= last
        let tabpage = []

        " collect informations of the tabpage
        let info = tabline#GetTabpageInfo(nr)
        let info.selected = nr == selected ? 1 : 0

        " the label is made by the function that is specified
        " a:labelfunc
        call add(tabpage, call(a:labelfunc, [info]))

        call add(tabpages, join(tabpage, ''))
        let nr += 1
    endwhile

    " after the last tab fill with TabLineFill and reset tab page nr
    call add(tabpages, '%#TabLineFill#%T')

    return join(tabpages, '')
endfunction

" tablabels {{{2
function tabline#FilePathTabLabel(i)
    let highlight = a:i.selected ? '%#TabLineSel#' : '%#TabLine#'
    let modifier = tabline#BuildTabpageIndicator(a:i)
    let filepath = bufname(a:i.bufnr)
    if empty(filepath)
        let filepath = '-'
    else
        let filepath = fnamemodify(filepath, s:shortenpattern)
    endif

    return join([
                \ highlight, ' ',
                \ modifier,
                \ '%<', filepath,
                \ ' ',
                \], '')
endfunction

function tabline#FileNameTabLabel(i)
    let highlight = a:i.selected ? '%#TabLineSel#' : '%#TabLine#'
    let modifier = tabline#BuildTabpageIndicator(a:i)
    let filename = fnamemodify(bufname(a:i.bufnr), ':t')
    if empty(filename)
        let filename = '-'
    endif

    return join([
                \ highlight, ' ',
                \ modifier,
                \ '%<', filename,
                \ ' ',
                \], '')
endfunction

function tabline#ExtAndFileTypeTabLabel(i)
    let highlight = a:i.selected ? '%#TabLineSel#' : '%#TabLine#'
    let modifier = tabline#BuildTabpageIndicator(a:i)

    let ext = ''
    let buftype = getbufvar(a:i.bufnr, '&buftype')
    if !(!empty(buftype) && index(s:noexts, buftype) !=# -1)
        let ext = fnamemodify(bufname(a:i.bufnr), ':e')
        if ext ==# ''
            let ext = '-'
        endif
    endif

    let ft = getbufvar(a:i.bufnr, '&filetype')

    return join([
                \ highlight, ' ',
                \ modifier,
                \ '%<', ext,
                \ '[', ft ==# '' ? '-' : ft, ']',
                \ ' ',
                \ ], '')
endfunction

" stuff {{{2
" return a Dictionary has following keys
"   buflist:    a List of buffers are included by the tabpage
"   modified:   when the tabpage has a modified buffer, return 1
"                                   no modified buffer, return 0
"   bufnr:      a number of the current buffer in the tabpage
function! tabline#GetTabpageInfo(n)
    let buflist = tabpagebuflist(a:n)

    let modified = 0
    for buf in buflist
        if getbufvar(buf, '&modified') ==# 1
            let modified = 1
            break
        endif
    endfor

    return {
                \ 'buflist':    buflist,
                \ 'modified':   modified,
                \ 'bufnr':      buflist[tabpagewinnr(a:n) - 1],
                \ }
endfunction

function! tabline#BuildTabpageIndicator(i)
    let numofbuf = len(a:i.buflist)
    let n = numofbuf !=# 1 ? numofbuf : ''
    let m = a:i.modified ? '+' : ''
    let space = empty(n) && empty(m) ? '' : ' '

    return join([n, m, space], '')
endfunction

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
