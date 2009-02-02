" .mayu syntax file
" Language:     mayu setting file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/01 19:46:51.


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" definitions
syntax keyword  mayuDefine
\ keymap keymap2 window key event mod def keyseq sync alias subst define

" options
syntax keyword  mayuOption option
syntax match    mayuOption "\(KL-\|delay-of !!!\|sts4mayu\|cts4mayu\)"

" conditionals
syntax keyword  mayuConditional if else endif

" includes
syntax keyword  mayuInclude include

" functions
syntax match    mayuFunction "&\(WindowVMaximize\|WindowToggleTopMost\|WindowSetAlpha\|WindowResizeTo\|WindowRedraw\|WindowRaise\|WindowMoveVisibly\|WindowMoveTo\|WindowMove\|WindowMonitorTo\|WindowMonitor\|WindowMinimize\|WindowMaximize\|WindowLower\|WindowIdentify\|WindowHVMaximize\|WindowHMaximize\|WindowClose\|WindowClingToTop\|WindowClingToRight\|WindowClingToLeft\|WindowClingToBottom\|Wait\|Variable\|VK\|Undefined\|Toggle\|Sync\|ShellExecute\|SetImeStatus\|SetForegroundWindow\|Repeat\|Recenter\|Prefix\|PostMessage\|PlugIn\|OtherWindowClass\|MouseWheel\|MouseMove\|MayuDialog\|LogClear\|LoadSetting\|KeymapWindow\|KeymapPrevPrefix\|KeymapParent\|Keymap\|InvestigateCommand\|Ignore\|HelpVariable\|HelpMessage\|EmacsEditKillLinePred\|EmacsEditKillLineFunc\|EditNextModifier\|DirectSSTP\|DescribeBindings\|Default\|ClipboardUpcaseWord\|ClipboardDowncaseWord\|ClipboardCopy\|ClipboardChangeCase\)"
"

" key sequenses
syntax match    mayuKeySequense "\$\I\i*"

" parenthesis
syntax region   javaScriptParen transparent start="("  end=")"

" comments
syntax match    mayuComment "^#.*"
syntax region   mayuComment start="\(^\|\s\+\)#" end="$" keepend oneline

" operators
syntax match    mayuOperator "\(=\|:\|+=\|-=\)"

" strings
syntax region   mayuStringD start=+"+ skip=+\\\\\|\\$"+ end=+"+
syntax region   mayuStringS start=+'+ skip=+\\\\\|\\$'+ end=+'+

" regular expression
syntax region   mayuRegexpString start=+/\(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gim]\{-,3}+ oneline

" special keys
syntax match    mayuSpecialKeys "\([*~]\=\(C\|M\|A\|S\|NL\|CL\|SL\|KL\|IL\|IC\|MAX\|MIN\|MMAX\|MMIN\|T\|TS\)-\)\+\*\=\S\+"

" highlighting
if version >= 508 || !exists("did_mayu_syntax_inits")
    if version < 508
        let did_mayu_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif
    HiLink mayuDefine       Define
    HiLink mayuFunction     Function
    HiLink mayuInclude      PreProc
    HiLink mayuComment      Comment
    HiLink mayuOperator     Operator
    HiLink mayuStringD      String
    HiLink mayuStringS      String
    HiLink mayuRegexpString String
    HiLink mayuKeySequense  Identifier
    HiLink mayuOption       Keyword
    HiLink mayuSpecialKeys  Special
    delcommand HiLink
endif

let b:current_syntax = "mayu"

" vim: ts=4 sts=4 sw=4 et
