" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/02 22:58:32.
" Version:      0.35
" Refer:        http://vim-users.jp/2009/07/hack40/
"               http://d.hatena.ne.jp/thinca/20091121/1258748377
" Remark:       define matches for invisible characters

" check if this plugin is already loaded or not
if exists('loaded_showinvisiblecharacters')
    finish
endif
let loaded_showinvisiblecharacters = 1

" check vim has the required feature
if !has('autocmd')
    finish
endif

" for line continuing
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" pattern definitions
" 0: group name
" 1: pattern strings
" 2: mapped highlight group
let s:patterns = [
            \   ['TrailingWhiteSpace',      '\s\+$',    'Error'],
            \   ['TabSpace',                '\t',       'Error'],
            \   ['IdeographicSpaceUnicode', '\%u3000',  'Error'],
            \   ['IdeographicSpaceCP932',   '\%u8140',  'Error'],
            \   ['IdeographicSpaceEUCJP',   '\%ua1a1',  'Error'],
            \ ]

" just call function matchadd() and return its returned values
function! s:AddMatch(patterns)
    let l:matchidlist = []
    for [group, pattern; rest] in a:patterns
        call add(l:matchidlist, matchadd(group, pattern))
    endfor
    return l:matchidlist
endfunction

" delete matchids that is already exist and add match patterns
function! s:SetMatch()
    " check match is already setted or not
    if exists('w:matchidlist')
        return
    endif

    let w:matchidlist = s:AddMatch(s:patterns)
endfunction

" define :highlight
function! s:DefineHighlightGroups(groups)
    if version >= 508 || !exists('did_invisiblecharacters_syntax_inits')
        if version < 508
            let did_invisiblecharacters_syntax_inits = 1
            command -nargs=+ HiLink hi link <args>
        else
            command -nargs=+ HiLink hi def link <args>
        endif

        for [group, dust, mapping] in a:groups
            execute 'HiLink ' . group . ' ' . mapping
        endfor

        delcommand HiLink
    endif
endfunction

" autocommands
augroup showinvisible
    autocmd! showinvisible

    autocmd VIMEnter,WinEnter * call s:SetMatch()
    autocmd ColorScheme * call s:DefineHighlightGroups(s:patterns)
augroup END

" register highlight group name previously, since matchadd() needs defined
" highlight groups
call s:DefineHighlightGroups(s:patterns)

" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" vim: ts=4 sw=4 sts=0 et
