" Vim ftplugin file
" Language:     xhtml
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/10 11:55:23.
" Version:      0.45

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

" functions {{{2
" check, fix, form document and write it back
setlocal autoread
if !exists('*s:ModifyByHTMLTidy')
    function s:ModifyByHTMLTidy()
        update
        !tidy  -config ~/.tidyrc -quiet -modify "%"
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
