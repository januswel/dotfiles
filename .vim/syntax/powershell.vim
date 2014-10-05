" vim syntax file
" Filename:     powershell.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" License:      MIT License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   https://github.com/januswel/dotfiles/blob/master/LICENSE

" preparations {{{1
if version < 600
    syn clear
elseif exists("b:current_syntax")
    finish
endif
let b:current_syntax = "powershell"

" syntax {{{1
" statements {{{2
syntax keyword  ps1Statements
            \ if elseif else switch case break default
            \ for foreach while do
            \ echo cmd
            \ function
            \ return exit
            \ try catch trap throw

syntax match    ps1Operator /\%(+\|-\|\*\|\/\|%\|-\%(eq\|ne\|gt\|lt\|ge\|le\|not\|and\|or\|xor\|bnot\|band\|bor\|bxor\|is\|isnot\|as\)\)\>/   contains=ps1OperatorName

" variables {{{2
syntax match    ps1Variables    /\$\%(\w\+\|\$\|\^\|?\|_\)\>/

" numbers {{{2
syntax match    ps1NumberDecimal    /[+-]\=\<\d\+\%(\.\d\+\)\=\>/ display

" strings {{{2
syntax region   ps1StringDoubleQuote    start=/"/ skip=/\\\\\|\\$"/ end=/"/
syntax region   ps1StringSingleQuote    start=/'/ skip=/\\\\\|\\$'/ end=/'/
syntax region   ps1RegexpString    start=+/\%(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gim]\{-,3}+ oneline contained

" comments {{{2
syntax keyword  ps1CommentTodo  TODO FIXME XXX TBD contained
syntax region   ps1Comment      start=/^#/ end=/$/ contains=ps1CommentTodo keepend oneline
syntax region   ps1CommentBlock start="<#" end="#>" contains=ps1CommentTodo


" highlighting {{{1
if version >= 508 || !exists("did_mayu_syntax_inits")
    if version < 508
        let did_mayu_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink ps1Statements            Statement
    HiLink ps1Operator              Operator

    HiLink ps1NumberDecimal         Number

    HiLink ps1StringDoubleQuote     String
    HiLink ps1StringSingleQuote     String
    HiLink ps1RegexpString          String

    HiLink ps1Variables             Identifier

    HiLink ps1Comment               Comment
    HiLink ps1CommentBlock          Comment
    HiLink ps1CommentTodo           Todo

    delcommand HiLink
endif

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
