" Vim color scheme file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/08 10:21:53.
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
hi Normal   ctermbg=Black   ctermfg=White 
    \       guibg=Gray20    guifg=GhostWhite
hi NonText  ctermbg=Black   ctermfg=Yellow 
    \       guibg=Gray15    guifg=Yellow3
hi Cursor   ctermbg=Green   ctermfg=Black 
    \       guibg=Green2    guifg=Black
hi CursorIM ctermfg=Black   ctermbg=214 
    \       guifg=Black     guibg=Orange

" miscs
hi Statement    ctermfg=Blue 
    \           guifg=#7b68ee
hi Constant     ctermfg=LightRed 
    \           guifg=#e9967a
hi String       ctermfg=LightRed 
    \           guifg=#e9967a
hi Comment      ctermfg=LightRed 
    \           guifg=Orange
hi Character    ctermfg=Cyan 
    \           guifg=Cyan
hi Type         ctermfg=LightMagenta 
    \           guifg=#da70d6
hi Special      ctermfg=Yellow          cterm=bold 
    \           guifg=#dddd00           gui=bold
hi Identifier   ctermfg=LightGreen      cterm=bold 
    \           guifg=#60dd60           gui=bold
hi PreProc      ctermfg=DarkGreen       cterm=bold 
    \           guifg=#3cb371           gui=bold

" links
hi  default link Function    Identifier
hi  default link SpecialKey  Comment
hi  default link Directory   Comment
hi! default link MatchParen  Search

" colors not part of the original set:
hi Visual       ctermbg=fg          ctermfg=DarkGreen       cterm=reverse 
    \           guibg=fg            guifg=darkoliveGreen    gui=reverse
hi Search       ctermbg=Yellow      ctermfg=White           cterm=none 
    \           guibg=Yellow        guifg=Black             gui=none
hi IncSearch    ctermbg=Blue        ctermfg=Yellow          cterm=bold 
    \           guibg=Blue          guifg=Yellow            gui=bold
hi WarningMsg   ctermbg=White       ctermfg=Red             cterm=bold 
    \           guibg=GhostWhite    guifg=Red               gui=bold
hi Error        ctermbg=Red 
    \           guibg=Red3
hi Todo         ctermbg=Yellow      ctermfg=Blue 
    \           guibg=Yellow        guifg=Blue
hi Folded       ctermbg=LightGray   ctermfg=DarkGray 
    \           guibg=Gray45        guifg=Gray90

" restore &cpoptions
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" vim: ts=4 sw=4 sts=0 et
