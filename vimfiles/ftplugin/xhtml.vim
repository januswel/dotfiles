" Vim ftplugin file
" Language:     xhtml
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/10 12:06:47.
" Version:      0.50

" preparation {{{1
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

" reset the value of 'cpoptions' for portability
let b:save_cpoptions = &cpoptions
set cpoptions&vim


" main {{{1
" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
            \ && !(exists('no_ftxhtml_maps') && no_example_maps)

    " hasmapto() and <unique> are required to avoid overlap
    if !hasmapto('<Plug>InsertXhtmlCloseTag')
        imap <unique><buffer><C-b>
                    \ <Plug>InsertXhtmlCloseTag
    endif
    if !hasmapto('<Plug>ModifyByHTMLTidy')
        nmap <unique><buffer><LocalLeader>m
                    \ <Plug>ModifyByHTMLTidy
    endif
endif

" complete closing tab
inoremap <script><silent><buffer><Plug>InsertXhtmlCloseTag
            \ <Esc>:call <SID>InsertXhtmlCloseTag()<CR>a<C-f>
" modify by HTML Tidy
nnoremap <script><silent><buffer><Plug>ModifyByHTMLTidy
            \ :call <SID>ModifyByHTMLTidy()<CR>

" options {{{2
" about tab spaces
setlocal shiftwidth=2
setlocal tabstop=2

" compiler {{{2
" for make
compiler xhtml

" variables {{{2
let b:tidyopt = {
            \ '--add-xml-decl':     'yes',
            \ '--char-encoding':    'utf8',
            \ '--clean':            'yes',
            \ '--indent':           'auto',
            \ '--join-classes':     'yes',
            \ '--output-xhtml':     'yes',
            \ '--quiet':            'yes',
            \ '--show-warnings':    'no',
            \ '--tab-size':         '2',
            \ '--tidy-mark':        'no',
            \ '--wrap':             '0',
            \ }

let b:tidyenc_default = 'ascii'

let b:enctable = {
            \ 'ascii':      'ascii',
            \ 'latin0':     'latin9',
            \ 'latin1':     'latin1',
            \ 'utf8':       'utf-8',
            \ 'iso2022':    'iso-2022-jp',
            \ 'mac':        'macroman',
            \ 'win1252':    'cp1252',
            \ 'ibm858':     'cp858',
            \ 'utf16le':    'utf-16le',
            \ 'utf16be':    'utf-16',
            \ 'utf16':      'utf-16',
            \ 'big5':       'big5',
            \ 'shiftjis':   'sjis',
            \ }

" functions {{{2
" convert the encoding name of tidy to it of vim
if !exists('*s:GetValidEncName')
    function s:GetValidEncName(enc)
        " "raw" is indifference about encoding
        if a:enc ==# 'raw'
            return &fileencoding
        elseif has_key(b:enctable, a:enc)
            return b:enctable[a:enc]
        endif

        " ?
        throw 'Unknown encoding: ' . a:enc
    endfunction
endif

" filter by HTML Tidy
if !exists('*s:ModifyByHTMLTidy')
    function s:ModifyByHTMLTidy()
        " save positions
        let pos = s:SavePositions()

        " save 'fileencoding'
        let save_fileencoding = &fileencoding

        try
            if has_key(b:tidyopt, '--char-encoding')
                let tidyenc = s:GetValidEncName(b:tidyopt['--char-encoding'])
            else
                let tidyenc = b:tidyenc_default
            endif
            let &fileencoding = tidyenc

            " use tidy as filter
            " this method has merit that can undo,
            " compared with using write-back option.
            silent execute '1,$!tidy ' . s:Dict2Str(b:tidyopt)

            " restore positions
            call s:RestorePositions(pos)
        catch
            echoerr v:exception
        finally
            " restore 'fileencoding'
            let &fileencoding = save_fileencoding
        endtry
    endfunction
endif

" stuff
" convert values of the dictionary to string with specified delimiter
if !exists('*s:Dict2Str')
    function s:Dict2Str(dict, ...)
        if a:0 ==# 0
            let d1 = ' '
            let d2 = ' '
        elseif a:0 ==# 1
            let d1 = a:1
            let d2 = a:1
        elseif a:0 ==# 2
            let d1 = a:1
            let d2 = a:2
        endif

        let result = []
        for [key, val] in items(a:dict)
            call add(result, key . d1 . val)
        endfor
        return join(result, d2)
    endfunction
endif

" save cursor and screen positions
" pair up this function with s:RestorePositions
if !exists('*s:SavePositions')
    function s:SavePositions()
        " cursor pos
        let cursor = getpos('.')

        " screen pos
        normal! H
        let screen = getpos('.')

        return [screen, cursor]
    endfunction
endif

" restore cursor and screen positions
" pair up this function with s:SavePositions
if !exists('*s:RestorePositions')
    function s:RestorePositions(pos)
        " screen
        call setpos('.', a:pos[0])

        " cursor
        normal! zt
        call setpos('.', a:pos[1])
    endfunction
endif

" function to close tag
if !exists('*s:InsertXhtmlCloseTag')
    function s:InsertXhtmlCloseTag()
        " inserts the appropriate closing HTML tag; used for the \hc operation
        " defined above; requires ignorecase to be set, or to type HTML tags in
        " exactly the same case that I do; doesn't treat <P> as something that needs
        " closing; clobbers register z and mark z
        "
        " by Smylers http://www.stripey.com/vim/ 2000 May 3

        if &filetype == 'html' || &filetype == 'xhtml'

            " list of tags which shouldn't be closed:
            let UnaryTags = ' area base br hr img input link meta param '

            " remember current position:
            normal mz

            " loop backwards looking for tags:
            let Found = 0
            while Found == 0
                " find the previous <, then go forwards one character and grab
                " the first character plus the entire word:
                execute "normal ?\<LT>\<CR>l"
                normal "zyl
                let Tag = expand('<cword>')

                " if this is a closing tag, skip back to its matching opening
                " tag:
                if @z == '/'
                    execute "normal ?\<LT>" . Tag . "\<CR>"

                    " if this is a unary tag, then position the cursor for the next
                    " iteration:
                elseif match(UnaryTags, ' ' . Tag . ' ') > 0
                    normal h

                    " otherwise this is the tag that needs closing:
                else
                    let Found = 1

                endif
            endwhile " not yet found match

            " create the closing tag and insert it:
            let @z = '</' . Tag . '>'
            normal `z"zp

        else " filetype is not HTML
            echohl ErrorMsg
            echo 'The InsertCloseTag() function is only intended ' .
                        \ 'to be used in HTML files.'
            sleep
            echohl None
        endif " check on filetype

    endfunction " InsertHTMLCloseTag()
endif

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = b:save_cpoptions
unlet b:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
