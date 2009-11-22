" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/11/22 12:12:17.
" Version:      0.27
" Remark:       define syntaxes for invisible characters

" check loaded already or not
if exists('loaded_showinvisiblecharacters')
    finish
endif
let loaded_showinvisiblecharacters = 1

" check required features
if !has('autocmd') || !has('syntax')
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

" about syntax
syntax on
function! s:SetSyntax(patterns)
    for [group, pattern; rest] in a:patterns
        execute 'syntax match ' . group . ' ' . pattern . ' display containedin=All'
    endfor
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
    autocmd BufWinEnter * call <SID>SetSyntax(s:patterns)
    autocmd ColorScheme * call <SID>DefineHighlightGroups(s:patterns)
augroup END

" vim: ts=4 sw=4 sts=0 et
