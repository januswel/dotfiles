" vim syntax file
" Filename:     hatena.vim
" Language:     hatena notation
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 30.
" Version:      0.11
" Refer:        http://hatenadiary.g.hatena.ne.jp/keyword/%e3%81%af%e3%81%a6%e3%81%aa%e8%a8%98%e6%b3%95%e4%b8%80%e8%a6%a7

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syn clear
elseif exists("b:current_syntax")
    finish
endif

runtime! syntax/html.vim
unlet b:current_syntax
syn clear   htmlError

let b:current_syntax = "hatena"

" case sensitive
syn case match

syn sync minlines=50

" number
syn match   hatenaNumber        /\<\d\+\%(\.\d\+\)\=\>/ display
syn match   hatenaDecimalInner  /\d\+\%(\.\d\+\)\=/ contained display
syn match   hatenaIntegerInner  /\d\+/ contained display

" head
syn match   hatenaHead              /^\*/ nextgroup=hatenaHeadCategory skipwhite
syn match   hatenaHeadTimeStamp     /\%(^\*\)\@<=\d\{10}\*/ contains=hatenaHeadIdentifier,hatenaIntegerInner nextgroup=hatenaHeadCategory skipwhite
syn match   hatenaHeadWithTime      /\%(^\*\)\@<=t\%(+\d\+\)\=\*/ contains=hatenaHeadIdentifier,hatenaIntegerInner nextgroup=hatenaHeadCategory skipwhite
syn match   hatenaHeadWithName      /\%(^\*\)\@<=\%([a-su-z\u][\a\d]*\|t[\a\d]\+\)\*/ contains=hatenaHeadIdentifier nextgroup=hatenaHeadCategory skipwhite
syn match   hatenaHeadIdentifier    /\*/ contained
syn match   hatenaHeadCategory      /\[[^\[\]]*\]/ contained nextgroup=hatenaHeadCategory

" subhead
syn match   hatenaSubHead   /^\*\{2,3}/

" list
syn match   hatenaListUnordered     /^-\+/
syn match   hatenaListOrdered       /^+\+/
syn region  hatenaListDefinition    oneline matchgroup=hatenaListDefinitionIdentifier start=/^:/ end=/:/

" table
syn region  hatenaTable             start=/^|/ end=/|$/ oneline contains=hatenaTableIdentifier,hatenaTableCellHead
syn match   hatenaTableIdentifier   /|/ contained
syn match   hatenaTableCellHead     /\*[^|]*/ contained

" quote
syn region  hatenaQuote                 matchgroup=hatenaQuoteIdentifier start='^>\%(\%(https\=://[^>]\+\)\=>$\)\@=' end=/^<<$/ contains=hatenaQuote,hatenaQuoteCite
syn match   hatenaQuoteCite             '\%(^>\)\@<=\%(https\=://[^>]\+\)\=>$' contains=hatenaQuoteStartTrail,hatenaQuoteCiteURL,hatenaQuoteCiteTitle,hatenaQuoteCiteBookmark
syn match   hatenaQuoteCiteURL          'https\=://[^:>]\+' contained nextgroup=hatenaQuoteCiteTitle,hatenaQuoteCiteTitleWith,hatenaQuoteCiteBookmark,hatenaQuoteStartTrail
syn match   hatenaQuoteCiteTitle        /:title/ contains=hatenaQuoteCiteDelimiter contained nextgroup=hatenaQuoteCiteBookmark,hatenaQuoteStartTrail
syn match   hatenaQuoteCiteTitleWith    /:title=/ contains=hatenaQuoteCiteDelimiter contained nextgroup=hatenaQuoteCiteTitleData
syn match   hatenaQuoteCiteTitleData    /[^:>]\+/ contained nextgroup=hatenaQuoteCiteBookmark nextgroup=hatenaQuoteStartTrail
syn match   hatenaQuoteCiteBookmark     /:bookmark/ contains=hatenaQuoteCiteDelimiter contained nextgroup=hatenaQuoteStartTrail
syn match   hatenaQuoteStartTrail       />$/ contained
syn match   hatenaQuoteCiteDelimiter    /:/ contained

" pre
syn region  hatenaPre   matchgroup=hatenaPreIdentifier start=/^>|$/ end=/|<$/ contains=hatenaPre

" super pre (with syntax highlight) and aa notation
" refer: http://hatenadiary.g.hatena.ne.jp/keyword/%e3%82%bd%e3%83%bc%e3%82%b9%e3%82%b3%e3%83%bc%e3%83%89%e3%82%92%e8%89%b2%e4%bb%98%e3%81%91%e3%81%97%e3%81%a6%e8%a8%98%e8%bf%b0%e3%81%99%e3%82%8b%ef%bc%88%e3%82%b7%e3%83%b3%e3%82%bf%e3%83%83%e3%82%af%e3%82%b9%e3%83%bb%e3%83%8f%e3%82%a4%e3%83%a9%e3%82%a4%e3%83%88%ef%bc%89
syn region  hatenaSuperPre              matchgroup=hatenaSuperPreIdentifier start=/^>|\%([^|]*|$\)\@=/ end=/^||<$/ contains=hatenaSuperPreSyntax
syn region  hatenaSuperPre              matchgroup=hatenaSuperPreIdentifier start=/^>||\@=/ end=/^||<$/ contains=hatenaSuperPreSyntax
syn match   hatenaSuperPreSyntax        /\%(^>|\)\@<=[^|]*|$/ contained contains=hatenaSuperPreStartTrail,hatenaSuperPreTypeAuto,hatenaSuperPreType
syn match   hatenaSuperPreStartTrail    /|$/ contained display
syn match   hatenaSuperPreTypeAuto      /?/ contained display
syn keyword hatenaSuperPreType          contained a2ps a65 aap abap abaqus abc abel acedb ada aflex ahdl alsaconf amiga aml ampl ant antlr apache apachestyle arch art asm asm68k asmh8300 asn aspperl aspvbs asterisk asteriskvm atlas automake ave awk ayacc b baan basic bc bdf bib bindzone blank bst btm c calendar catalog cdl cf cfg ch change changelog chaskell cheetah chill chordpro cl clean clipper cmake cobol colortest conf config context cpp crm crontab cs csc csh csp css cterm ctrlh cupl cuplsim cvs cvsrc cweb cynlib cynpp d dcd dcl debchangelog debcontrol debsources def desc desktop dictconf dictdconf diff dircolors diva django dns docbk docbksgml docbkxml dosbatch dosini dot doxygen dracula dsl dtd dtml dylan dylanintr dylanlid ecd edif eiffel elf elinks elmfilt erlang eruby esmtprc esqlc esterel eterm eviews exim expect exports fasm fdcc fetchmail fgl flexwiki focexec form forth fortran foxpro fstab fvwm fvwm2m4 gdb gdmo gedcom gkrellmrc gnuplot gp gpg grads gretl groff groovy group grub gsp gtkrc haskell hb help hercules hex hitest hog html htmlcheetah htmldjango htmlm4 htmlos ia64 icemenu icon idl idlang indent inform initex inittab ipfilter ishd iss ist jal jam jargon java javacc javascript jess jgraph jproperties jsp kconfig kix kscript kwt lace latte ld ldif lex lftp lhaskell libao lifelines lilo limits lisp lite loginaccess logindefs logtalk lotos lout lpc lprolog lscript lss lua lynx m4 mail mailaliases mailcap make man manconf manual maple masm mason master matlab maxima mel mf mgl mgp mib mma mmix modconf model modsim3 modula2 modula3 monk moo mp mplayerconf mrxvtrc msidl msql mupad mush muttrc mysql named nanorc nasm nastran natural ncf netrc netrw nosyntax nqc nroff nsis objc objcpp ocaml occam omnimark openroad opl ora pamconf papp pascal passwd pcap pccts perl pf pfmain php phtml pic pike pilrc pine pinfo plaintex plm plp plsql po pod postscr pov povini ppd ppwiz prescribe procmail progress prolog protocols psf ptcap purifylog pyrex python qf quake r racc radiance ratpoison rc rcs rcslog readline rebol registry remind resolv rexx rhelp rib rnc rnoweb robots rpcgen rpl rst rtf ruby samba sas sather scheme scilab screen sdl sed sendpr sensors services setserial sgml sgmldecl sgmllnx sh sicad sieve simula sinda sindacmp sindaout sisu skill sl slang slice slpconf slpreg slpspi slrnrc slrnsc sm smarty smcl smil smith sml snnsnet snnspat snnsres snobol4 spec specman spice splint spup spyce sql sqlanywhere sqlforms sqlinformix sqlj sqloracle sqr squid sshconfig sshdconfig st stata stp strace sudoers svn syncolor synload syntax sysctl tads tags tak takcmp takout tar tasm tcl tcsh terminfo tex texinfo texmf tf tidy tilde tli tpp trasys trustees tsalt tsscl tssgm tssop uc udevconf udevperm udevrules uil updatedb valgrind vb vera verilog verilogams vgrindefs vhdl vim viminfo virata vmasm vrml vsejcl wdiff web webmacro wget whitespace winbatch wml wsh wsml wvdial xdefaults xf86conf xhtml xinetd xkb xmath xml xmodmap xpm xpm2 xquery xs xsd xslt xxd yacc yaml z8a zsh

" footnote
syn match   hatenaFootnote              /[()]\@<!(([^)]\+))[()]\@!/ contains=hatenaFootnoteIdentifier
syn match   hatenaFootnoteIdentifier    /\%(((\|))\)/ contained

" (super) reading rest notation
syn match   hatenaReadingRest       /^=\{4}$/
syn match   hatenaSuperReadingRest  /^=\{5}$/

" deny p element
syn region  hatenaDenyPElement  matchgroup=hatenaDenyPElementIdentifier start=/^><\@=/ end=/>\@<=<$/ contains=htmlTag,htmlEndTag

" http, ftp, mailto
syn match   hatenaHttp      'https\=://[-_.!~*'()a-zA-Z0-9;\/?:\@&=+\$,%#]\+'
syn match   hatenaFtp       'ftp://[-_.!~*'()a-zA-Z0-9;\/?:\@&=+\$,%#]\+' containedin=hatenaBracket
syn match   hatenaMailto    'mailto:[-_.!~*'()a-zA-Z0-9;\/?:\@&=+\$,%#]\+' containedin=hatenaBracket

" map
syn match   hatenaMap               /map:x\d\+\%(\.\d\+\)\=y\d\+\%(\.\d\+\)\=/ contains=hatenaMapDelimiter,hatenaDecimalInner nextgroup=hatenaMapModifier
syn match   hatenaMapInner          /\[\@<=map:x\d\+\%(\.\d\+\)\=y\d\+\%(\.\d\+\)\=/ contains=hatenaMapDelimiter,hatenaDecimalInner nextgroup=hatenaMapModifier containedin=hatenaBracket
syn match   hatenaMapModifier       /:\%(map\|satellite\|hybrid\)/ contains=hatenaMapDelimiter contained nextgroup=hatenaMapModifierSub
syn match   hatenaMapModifierSub    /:\%(h\d\+\|w\d\+\)/ contains=hatenaMapDelimiter,hatenaIntegerInner contained
syn match   hatenaMapDelimiter      /:/ contained

" brackets: tex, ukulele, auto-link and search notation
syn region  hatenaBracket           oneline matchgroup=hatenaBracketIdentifier start=/\[/ end=/\]/ contains=hatenaHttpInBracket
syn match   hatenaBracketDelimiter  /:/ contained
syn match   hatenaTex               /\[\@<=tex:/ contains=hatenaBracketDelimiter contained containedin=hatenaBracket
syn match   hatenaUkulele           /\[\@<=uke:/ contains=hatenaBracketDelimiter contained containedin=hatenaBracket
syn match   hatenaNicoNico          /\[\@<=niconico:/ contains=hatenaBracketDelimiter contained containedin=hatenaBracket
syn match   hatenaGoogle            /\[\@<=google:/ contains=hatenaBracketDelimiter contained containedin=hatenaBracket nextgroup=hatenaGoogleAttr
syn match   hatenaGoogleAttr        /\%(image\|news\):/ contains=hatenaBracketDelimiter contained
syn match   hatenaAmazon            /\[\@<=amazon:/ contains=hatenaBracketDelimiter contained containedin=hatenaBracket
syn match   hatenaWikipedia         /\[\@<=wikipedia:/ contains=hatenaBracketDelimiter contained containedin=hatenaBracket nextgroup=hatenaWikipediaLang
syn match   hatenaWikipediaLang     /[\l]\{2}:/ contains=hatenaBracketDelimiter contained
syn match   hatenaSearch            /\[\@<=search:/ contains=hatenaBracketDelimiter nextgroup=hatenaSearchModifier containedin=hatenaBracket
syn match   hatenaSearchModifier    /\%(keyword\|web\|question\|asin\|rakuten\|video\):/ contains=hatenaBracketDelimiter contained

" http in brackets
syn match   hatenaHttpInBracket             'https\=://[-_.!~*'()a-zA-Z0-9;\/?:\@&=+\$,%#]\+' contained nextgroup=hatenaHttpTitle,hatenaHttpTitleWith,hatenaHttpImage,hatenaHttpImageWith,hatenaHttpBookmark,hatenaHttpMovie,hatenaHttpOthers
syn match   hatenaHttpTitle                 /:title/ contains=hatenaBracketDelimiter contained nextgroup=hatenaHttpBookmark
syn match   hatenaHttpTitleWith             /:title=/ contains=hatenaBracketDelimiter contained nextgroup=hatenaHttpTitleData
syn match   hatenaHttpTitleData             /[^:\]]\+/ contained nextgroup=hatenaHttpBookmark
syn match   hatenaHttpImage                 /:image/ contains=hatenaBracketDelimiter contained nextgroup=hatenaHttpImageAttr
syn match   hatenaHttpImageWith             /:image=/ contains=hatenaBracketDelimiter contained
syn match   hatenaHttpImageAttr             /:\%(h\d\+\|w\d\+\|large\|small\|left\|right\)/ contains=hatenaBracketDelimiter,hatenaIntegerInner contained nextgroup=hatenaHttpImageAttrPlural
syn match   hatenaHttpImageAttrPlural       /,\%(h\d\+\|w\d\+\|large\|small\|left\|right\)/ contains=hatenaHttpImageAttrDelimiter,hatenaIntegerInner contained nextgroup=hatenaHttpImageAttrPlural
syn match   hatenaHttpImageAttrDelimiter    /,/ contained
syn match   hatenaHttpBookmark              /:bookmark/ contains=hatenaBracketDelimiter contained nextgroup=hatenaHttpTitle
syn match   hatenaHttpMovie                 /:movie/ contains=hatenaBracketDelimiter contained nextgroup=hatenaHttpMovieAttr
syn match   hatenaHttpMovieAttr             /:\%(h\d\+\|w\d\+\|small\)/ contains=hatenaBracketDelimiter,hatenaIntegerInner contained nextgroup=hatenaHttpMovieAttr
syn match   hatenaHttpOthers                /:\%(barcode\|sound\)/ contains=hatenaBracketDelimiter contained

" deny auto-link
syn region  hatenaDenyAutoLink matchgroup=hatenaDenyAutoLinkIdentifier start=/\[\]/ end=/\[\]/

" question notation
syn match   hatenaQuestionDelimiter /:/ contained
syn match   hatenaQuestion          /question:/ contains=hatenaQuestionDelimiter nextgroup=hatenaQuestionId
syn match   hatenaQuestionInner     /\[\@<=question:/ contains=hatenaQuestionDelimiter nextgroup=hatenaQuestionId containedin=hatenaBracket
syn match   hatenaQuestionId        /\d\+/ contained nextgroup=hatenaQuestionTitle,hatenaQuestionNumber,hatenaQuestionDetail,hatenaQuestionImage
syn match   hatenaQuestionTitle     /:title=\=/ contains=hatenaQuestionDelimiter contained
syn match   hatenaQuestionNumber    /:q\d\+/ contains=hatenaQuestionDelimiter,hatenaIntegerInner contained nextgroup=hatenaQuestionTitle,hatenaQuestionDetail,hatenaQuestionImage
syn match   hatenaQuestionDetail    /:detail/ contains=hatenaQuestionDelimiter contained
syn match   hatenaQuestionImage     /:image/ contains=hatenaQuestionDelimiter contained nextgroup=hatenaQuestionImageAttr
syn match   hatenaQuestionImageAttr /:small/ contains=hatenaQuestionDelimiter contained

" id with premodifier notation ---
" delimiter
syn match   hatenaIdPreDelimiter    /:/ contained

" tag, keyword
syn match   hatenaTagInner      /:\=t:/ contains=hatenaIdPreDelimiter contained

" anntena, diary, group, haiku, rss
syn match   hatenaAnntena       /a:id:/ contains=hatenaIdPreDelimiter
syn match   hatenaDiary         /d:/ contains=hatenaIdPreDelimiter nextgroup=hatenaId,hatenaKeywordModifier
syn match   hatenaDiaryInner    /\[\@<=d:/ contains=hatenaIdPreDelimiter nextgroup=hatenaId,hatenaKeywordModifier containedin=hatenaBracket
syn match   hatenaGroup         /g:/ contains=hatenaIdPreDelimiter nextgroup=hatenaGroupName
syn match   hatenaGroupInner    /\[\@<=g:/ contains=hatenaIdPreDelimiter nextgroup=hatenaGroupName containedin=hatenaBracket
syn match   hatenaGroupName     /[^:]\+:/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaId,hatenaKeywordModifier
syn match   hatenaHaiku         /h:/ contains=hatenaIdPreDelimiter nextgroup=hatenaId,hatenaKeywordModifier
syn match   hatenaHaikuInner    /\[\@<=h:/ contains=hatenaIdPreDelimiter nextgroup=hatenaId,hatenaKeywordModifier containedin=hatenaBracket
syn match   hatenaRss           /r:id:/ contains=hatenaIdPreDelimiter

" idea
syn match   hatenaIdea          /i:/ contains=hatenaIdPreDelimiter nextgroup=hatenaId,hatenaIdeaTag
syn match   hatenaIdeaInner     /\[\@<=i:/ contains=hatenaIdPreDelimiter nextgroup=hatenaId,hatenaIdeaTag containedin=hatenaBracket
syn match   hatenaIdeaTag   /t:/ contains=hatenaIdPreDelimiter contained
syn match   hatenaIdea      /idea:/ contains=hatenaIdPreDelimiter nextgroup=hatenaIdeaId
syn match   hatenaIdeaId    /\d\+/ contained nextgroup=hatenaIdeaTitle
syn match   hatenaIdeaTitle /:title/ contains=hatenaIdPreDelimiter contained

" bookmark
syn match   hatenaBookmark          /b:/ contains=hatenaIdPreDelimiter nextgroup=hatenaBookmarkId,hatenaTagInner,hatenaKeywordModifier
syn match   hatenaBookmarkInner     /\[\@<=b:/ contains=hatenaIdPreDelimiter nextgroup=hatenaBookmarkId,hatenaTagInner,hatenaKeywordModifier containedin=hatenaBracket
syn match   hatenaBookmarkId        /id:/ contains=hatenaIdPreDelimiter nextgroup=hatenaBookmarkName
syn match   hatenaBookmarkName      /[^:]\+/ contained nextgroup=hatenaBookmarkOthers,hatenaTagInner,hatenaKeywordModifier,hatenaBookmarkDate
syn match   hatenaBookmarkDate      /:\d\{8}/ contains=hatenaIdPreDelimiter,hatenaIntegerInner contained
syn match   hatenaBookmarkOthers    /:\%(favorite\|asin\)/ contains=hatenaIdPreDelimiter contained

" fotolife
syn match   hatenaFotolife                      /f:/ contains=hatenaIdPreDelimiter nextgroup=hatenaFotolifeId,hatenaTagInner
syn match   hatenaFotolifeInner                 /\[\@<=f:/ contains=hatenaIdPreDelimiter nextgroup=hatenaFotolifeId,hatenaTagInner containedin=hatenaBracket
syn match   hatenaFotolifeId                    /id:/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaFotolifeName
syn match   hatenaFotolifeName                  /[^:]\+/ contained nextgroup=hatenaFotolifeResourceId,hatenaFotolifeOthers,hatenaTagInner
syn match   hatenaFotolifeResourceId            /:[^:]\+/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaFotolifeImage,hatenaFotolifeMovie
syn match   hatenaFotolifeImage                 /:image/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaFotolifeImageAttr
syn match   hatenaFotolifeImageAttr             /:\%(small\|medium\|h\d\+\|w\d\+\|left\|right\)/ contains=hatenaIdPreDelimiter,hatenaIntegerInner contained nextgroup=hatenaFotolifeImageAttrPlural
syn match   hatenaFotolifeImageAttrPlural       /,\%(small\|medium\|h\d\+\|w\d\+\|left\|right\)/ contains=hatenaFotolifeImageAttrDelimiter,hatenaIntegerInner contained nextgroup=hatenaFotolifeImageAttrPlural
syn match   hatenaFotolifeImageAttrDelimiter    /,/ contained
syn match   hatenaFotolifeMovie                 /:movie/ contains=hatenaIdPreDelimiter
syn match   hatenaFotolifeOthers                /:favorite/ contains=hatenaIdPreDelimiter contained

" graph
syn match   hatenaGraph             /graph:/ contains=hatenaIdPreDelimiter nextgroup=hatenaGraphId,hatenaTagInner
syn match   hatenaGraphInner        /\[\@<=graph:/ contains=hatenaIdPreDelimiter nextgroup=hatenaGraphId,hatenaTagInner containedin=hatenaBracket
syn match   hatenaGraphId           /id:/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaGraphName
syn match   hatenaGraphName         /[^:]\+/ contained nextgroup=hatenaGraphCaption
syn match   hatenaGraphCaption      /:[^:]\+/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaGraphImage
syn match   hatenaGraphImage        /:image/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaGraphImageAttr
syn match   hatenaGraphImageAttr    /:d\d\+/ contains=hatenaIdPreDelimiter,hatenaIntegerInner contained

" keyword
syn match   hatenaKeywordModifier       /:\=keyword:/ contains=hatenaIdPreDelimiter contained
syn match   hatenaKeyword               /\[\@<=keyword:/ contains=hatenaIdPreDelimiter nextgroup=hatenaKeywordWord contained containedin=hatenaBracket
syn match   hatenaKeywordWord           /[^:]\+/ contained nextgroup=hatenaKeywordMap,hatenaKeywordGraph
syn match   hatenaKeywordMap            /:map/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaKeywordMapModifier
syn match   hatenaKeywordMapModifier    /:\%(satellite\|hybrid\)/ contains=hatenaIdPreDelimiter contained
syn match   hatenaKeywordGraph          /:graph/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaKeywordGraphType,hatenaKeywordGraphSpan
syn match   hatenaKeywordGraphType      /:\%(refcount\|refrank\|accessrank\)/ contains=hatenaIdPreDelimiter contained nextgroup=hatenaKeywordGraphSpan
syn match   hatenaKeywordGraphSpan      /:\%(\d\+\)[dwmy]/ contains=hatenaKeywordGraphSpan,hatenaIntegerInner contained
syn match   hatenaKeywordId             /k:id:/ contains=hatenaIdPreDelimiter
syn match   hatenaKeywordIdInner        /\[\@<=k:id:/ contains=hatenaIdPreDelimiter containedin=hatenaBracket

" id notation ---
syn match   hatenaIdDelimiter   /[:#]/ contained
syn match   hatenaId            /id:/ contains=hatenaIdDelimiter nextgroup=hatenaIdName
syn match   hatenaIdInner       /\[\@<=id:/ contains=hatenaIdDelimiter nextgroup=hatenaIdName containedin=hatenaBracket
syn match   hatenaIdName        /[^:]\+/ contains=hatenaIdDelimiter contained nextgroup=hatenaIdDate,hatenaIdMonth,hatenaIdArchive,hatenaIdOthers
syn match   hatenaIdMonth       /:\d\{6}/ contains=hatenaIdDelimiter,hatenaIntegerInner contained
syn match   hatenaIdDate        /:\d\{8}/ contains=hatenaIdDelimiter,hatenaIntegerInner contained nextgroup=hatenaIdTime
syn match   hatenaIdTime        /[:#]\d\{10}/ contains=hatenaIdDelimiter,hatenaIntegerInner contained
syn match   hatenaIdArchive     /:archive/ contains=hatenaIdDelimiter contained nextgroup=hatenaIdMonth
syn match   hatenaIdOthers      /:\%(image\|detail\|about\)/ contains=hatenaIdDelimiter contained

" keyword forcely
syn region  hatenaKeywordForce  matchgroup=hatenaKeywordForceIdentifier start=/\[\[/ end=/\]\]/

" product
syn match   hatenaProductDelimiter  /:/ contained
syn match   hatenaProductTitle      /:title/ contains=hatenaProductDelimiter contained
syn match   hatenaProductImage      /:\%(image\|detail\)/ contains=hatenaProductDelimiter contained nextgroup=hatenaProductImageAttr
syn match   hatenaProductImageAttr  /:\%(small\|large\)/ contains=hatenaProductDelimiter contained

" ISBN, ASIN
syn match   hatenaIsbn              /ISBN:/ contains=hatenaProductDelimiter nextgroup=hatenaIsbnTen,hatenaIsbnThirteen
syn match   hatenaIsbnInner         /\[\@<=ISBN:/ contains=hatenaProductDelimiter nextgroup=hatenaIsbnTen,hatenaIsbnThirteen contained containedin=hatenaBracket
syn match   hatenaIsbnTen           /\d\{9}[\dX]/ contained nextgroup=hatenaProductTitle,hatenaProductImage
syn match   hatenaIsbnThirteen      /\d\{13}/ contained nextgroup=hatenaProductTitle,hatenaProductImage
syn match   hatenaAsin              /asin:/ contains=hatenaProductDelimiter nextgroup=hatenaAsinId
syn match   hatenaAsinInner         /\[\@<=asin:/ contains=hatenaProductDelimiter nextgroup=hatenaAsinId contained containedin=hatenaBracket
syn match   hatenaAsinId            /[\a\d]\{10}/ contains=hatenaProductDelimiter nextgroup=hatenaProductTitle,hatenaProductImage

" rakuten
syn match   hatenaRakuten   /\[\@<=rakuten:/ contains=hatenaProductDelimiter contained containedin=hatenaBracket

" jan, ean
syn match   hatenaJanEan            /\%(jan\|ean\):/ contains=hatenaProductDelimiter nextgroup=hatenaJanEanId
syn match   hatenaJanEanInner       /\[\@<=\%(jan\|ean\):/ contains=hatenaProductDelimiter nextgroup=hatenaJanEanId contained containedin=hatenaBracket
syn match   hatenaJanEanId          /\d\{13}/ contained nextgroup=hatenaJanEanModifier
syn match   hatenaJanEanModifier    /:\%(title=\=\|image\|barcode\)/ contains=hatenaProductDelimiter contained

" comment
syn region  hatenaComment   start=/<!--/ end=/-->/


" highlighting
if version >= 508 || !exists("did_hatena_syntax_inits")
    if version < 508
        let did_hatena_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink hatenaHead                       Function
    HiLink hatenaHeadTimeStamp              Number
    HiLink hatenaHeadWithTime               Statement
    HiLink hatenaHeadWithName               Identifier
    HiLink hatenaHeadIdentifier             Function
    HiLink hatenaHeadCategory               Special

    HiLink hatenaSubHead                    Function

    HiLink hatenaListUnordered              Function
    HiLink hatenaListOrdered                Function
    HiLink hatenaListDefinitionIdentifier   Function

    HiLink hatenaTableIdentifier            Function
    HiLink hatenaTableCellHead              Special

    HiLink hatenaQuoteIdentifier            Function
    HiLink hatenaQuoteCiteURL               Underlined
    HiLink hatenaQuoteCiteTitle             Statement
    HiLink hatenaQuoteCiteTitleWith         Statement
    HiLink hatenaQuoteCiteBookmark          Statement
    HiLink hatenaQuoteStartTrail            Function
    HiLink hatenaQuoteCiteDelimiter         Delimiter

    HiLink hatenaPreIdentifier              Function

    HiLink hatenaSuperPreIdentifier         Function
    HiLink hatenaSuperPreStartTrail         Function
    HiLink hatenaSuperPreTypeAuto           Statement
    HiLink hatenaSuperPreType               Statement

    HiLink hatenaFootnoteIdentifier         Function

    HiLink hatenaReadingRest                Function
    HiLink hatenaSuperReadingRest           Function

    HiLink hatenaDenyPElementIdentifier     Function

    HiLink hatenaHttp                       Underlined
    HiLink hatenaFtp                        Underlined
    HiLink hatenaMailto                     Underlined

    HiLink hatenaNumber                     Number
    HiLink hatenaDecimalInner               Number
    HiLink hatenaIntegerInner               Number

    HiLink hatenaMap                        Function
    HiLink hatenaMapInner                   Function
    HiLink hatenaMapModifier                Statement
    HiLink hatenaMapModifierSub             Statement
    HiLink hatenaMapDelimiter               Delimiter

    HiLink hatenaBracketIdentifier          Function
    HiLink hatenaBracketDelimiter           Delimiter
    HiLink hatenaTex                        Function
    HiLink hatenaUkulele                    Function
    HiLink hatenaNiconico                   Function
    HiLink hatenaGoogle                     Function
    HiLink hatenaGoogleAttr                 Statement
    HiLink hatenaAmazon                     Function
    HiLink hatenaWikipedia                  Function
    HiLink hatenaWikipediaLang              Statement
    HiLink hatenaSearch                     Function
    HiLink hatenaSearchModifier             Statement

    HiLink hatenaHttpInBracket              Underlined
    HiLink hatenaHttpTitle                  Statement
    HiLink hatenaHttpTitleWith              Statement
    HiLink hatenaHttpImage                  Statement
    HiLink hatenaHttpImageWith              Statement
    HiLink hatenaHttpImageAttr              Statement
    HiLink hatenaHttpImageAttrPlural        Statement
    HiLink hatenaHttpImageAttrDelimiter     Delimiter
    HiLink hatenaHttpBookmark               Statement
    HiLink hatenaHttpMovie                  Statement
    HiLink hatenaHttpMovieAttr              Statement
    HiLink hatenaHttpOthers                 Statement

    HiLink hatenaDenyAutoLinkIdentifier     Function

    HiLink hatenaQuestion                   Function
    HiLink hatenaQuestionInner              Function
    HiLink hatenaQuestionId                 Number
    HiLink hatenaQuestionTitle              Statement
    HiLink hatenaQuestionNumber             Statement
    HiLink hatenaQuestionDetail             Statement
    HiLink hatenaQuestionImage              Statement
    HiLink hatenaQuestionImageAttr          Statement
    HiLink hatenaQuestionDelimiter          Delimiter

    HiLink hatenaIdPreDelimiter             Delimiter

    HiLink hatenaTagInner                   Statement

    HiLink hatenaAnntena                    Function
    HiLink hatenaDiary                      Function
    HiLink hatenaDiaryInner                 Function
    HiLink hatenaGroup                      Function
    HiLink hatenaGroupInner                 Function
    HiLink hatenaHaiku                      Function
    HiLink hatenaHaikuInner                 Function
    HiLink hatenaRss                        Function

    HiLink hatenaIdea                       Function
    HiLink hatenaIdeaInner                  Function
    HiLink hatenaIdeaTag                    Statement
    HiLink hatenaIdeaId                     Number
    HiLink hatenaIdeaTitle                  Statement

    HiLink hatenaBookmark                   Function
    HiLink hatenaBookmarkInner              Function
    HiLink hatenaBookmarkId                 Statement
    HiLink hatenaBookmarkDate               Number
    HiLink hatenaBookmarkOthers             Statement

    HiLink hatenaFotolife                   Function
    HiLink hatenaFotolifeInner              Function
    HiLink hatenaFotolifeId                 Statement
    HiLink hatenaFotolifeImage              Statement
    HiLink hatenaFotolifeImageAttr          Statement
    HiLink hatenaFotolifeImageAttrPlural    Statement
    HiLink hatenaFotolifeImageAttrDelimiter Delimiter
    HiLink hatenaFotolifeOthers             Statement

    HiLink hatenaGraph                      Function
    HiLink hatenaGraphInner                 Function
    HiLink hatenaGraphId                    Statement
    HiLink hatenaGraphImage                 Statement
    HiLink hatenaGraphImageAttr             Statement

    HiLink hatenaKeywordModifier            Statement
    HiLink hatenaKeyword                    Function
    HiLink hatenaKeywordMap                 Statement
    HiLink hatenaKeywordMapModifier         Statement
    HiLink hatenaKeywordGraph               Statement
    HiLink hatenaKeywordGraphType           Statement
    HiLink hatenaKeywordGraphSpan           Statement
    HiLink hatenaKeywordId                  Function
    HiLink hatenaKeywordIdInner             Function

    HiLink hatenaId                         Function
    HiLink hatenaIdArchive                  Statement
    HiLink hatenaIdOthers                   Statement
    HiLink hatenaIdDelimiter                Delimiter

    HiLink hatenaKeywordForceIdentifier     Function

    HiLink hatenaIsbn                       Function
    HiLink hatenaIsbnInner                  Function
    HiLink hatenaAsin                       Function
    HiLink hatenaAsinInner                  Function
    HiLink hatenaProductTitle               Statement
    HiLink hatenaProductImage               Statement
    HiLink hatenaProductImageAttr           Statement
    HiLink hatenaProductDelimiter           Delimiter

    HiLink hatenaRakuten                    Function

    HiLink hatenaJanEan                     Function
    HiLink hatenaJanEanInner                Function
    HiLink hatenaJanEanModifier             Statement

    HiLink hatenaComment                    Comment

    delcommand HiLink
endif

" vim: ts=4 sw=4 sts=0 et
