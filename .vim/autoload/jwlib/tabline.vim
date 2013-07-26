" vim autoload file
" Filename:     tabline.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.17
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" preparations {{{1
" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" constants {{{2
unlockvar s:noexts
let s:noexts = ['nofile', 'quickfix', 'help']
lockvar s:noexts

unlockvar s:shortenpattern
let s:shortenpattern = ':.:gs?\v(\.\.|[^\\/])[^\\/]*([\\/])?\1\2?'
lockvar s:shortenpattern

" functions {{{2
" tablines {{{3
function! jwlib#tabline#NormalTabLine(labelfunc)
    let tabpages = []
    let nr = 1
    let last = tabpagenr('$')
    while nr <= last
        let tabpage = []

        " collect informations of the tabpage
        let info = jwlib#tabline#GetTabpageInfo(nr)

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

function! jwlib#tabline#NoMouseTabLine(labelfunc)
    let tabpages = []
    let nr = 1
    let last = tabpagenr('$')
    while nr <= last
        let tabpage = []

        " collect informations of the tabpage
        let info = jwlib#tabline#GetTabpageInfo(nr)

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

" tablabels {{{3
function! jwlib#tabline#FilePathTabLabel(i)
    let highlight = a:i.iscurrent ? '%#TabLineSel#' : '%#TabLine#'
    let modifier = jwlib#tabline#BuildTabpageIndicator(a:i)
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

function! jwlib#tabline#FileNameTabLabel(i)
    let highlight = a:i.iscurrent ? '%#TabLineSel#' : '%#TabLine#'
    let modifier = jwlib#tabline#BuildTabpageIndicator(a:i)
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

function! jwlib#tabline#ExtAndFileTypeTabLabel(i)
    let highlight = a:i.iscurrent ? '%#TabLineSel#' : '%#TabLine#'
    let modifier = jwlib#tabline#BuildTabpageIndicator(a:i)

    let ext = ''
    let buftype = getbufvar(a:i.bufnr, '&buftype')
    if !(!empty(buftype) && index(s:noexts, buftype) !=# -1)
        let ext = fnamemodify(bufname(a:i.bufnr), ':e')
        if empty(ext)
            let ext = '-'
        endif
    endif

    let ft = getbufvar(a:i.bufnr, '&filetype')

    return join([
                \ highlight, ' ',
                \ modifier,
                \ '%<', ext,
                \ '[', empty(ft) ? '-' : ft, ']',
                \ ' ',
                \ ], '')
endfunction

" helper functions {{{3
" return a Dictionary has following keys
"   buflist:    a List of buffers are included by the tabpage
"   bufnr:      a number of the current buffer in the tabpage
"   iscurrent:  when the tabpage is     current, return 1
"                                   not current, return 0
"   modified:   when the tabpage has a modified buffer, return 1
"                                   no modified buffer, return 0
function! jwlib#tabline#GetTabpageInfo(n)
    let buflist = tabpagebuflist(a:n)
    let iscurrent = a:n == tabpagenr() ? 1 : 0

    let modified = 0
    for buf in buflist
        if getbufvar(buf, '&modified')
            let modified = 1
            break
        endif
    endfor

    return {
                \   'buflist':    buflist,
                \   'bufnr':      buflist[tabpagewinnr(a:n) - 1],
                \   'iscurrent':  iscurrent,
                \   'modified':   modified,
                \ }
endfunction

function! jwlib#tabline#BuildTabpageIndicator(i)
    let numofbuf = len(a:i.buflist)
    let n = numofbuf !=# 1 ? numofbuf : ''
    let m = a:i.modified ? '+' : ''
    let space = empty(n) && empty(m) ? '' : ' '

    return join([n, m, space], '')
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=4
