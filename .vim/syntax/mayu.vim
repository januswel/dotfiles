" .mayu syntax file
" Language:		mayu setting file
" Maintainer:		AOYAMA Shotaro (super-onigiri / mm)
" Last Change:		2005 May 22


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword mayuKey	key
syn keyword mayuKeyseq	keyseq
syn keyword mayuMod	mod
syn keyword mayuWindow	window
syn keyword mayuKeymap	keymap
syn keyword mayuInclude	include
syn keyword mayuFunction Default KeymapParent KeymapWindow KeymapPrevPrefix OtherWindowClass Prefix Keymap Sync Toggle     EditNextModifier Variable Repeat Undefined Ignore PostMessage     ShellExecute SetForegroundWindow LoadSetting VK Wait InvestigateCommand     MayuDialog DescribeBindings HelpMessage HelpVariable WindowRaise WindowLower     WindowMinimize WindowMaximize WindowHMaximize WindowVMaximize WindowHVMaximize WindowMove     WindowMoveTo WindowMoveVisibly WindowClingToLeft WindowClingToRight WindowClingToTop WindowClingToBottom     WindowClose WindowToggleTopMost WindowIdentify WindowSetAlpha WindowRedraw WindowResizeTo     WindowMonitor WindowMonitorTo MouseMove MouseWheel ClipboardChangeCase ClipboardUpcaseWord     ClipboardDowncaseWord ClipboardCopy EmacsEditKillLinePred EmacsEditKillLineFunc LogClear DirectSSTP     PlugIn Recenter SetImeStatus    
syn match   mayuComment	"^#.*"
syn match   mayuOperator "="

" Default highlighting
if version >= 508 || !exists("did_mayu_syntax_inits")
  if version < 508
    let did_mayu_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink mayuKey	Type
  HiLink mayuKeyseq	Define
  HiLink mayuMod	Number
  HiLink mayuFunction	Function
  HiLink mayuInclude	PreProc
  HiLink mayuComment	Comment
  HiLink mayuWindow	Special
  HiLink mayuOperator	Operator
  HiLink mayuKeymap	Constant
  delcommand HiLink
endif

let b:current_syntax = "mayu"

" vim: ts=8
