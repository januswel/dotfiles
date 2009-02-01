" Janus.vim

" Restore default colors
hi clear
set background=dark

" revert syntax settings to default
if exists('syntax_on')
  syntax reset
endif

" name of this color scheme
let g:colors_name = "Janus"

" general colors
hi Normal   ctermbg=Black ctermfg=White  guibg=Grey20 guifg=GhostWhite
hi NonText  ctermbg=Black ctermfg=Yellow guibg=Grey15 guifg=Yellow3
hi Cursor   ctermbg=Green ctermfg=Black  guibg=Green2 guifg=Black

if version >= 700
    " Just a tad off of bg
    hi CursorLine   guibg=Grey25
    hi CursorColumn guibg=Grey25
endif

" miscs
hi Statement    ctermfg=Blue                       guifg=#7b68ee
hi Constant     ctermfg=LightRed                   guifg=#e9967a
hi String       ctermfg=LightRed                   guifg=#e9967a
hi Comment      ctermfg=LightRed                   guifg=Orange
hi Character    ctermfg=Cyan                       guifg=Cyan
hi Type         ctermfg=LightMagenta               guifg=#da70d6
hi Special      ctermfg=Yellow       cterm=bold    guifg=#dddd00 gui=bold
hi Identifier   ctermfg=LightGreen   cterm=bold    guifg=#60dd60 gui=bold
hi PreProc      ctermfg=DarkGreen    cterm=bold    guifg=#3cb371 gui=bold

" links
hi link     Function Identifier
hi link     SpecialKey Comment
hi link     Directory  Comment
hi! link    MatchParen Search

" colors not part of the original set:
hi Visual       ctermbg=fg        ctermfg=DarkGreen cterm=reverse guibg=fg            guifg=darkoliveGreen gui=reverse
hi Search       ctermbg=LightBlue ctermfg=Black     cterm=none    guibg=LightSkyBlue3 guifg=Black          gui=none
hi IncSearch    ctermbg=Blue      ctermfg=Yellow    cterm=bold    guibg=Blue          guifg=Yellow         gui=bold
hi WarningMsg   ctermbg=White     ctermfg=Red       cterm=bold    guibg=GhostWhite    guifg=Red            gui=bold
hi Error        ctermbg=Red                                       guibg=Red3
hi Folded                                                         guibg=Grey45        guifg=Grey90


" Here are the original colors:
"hi guifg=Grey70 gui=bold
"hi guifg=#FF7070 gui=bold
"hi guifg=Green gui=bold
"hi guifg=Yellow gui=bold
"hi guifg=SkyBlue gui=bold
"hi guifg=orchid1 gui=bold
"hi guifg=Cyan gui=bold
"hi guifg=White gui=bold
"
if has('syntax')
    syntax on
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=#7b68ee
        syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=#e9967a
        syntax match InvisibleTab "\t" display containedin=ALL
        highlight InvisibleTab term=underline ctermbg=Cyan guibg=Cyan
    endf

    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif
