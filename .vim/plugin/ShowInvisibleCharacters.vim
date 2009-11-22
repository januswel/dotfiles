" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/11/22 13:06:06.
" Version:      0.30
" Refer:        http://vim-users.jp/2009/07/hack40/
"               http://d.hatena.ne.jp/thinca/20091121/1258748377
" Remark:       define matches for invisible characters

" check loaded already or not
if exists('loaded_showinvisiblecharacters')
    finish
endif
let loaded_showinvisiblecharacters = 1

" check required feature
if !has('autocmd')
    finish
endif

" for line continuing
let s:save_cpoptions = &cpoptions
set cpoptions&

" pattern definitions
" 0: group name
" 1: pattern strings
" 2: mapped highlight group
let s:patterns = [
            \   ['TrailingWhiteSpace',  '\s\+$',    'Error'],
            \   ['TabSpace',            '\t',       'Error'],
            \   ['DoubleWidthSpace',    '\%u3000',  'Error'],
            \ ]

" restore 'cpoptions'
let &cpoptions = s:save_cpoptions

" use this dictionary to manage matchids
" key: buffer number
" val: list of matchids
let s:matchids = {}

" just call function matchadd() and return its returned values
function! s:AddMatch(patterns)
    let l:matchids = []
    for [group, pattern; rest] in a:patterns
        call add(l:matchids, matchadd(group, pattern))
    endfor
    return l:matchids
endfunction

" delete matchids that is already exist and add match patterns
function! s:SetMatch(bufnr)
    " deleting section
    if has_key(s:matchids, a:bufnr)
        let matchids = s:matchids[a:bufnr]
        " if matchid is already exists
        if matchids != []
            " eliminate them!
            for matchid in matchids
                call matchdelete(matchid)
            endfor

            " because variable "matchids" is reference to
            " s:matchids[x], this command is clear of s:matchids[x]
            let matchids = []
        endif
    endif

    " adding section
    let s:matchids[a:bufnr] = <SID>AddMatch(s:patterns)
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
augroup showInvisible
    autocmd! showInvisible
    autocmd BufWinEnter * call <SID>SetMatch(expand('<abuf>'))
    autocmd ColorScheme * call <SID>DefineHighlightGroups(s:patterns)
augroup END

" register highlight group name previously, since matchadd() needs defined
" highlight groups
call <SID>DefineHighlightGroups(s:patterns)

" vim: ts=4 sw=4 sts=0 et
