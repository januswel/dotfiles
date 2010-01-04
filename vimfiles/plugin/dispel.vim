" vim plugin file
" Filename:     dispel.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 05.
" Version:      0.47
" Refer:        http://vim-users.jp/2009/07/hack40/
"               http://d.hatena.ne.jp/thinca/20091121/1258748377
"
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" Remark: {{{1
"   This plugin provides the feature to make transparent characters a visible
"   block automatically.
"
"   The patterns are given by the global variable "g:dispel_patterns" that must
"   be the List has some Dictionaries. If you want to show trailing spaces with
"   WarningMsg highlighting, write following codes in .vimrc:
"
"       let g:dispel_patterns = [
"                   \   {
"                   \       'name':         'TrailingWhiteSpace',
"                   \       'pattern':      '\s\+$',
"                   \       'highlight':    'WarningMsg'
"                   \   },
"                   \ ]
"
"   The key "name" must be unique through all patterns. The key "pattern" can
"   be written in form of regular expression. The key "highlight" must be the
"   highlight group name that exists already.
"
"   If you want to show other characters, append Dictionaries that has keys
"   "name", "pattern" and "highlight".
"
"   In the default settings - when "g:dispel_patterns" is undefined - this
"   plugin show trailing spaces and U+3000 "IDEOGRAPHIC SPACE" with Error
"   highlighting
"
"   fileencoding 判別用文字列

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_dispel')
    finish
endif
let loaded_dispel = 1

" check vim has the required feature
if !has('autocmd')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" constants {{{2
" default patterns
" name:      a unique name
" pattern:   a pattern string
" highlight: the highlight group to map to
scriptencoding utf-8
let s:patterns_default = [
            \   {
            \       'name':         'TrailingWhiteSpace',
            \       'pattern':      '\s\+$',
            \       'highlight':    'Error'
            \   },
            \   {
            \       'name':         'IdeographicSpace',
            \       'pattern':      '　',
            \       'highlight':    'Error'
            \   },
            \ ]
scriptencoding
lockvar s:patterns_default

" functions {{{2
" just call function matchadd() and return its returned values
function s:AddMatch(patterns)
    let l:matchidlist = []
    for item in a:patterns
        call add(l:matchidlist, matchadd(item.name, item.pattern))
    endfor
    return l:matchidlist
endfunction

" delete matchids that is already exist and add match patterns
function s:SetMatch()
    " check match is already setted or not
    if exists('w:matchidlist')
        return
    endif

    let w:matchidlist = s:AddMatch(s:patterns)
endfunction

" define :highlight
function s:DefineHighlightGroups(groups)
    if version >= 508 || !exists('did_dispel_syntax_inits')
        if version < 508
            let did_dispel_syntax_inits = 1
            command -nargs=+ HiLink hi link <args>
        else
            command -nargs=+ HiLink hi def link <args>
        endif

        for item in a:groups
            execute 'HiLink ' . item.name . ' ' . item.highlight
        endfor

        delcommand HiLink
    endif
endfunction

" global or script local
function s:GetPatterns()
    if exists('g:dispel_patterns')
        if exists('g:dispel_add') && g:dispel_add
            return s:patterns_default + g:dispel_patterns
        endif
        return g:dispel_patterns
    endif
    return s:patterns_default
endfunction

" autocommands {{{2
augroup dispel
    autocmd! dispel

    autocmd VIMEnter,WinEnter * call s:SetMatch()
    autocmd ColorScheme * call s:DefineHighlightGroups(s:patterns)
augroup END

" execute codes {{{2
let s:patterns = s:GetPatterns()
lockvar s:patterns

" register highlight group name previously, since matchadd() needs defined
" highlight groups
call s:DefineHighlightGroups(s:patterns)

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
