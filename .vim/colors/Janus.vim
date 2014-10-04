" vim colors file
" Filename:     Janus.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.37
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
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

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" base {{{2
hi Normal       term=none
            \   cterm=none  ctermfg=15      ctermbg=236
            \   gui=none    guifg=#ffffff   guibg=#333333

" cursor {{{2
hi Cursor                   ctermfg=0       ctermbg=10
            \               guifg=#000000   guibg=#00ff00
hi CursorIM                 ctermfg=0       ctermbg=214
            \               guifg=#000000   guibg=#ffa500
hi CursorColumn                             ctermbg=241
            \                               guibg=#666666
hi CursorLine                               ctermbg=241
            \                               guibg=#666666

" C language and compatibles {{{2
" :help group-name
hi Comment                  ctermfg=214
            \               guifg=#ffa500
" constants
" base of String, Character, Number, Boolean, Float
hi Constant                 ctermfg=216
            \               guifg=#ffa07a
" identifiers
" base of Function
hi Identifier   cterm=bold  ctermfg=77
            \   gui=bold    guifg=#60dd60
" statements
" base of Conditional, Repeat, Label, Operator, Keyword, Exception
hi Statement    cterm=bold  ctermfg=11
            \   gui=bold    guifg=#ffff00
" preprocessors
" base of Include, Define, Macro, PreCondit
hi PreProc      cterm=bold  ctermfg=205
            \   gui=bold    guifg=#ff69b4
" types
" base of StorageClass, Structure, Typedef
hi Type                     ctermfg=120
            \               guifg=#98fb98
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

" default highlighting groups {{{2
" :help highlight-groups
" modes {{{3
hi Visual                   ctermfg=15      ctermbg=61
            \               guifg=#ffffff   guibg=#5562bf

" searches {{{3
hi Search       cterm=none  ctermfg=0       ctermbg=11
            \   gui=none    guifg=#000000   guibg=#ffff00
hi IncSearch                ctermfg=11      ctermbg=21
            \               guifg=#ffff00   guibg=#0000ff
hi MatchParen               ctermfg=0       ctermbg=152
            \               guifg=#000000   guibg=#add8e6

" specials {{{3
hi NonText                  ctermfg=11
            \               guifg=#ffff00
hi SpecialKey               ctermfg=11
            \               guifg=#ffff00
hi WarningMsg   cterm=bold  ctermfg=9       ctermbg=15
            \   gui=bold    guifg=#ff0000   guibg=#ffffff

" statusline {{{3
hi StatusLine   term=none
            \   cterm=none  ctermfg=0       ctermbg=252
            \   gui=bold    guifg=#000000   guibg=#cccccc
hi StatusLineNC term=bold
            \   cterm=bold  ctermfg=0       ctermbg=252
            \   gui=none    guifg=#000000   guibg=#cccccc
hi VertSplit    cterm=none  ctermfg=252     ctermbg=252
            \   gui=none    guifg=#cccccc   guibg=#cccccc

" tabline {{{3
hi TabLineSel   cterm=bold  ctermfg=11      ctermbg=236
            \   gui=bold    guifg=#ffff00   guibg=#333333
hi TabLine      cterm=none  ctermfg=0       ctermbg=252
            \   gui=none    guifg=#000000   guibg=#cccccc
hi TabLineFill  cterm=none                  ctermbg=252
            \   gui=none                    guibg=#cccccc

" popup menu {{{3
hi PMenu                    ctermfg=0       ctermbg=252
            \               guifg=#000000   guibg=#cccccc
hi PMenuSel                 ctermfg=0       ctermbg=48
            \               guifg=#000000   guibg=#00ff7f
hi PMenuSbar                                ctermbg=244
            \                               guibg=#808080
hi PMenuThumb               ctermfg=15
            \               guifg=#ffffff

" fold {{{3
hi Folded                   ctermfg=15      ctermbg=248
            \               guifg=#ffffff   guibg=#a9a9a9
hi FoldColumn               ctermfg=15      ctermbg=236
            \               guifg=#ffffff   guibg=#333333

" diff {{{3
hi DiffAdd                  ctermfg=0       ctermbg=120     cterm=bold
            \               guifg=#000000   guibg=#98fb98   gui=bold
hi DiffChange               ctermfg=0       ctermbg=134
            \               guifg=#000000   guibg=#ba55d3
hi DiffText                 ctermfg=fg      ctermbg=134     cterm=underline,bold
            \               guifg=fg        guibg=#ba55d3   gui=underline,bold
hi DiffDelete               ctermfg=209     ctermbg=209
            \               guifg=#fa8072   guibg=#fa8072

" others {{{3
hi Title        cterm=bold  ctermfg=11
            \   gui=bold    guifg=#ffff00
hi MoreMsg                  ctermfg=11
            \               guifg=#ffff00

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=4
