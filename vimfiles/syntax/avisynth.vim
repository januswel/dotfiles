" vim syntax file
" Filename:     avisynth.vim
" Language:     AviSynth
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 30.
" Version:      0.14


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif
let b:current_syntax = "avisynth"

" case insensitive
syntax case ignore

" line continuation
syntax match    avsLineContinuationFrom /\\\n/ contains=avsLineContinuation
syntax match    avsLineContinuationTo   /^\s*\\/ contains=avsLineContinuation
syntax match    avsLineContinuation     /\\/ display contained

" boolean
syntax keyword  avsBoolean true false yes no

" number
syntax match    avsNumberDecimal        /[+-]\=\<\d\+\%(\.\d\+\)\=\>/ display
syntax match    avsNumberHexadecimal    /\<0x\x\+\>/ display

" string
syntax match    avsStringDoubleQuote    /"[^"]*"/
syntax region   avsStringMultiLine      start=/"""/ end=/"""/

" exception
syntax keyword  avsException try catch

" internal function
syntax keyword  avsFunctionNumeric
            \ Max Min MulDiv Floor Ceil Round Sin Cos Pi Exp Log Pow Sqrt Abs
            \ Sign Int Frac Float Rand Spline
syntax keyword  avsFunctionString
            \ LCase UCase StrLen RevStr LeftStr RightStr MidStr FindStr Chr
            \ Time
syntax keyword  avsFunctionBoolean
            \ IsBool IsClip IsFloat IsInt IsString Exist Defined
syntax keyword  avsFunctionConversion
            \ Value HexValue String
syntax keyword  avsFunctionControll
            \ Apply Eval Import Select Default Assert NOP SetMemoryMax
            \ SetWorkingDir SetPlanarLegasyAlignment OPT_AllowFloatAudio
            \ OPT_UseWaveExtensible
syntax keyword  avsFunctionVersion
            \ VersionNumber VersionString
syntax keyword  avsFunctionRuntime
            \ AverageLuma AverageChromaU AverageChromaV RGBDifference
            \ LumaDifference ChromaUDifference ChromaVDifference
            \ RGBDifferenceFromPrevious YDifferenceFromPrevious
            \ UDifferenceFromPrevious VDifferenceFromPrevious
            \ RGBDifferenceToNext YDifferenceToNext UDifferenceToNext
            \ VDifferenceToNext YPlaneMax UPlaneMax VPlaneMax
            \ YPlaneMin UPlaneMin VPlaneMin YPlaneMedian UPlaneMedian
            \ VPlaneMedian YPlaneMinMaxDifference UPlaneMinMaxDifference
            \ VPlaneMinMaxDifference

" clip properties
syntax keyword  avsPropertyClip
            \ Width Height FrameCount FrameRate FrameRateNumerator
            \ FrameRateDenominator AudioRate AudioLength AudioLengthF
            \ AudioChannels AudioBits IsAudioFloat IsAudioInt IsPlanar
            \ IsRGB IsRGB24 IsRGB32 IsYUV IsYUY2 IsYV12 IsFieldBased
            \ IsFrameBased IsInterleaved GetParity HasAudio HasVideo

" plugins
syntax keyword  avsPlugin
            \ LoadPlugin LoadVirtualDubPlugin LoadVFAPIPlugin
            \ LoadCPlugin Load_Stdcall_Plugin

" filters
syntax keyword  avsFilterMediaFile
            \ AVISource OpenDMLSource AVIFileSource DirectShowSource
            \ ImageReader ImageSource ImageWriter SegmentedAVISource
            \ SegmentedDirectShowSource WAVSource
syntax keyword  avsFilterColor
            \ ColorYUV ConvertToRGB ConvertToYUY2 ConvertToYV12
            \ ConvertBackToYUY2 ConvertToRGB32 ConvertToRGB24
            \ FixLuminance Greyscale Invert Levels Limiter MergeARGB
            \ MergeRGB Merge MergeChroma MergeLuma RGBAdjust ShowAlpha
            \ ShowRed ShowGreen ShowBlue SwapUV UToY VToY YToUV Tweak
syntax keyword  avsFilterOverlay
            \ ColorKeyMask Layer Mask Overlay ResetMask Subtract
syntax keyword  avsFilterGeometric
            \ AddBorders Crop CropBottom FlipHorizonal FlipVertical
            \ Letterbox ReduceBy2 HorizontalReduceBy2 VerticalReduceBy2
            \ BilinearResize BicubicResize BlackmanResize GaussResize
            \ LanczosResize Lanczos4Resize PointResize Spline16Resize
            \ Spline36Resize Spline64Resize TurnLeft TurnRight Turn180
syntax keyword  avsFilterPixel
            \ Blur Sharpen GeneralConvolution SpatialSoften
            \ TemporalSoften FixBrokenChromaUpsampling
syntax keyword  avsFilterTimeline
            \ AlignedSplice UnalignedSplice AssumeFPS AssumeScaledFPS
            \ ChangeFPS ConvertFPS DeleteFrame Dissolve DuplicateFrame
            \ FadeIn0 FadeOut0 FadeIn FadeOut FadeIn2 FadeOut2 FadeIO0
            \ FadeIO FadeIO2 FreezeFrame Interleave Loop Reverse
            \ SelectEven SelectOdd SelectEvery SelectRangeEvely Trim
syntax keyword  avsFilterInterlace
            \ AssumeFrameBased AssumeFieldBased AssumeTFF AssumeBFF Bob
            \ ComplementParity DoubleWeave PeculiarBlend Pulldown
            \ SeparateFields SwapFields Weave
syntax keyword  avsFilterAudio
            \ Amplify AmplifydB AssumeSampleRate AudioDub AudioDubEx
            \ ConvertToMono ConvertAudioTo8bit ConvertAudioTo16bit
            \ ConvertAudioTo24bit ConvertAudioTo32bit ConvertAudioToFloat
            \ DelayAudio EnsureVBRMP3Sync GetChannel KillAudio KillVideo
            \ MergeChannels MixAudio Normalize ResampleAudio SSRC SuperEQ
            \ TimeStretch
syntax keyword  avsFilterConditional
            \ Animate ApplyRange ConditionalFilter FrameEvaluate ScriptClip
            \ ConditionalReader TCPDeliver WriteFile WriteFileIf
            \ WriteFileStart WriteFileEnd
syntax keyword  avsFilterDebug
            \ BlankClip Blackness ColorBars Compare Histogram Info
            \ MessageClip ShowFiveVersions ShowFrameNumber ShowSMPTE
            \ ShowTime StackHorizontal StackVertical Subtitle Tone Version

" statements
syntax keyword  avsControl return
syntax keyword  avsVariableStatement global

" special variables
syntax keyword  avsSpecialVariable  last

" define function
syntax match    avsDefineFunction       /\<function\>\s*\S\+(.\{-})/ contains=avsDefineFunctionStart,avsDefineFunctionType,avsStringDoubleQuote
syntax keyword  avsDefineFunctionStart  function contained
syntax match    avsDefineFunctionType   /\<\%(clip\|string\|int\|float\|bool\|val\)\>/ contained

" color
syntax match    avsColorHexadecimal /\$\x\{6}\>/ display
syntax match    avsColorHexadecimal /\$\x\{8}\>/ display

" comment
syntax keyword  avsCommentTodo          TODO FIXME XXX TBD contained
syntax region   avsCommentLine          start=/\%(^\|\s\+\)#/ end=/$/ contains=avsCommentTodo keepend oneline
syntax region   avsCommentBlock         start="/\*" end="\*/" contains=avsCommentTodo
syntax region   avsCommentNestedBlock   start=/\[\*/ end=/\*\]/ contains=avsCommentTodo,avsCommentNestedBlock
syntax region   avsCommentEndDelimiter  start=/__END__/ skip=/./ end=/./ contains=avsCommentTodo


" all
syntax cluster avsAll contains=ALL


syntax case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_avs_syntax_inits")
  if version < 508
    let did_avs_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink avsLineContinuation        Special

  HiLink avsBoolean                 Boolean

  HiLink avsNumberDecimal           Number
  HiLink avsNumberHexadecimal       Number

  HiLink avsStringDoubleQuote       String
  HiLink avsStringMultiLine         String

  HiLink avsException               Exception

  HiLink avsFunctionNumeric         Function
  HiLink avsFunctionString          Function
  HiLink avsFunctionBoolean         Function
  HiLink avsFunctionConversion      Function
  HiLink avsFunctionControll        Function
  HiLink avsFunctionVersion         Function
  HiLink avsFunctionRuntime         Function

  HiLink avsPropertyClip            Identifier
  HiLink avsPlugin                  Include

  HiLink avsFilterMediaFile         Function
  HiLink avsFilterColor             Function
  HiLink avsFilterOverlay           Function
  HiLink avsFilterGeometric         Function
  HiLink avsFilterPixel             Function
  HiLink avsFilterTimeline          Function
  HiLink avsFilterInterlace         Function
  HiLink avsFilterAudio             Function
  HiLink avsFilterConditional       Function
  HiLink avsFilterDebug             Function

  HiLink avsDefineFunctionStart     Statement
  HiLink avsDefineFunctionType      Type
  HiLink avsControl                 Statement
  HiLink avsVariableStatement       Statement
  HiLink avsSpecialVariable         SpecialChar
  HiLink avsColorHexadecimal        Special

  HiLink avsCommentLine             Comment
  HiLink avsCommentBlock            Comment
  HiLink avsCommentNestedBlock      Comment
  HiLink avsCommentEndDelimiter     Comment
  HiLink avsCommentTodo             Todo

  delcommand HiLink
endif

" vim: ts=4 sts=4 sw=4 et
