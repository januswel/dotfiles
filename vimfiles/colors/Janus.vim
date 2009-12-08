" Vim color scheme file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/08 11:37:06.
" Version:      0.35

" restore default colors
hi clear
set background=dark

" revert syntax settings to default
if exists('syntax_on')
    syntax reset
endif

" name of this color scheme
let g:colors_name = 'Janus'

" affects only when 256 or more than colors
if exists('&t_Co') && (&t_Co == 8 || &t_Co == 16)
    finish
endif

" for line continueing
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" base
hi Normal       term=none
            \   cterm=none  ctermfg=15      ctermbg=236
            \   gui=none    guifg=#ffffff   guibg=#333333

" cursor
hi Cursor                   ctermfg=0       ctermbg=10
            \               guifg=#000000   guibg=#00ff00
hi CursorIM                 ctermfg=0       ctermbg=214
            \               guifg=#000000   guibg=#ffa500
hi CursorColumn                             ctermbg=241
            \                               guibg=#666666
hi CursorLine                               ctermbg=241
            \                               guibg=#666666

" C language and compatibles
" :help group-name
hi Comment                  ctermfg=214
            \               guifg=#ffa500
" constants
" base of String, Character, Number, Boolean, Float
hi Constant                 ctermfg=216
            \               guifg=#ffa07a
" identifiers
" base of Function
hi Identifier               ctermfg=77
            \               guifg=#60dd60
" statements
" base of Conditional, Repeat, Label, Operator, Keyword, Exception
hi Statement                ctermfg=99
            \               guifg=#7b68ee
" preprocessors
" base of Include, Define, Macro, PreCondit
hi PreProc                  ctermfg=71
            \               guifg=#3cb371
" types
" base of StorageClass, Structure, Typedef
hi Type                     ctermfg=170
            \               guifg=#da70d6
" specials
" base of SpecialChar, Tag, Delimiter, SpecialComment, Debug
hi Special                  ctermfg=184
            \               guifg=#dddd00
" urls
hi Underlined               ctermfg=152
            \               guifg=#b0e0e6
" errors
hi Error                    ctermfg=15      ctermbg=202
            \               guifg=#ffffff   guibg=#ff4500
" attentions
hi ToDo                     ctermfg=80      ctermbg=236
            \               guifg=#40e0d0   guibg=#333333

" default highlighting groups
" :help highlight-groups
" modes
hi Visual                   ctermfg=15      ctermbg=61
            \               guifg=#ffffff   guibg=#5562bf

" searches
hi Search       cterm=none  ctermfg=0       ctermbg=11
            \   gui=none    guifg=#000000   guibg=#ffff00
hi IncSearch                ctermfg=11      ctermbg=4
            \               guifg=#ffff00   guibg=#0000ff
hi MatchParen               ctermfg=0       ctermbg=152
            \               guifg=#000000   guibg=#add8e6

" specials
hi NonText                  ctermfg=11
            \               guifg=#ffff00
hi SpecialKey               ctermfg=11
            \               guifg=#ffff00
hi WarningMsg               ctermfg=9       ctermbg=15
            \               guifg=#ff0000   guibg=#ffffff

" statusline
hi StatusLine   term=none
            \   cterm=none  ctermfg=0       ctermbg=251
            \   gui=bold    guifg=#000000   guibg=#cccccc
hi StatusLineNC term=bold
            \   cterm=bold  ctermfg=0       ctermbg=251
            \   gui=none    guifg=#000000   guibg=#cccccc
hi VertSplit    cterm=none  ctermfg=251     ctermbg=251
            \   gui=none    guifg=#cccccc   guibg=#cccccc

" tabline
hi TabLine                  ctermfg=0       ctermbg=251
            \               guifg=#000000   guibg=#cccccc
hi TabLineFill              ctermfg=251
            \               guifg=#cccccc
hi TabLineSel               ctermfg=11      ctermbg=236
            \               guifg=#ffff00   guibg=#333333

" popup menu
hi PMenu                    ctermfg=0       ctermbg=251
            \               guifg=#000000   guibg=#cccccc
hi PMenuSel                 ctermfg=0       ctermbg=48
            \               guifg=#000000   guibg=#00ff7f
hi PMenuSbar                                ctermbg=8
            \                               guibg=#808080
hi PMenuThumb               ctermfg=15
            \               guifg=#ffffff

" fold
hi Folded                   ctermfg=15      ctermbg=145
            \               guifg=#ffffff   guibg=#a9a9a9
hi FoldColumn               ctermfg=15      ctermbg=236
            \               guifg=#ffffff   guibg=#333333

" restore &cpoptions
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" vim: ts=4 sw=4 sts=0 et
