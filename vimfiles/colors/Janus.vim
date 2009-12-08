" Vim color scheme file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/08 10:44:29.
" Version:      0.32

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

" general colors
hi Normal   ctermbg=236     ctermfg=15
    \       guibg=#333333   guifg=#ffffff
hi NonText                  ctermfg=11
    \                       guifg=#ffff00
hi Cursor   ctermbg=10      ctermfg=0
    \       guibg=#00ff00   guifg=#000000
hi CursorIM ctermfg=0       ctermbg=214
    \       guifg=#000000   guibg=#ffa500

" miscs
hi Statement    ctermfg=99
    \           guifg=#7b68ee
hi Constant     ctermfg=216
    \           guifg=#ffa07a
hi String       ctermfg=216
    \           guifg=#ffa07a
hi Comment      ctermfg=214
    \           guifg=#ffa500
hi Character    ctermfg=14
    \           guifg=#00ffff
hi Type         ctermfg=170
    \           guifg=#da70d6
hi Special      ctermfg=14              cterm=bold
    \           guifg=#dddd00           gui=bold
hi Identifier   ctermfg=77              cterm=bold
    \           guifg=#60dd60           gui=bold
hi PreProc      ctermfg=71              cterm=bold
    \           guifg=#3cb371           gui=bold

" links
hi  default link Function    Identifier
hi  default link SpecialKey  Comment
hi  default link Directory   Comment
hi! default link MatchParen  Search

" colors not part of the original set:
hi Visual       ctermbg=15          ctermfg=61
    \           guibg=#ffffff       guifg=#5562bf
hi Search       ctermbg=11          ctermfg=0               cterm=none
    \           guibg=#ffff00       guifg=#000000           gui=none
hi IncSearch    ctermbg=4           ctermfg=11
    \           guibg=#0000ff       guifg=#ffff00
hi WarningMsg   ctermbg=15          ctermfg=9
    \           guibg=#ffffff       guifg=#ff0000
hi Error        ctermbg=9
    \           guibg=#ff0000
hi ToDo         ctermbg=11          ctermfg=4
    \           guibg=#ffff00       guifg=#0000ff
hi Folded       ctermbg=145         ctermfg=15
    \           guibg=#a9a9a9       guifg=#ffffff

" restore &cpoptions
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" vim: ts=4 sw=4 sts=0 et
