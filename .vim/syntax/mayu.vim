" Vim syntax file
" Language:     mayu
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/11/14 01:19:23.
" Version:      0.30


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif
let b:current_syntax = "mayu"

" includes
syntax keyword  mayuInclude include

" conditionals
syntax keyword  mayuConditional if else endif

" operators
syntax match    mayuOperator    /\%(=\|:\|+=\|-=\)/

" numbers
syntax match    mayuNumberDecimal        /[+-]\=\<\d\+\%(\.\d\+\)\=\>/ display
syntax match    mayuNumberHexadecimal    /\<0x\x\+\>/ display

" strings
syntax region   mayuStringDoubleQuote   start=/"/ skip=/\\\\\|\\$"/ end=/"/
syntax region   mayuStringSingleQuote   start=/'/ skip=/\\\\\|\\$'/ end=/'/

" regular expression
syntax region   mayuRegexpString    start=+/\%(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gim]\{-,3}+ oneline contained

" functions
syntax match    mayuFunction        /&\a\+\>/ contains=mayuFunctionName
syntax keyword  mayuFunctionName
            \ WindowVMaximize WindowToggleTopMost WindowSetAlpha
            \ WindowResizeTo WindowRedraw WindowRaise WindowMoveVisibly
            \ WindowMoveTo WindowMove WindowMonitorTo WindowMonitor
            \ WindowMinimize WindowMaximize WindowLower WindowIdentify
            \ WindowHVMaximize WindowHMaximize WindowClose WindowClingToTop
            \ WindowClingToRight WindowClingToLeft WindowClingToBottom Wait
            \ Variable VK Undefined Toggle Sync ShellExecute SetImeStatus
            \ SetForegroundWindow Repeat Recenter Prefix PostMessage PlugIn
            \ OtherWindowClass MouseWheel MouseMove MayuDialog LogClear
            \ LoadSetting KeymapWindow KeymapPrevPrefix KeymapParent Keymap
            \ InvestigateCommand Ignore HelpVariable HelpMessage
            \ EmacsEditKillLinePred EmacsEditKillLineFunc EditNextModifier
            \ DirectSSTP DescribeBindings Default ClipboardUpcaseWord
            \ ClipboardDowncaseWord ClipboardCopy ClipboardChangeCase
            \ contained transparent

" definitions
syntax keyword  mayuDefine
            \ keymap keymap2 key event mod def keyseq sync alias
            \ subst define
syntax keyword  mayuDefineWindowKeyword window contained containedin=mayuDefineWindow
syntax region   mayuDefineWindow start=/window/ end=/$/ contains=mayuDefineWindowKeyword,mayuOperator,mayuRegexpString

" options
syntax keyword  mayuOption option
syntax match    mayuOption /\%(delay-of\s\+!!!\|sts4mayu\|cts4mayu\)/

" key sequenses
syntax match    mayuKeySequense /\$[A-Za-z\-_]\+/

" special keys
syntax match    mayuSpecialKeys /\%([\*~]\=\%(C\|M\|A\|S\|W\|NL\|CL\|SL\|KL\|IL\|IC\|MAX\|MIN\|MMAX\|MMIN\|T\|TS\|L[0-9]\)-\)\+\*\=\S\+/ contains=mayuSpecialKeysPrefix
syntax keyword  mayuSpecialKeysPrefix
            \ C M A S W NL CL SL KL IL IC
            \ MAX MIN MMAX MMIN T TS
            \ L0 L1 L2 L3 L4 L5 L6 L7 L8 L9
            \ contained transparent

" scancodes
syntax match    mayuScanCodeDecimal      /\<E[01]\-\d\+\>/ contains=mayuExtendedKeyFlag
syntax match    mayuScanCodeHexadecimal  /\<E[01]\-0x\x\+\>/ contains=mayuExtendedKeyFlag
syntax keyword  mayuExtendedKeyFlag E0 E1 contained transparent

" comments
syntax keyword  mayuCommentTodo TODO FIXME XXX TBD contained
syntax region   mayuComment     start=/#/ end=/$/ contains=mayuCommentTodo keepend oneline

" all
syntax cluster  mayuAll contains=ALL

" highlighting
if version >= 508 || !exists("did_mayu_syntax_inits")
    if version < 508
        let did_mayu_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink mayuInclude              Include
    HiLink mayuConditional          Conditional
    HiLink mayuOperator             Operator

    HiLink mayuNumberDecimal        Number
    HiLink mayuNumberHexadecimal    Number
    HiLink mayuScanCodeDecimal      Number
    HiLink mayuScanCodeHexadecimal  Number

    HiLink mayuStringDoubleQuote    String
    HiLink mayuStringSingleQuote    String
    HiLink mayuRegexpString         String

    HiLink mayuFunction             Function

    HiLink mayuDefine               Statement
    HiLink mayuDefineWindowKeyword  Statement
    HiLink mayuOption               Keyword

    HiLink mayuKeySequense          Identifier
    HiLink mayuSpecialKeys          Special

    HiLink mayuComment              Comment
    HiLink mayuCommentTodo          Todo

    delcommand HiLink
endif

" vim: ts=4 sts=4 sw=4 et
