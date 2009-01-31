" Janus.vim
"

"
" Restore default colors
hi clear
set background=dark


if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Janus"


hi Normal guibg=grey20 guifg=GhostWhite
hi NonText guibg=grey15 guifg=yellow3
"hi Normal guibg=grey30 guifg=GhostWhite
"hi NonText guibg=grey20 guifg=yellow3
"hi Cursor guibg=GhostWhite
"hi Cursor guibg=red guifg=white
hi Cursor guibg=green2 guifg=black

if version >= 700
    " Just a tad off of bg
    hi CursorLine   guibg=grey25
    hi CursorColumn guibg=grey25
endif


hi Statement  guifg=#7b68ee
hi Constant   guifg=#e9967a
hi String     guifg=#e9967a
hi Comment    guifg=orange
hi Character  guifg=Cyan
hi Special    guifg=#dddd00 gui=bold
hi Identifier guifg=#60dd60 gui=bold
hi link Function Identifier
hi Type guifg=#da70d6
hi PreProc guifg=#3cb371 gui=bold


hi link SpecialKey Comment
hi link Directory  Comment
hi! link MatchParen Search

"
" Colors not part of the original set:
"
"hi Folded guifg=cyan4 guibg=grey20
hi Folded guifg=grey90 guibg=grey45
hi Visual gui=reverse guibg=fg guifg=darkolivegreen
hi Search guifg=black guibg=LightSkyBlue3 gui=none
"hi IncSearch guifg=yellow guibg=LightSkyBlue3 gui=bold
hi IncSearch guibg=blue guifg=yellow gui=bold
hi WarningMsg guifg=red guibg=GhostWhite gui=bold
hi Error guibg=red3


" Here are the original colors:
"hi guifg=grey70 gui=bold
"hi guifg=#FF7070 gui=bold
"hi guifg=green gui=bold
"hi guifg=yellow gui=bold
"hi guifg=SkyBlue gui=bold
"hi guifg=orchid1 gui=bold
"hi guifg=Cyan gui=bold
"hi guifg=White gui=bold
"
if has("syntax")
    syntax on
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=#7b68ee
        syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=#e9967a
        syntax match InvisibleTab "\t" display containedin=ALL
        highlight InvisibleTab term=underline ctermbg=Cyan guibg=Orange
    endf

    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif
