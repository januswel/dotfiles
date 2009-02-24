" .vimrc
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/24 15:31:12.

" initialization ----------------------------------------------------------
" get the personal directory for initialization
" and set it to environment variable $VIMPERSONAL
" for compatibility between Windows and Linux
let $VIMPERSONAL = $HOME . '/.vim'
if has('win32')
    let $VIMPERSONAL = $HOME . '/vimfiles'
endif


" options -----------------------------------------------------------------
" compatible mode off
set nocompatible

" path setting
" add path to my bin
set path='~/bin',path

" timing to write
set noautowrite     " set off writing a file automatically
set noautowriteall  " completely

" backup
" backup directory
let &backupdir=$VIMPERSONAL.'/backup/'
set backup          " backup feature on
set writebackup     " make a backup file before overwriting a file
set backupcopy=auto " how backup files are created, best one
set backupext=~     " tail character to add a backup file

" display & information
set showtabline=2   " show tab bar always
set number          " show line numbers
set noruler         " not show row and column number of cursor
set title           " display file name to edit
set laststatus=2    " show status line always
set showmode        " show mode name
set cmdheight=1     " height of command-line is 1 row
set nolist          " not show space characters (tab, line break)
set showmatch       " show pair parenthesis, bracket
set scrolloff=3     " above and below cursor number is 3 line
" filename [filetype][fileencoding:fileformat][RO]?[+]?    column:line/all-line[ percentage-of-buffer%]
set statusline=%t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L[%3p%%]

" tab & space
set tabstop=4       " tab width
set shiftwidth=4    " tab width (cindent and <<, >>)
set softtabstop=0   " tab width (<Tab>), when this is 0, use tabstop
set autoindent      " auto indent on
set expandtab       " replace tab to space

" search
set incsearch   " incremental search on
set hlsearch    " highlight matched word
set ignorecase  " pattern is performed as case insensitive normally
set smartcase   " but as case sensitive if capital character is contained
set wrapscan    " wrap

" backspacing
set backspace=indent,eol,start  " allow backspacing over autoindent, line breakes, start of insert

" command-line completion
set wildmenu            " command-line completion on
set wildmode=list:full  " list all candidates and full completion

" character encoding
set encoding=utf-8      " inside Vim
set fileencoding=utf-8  " buffer default (for new file)
" character encodings for exist files
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,utf-16,ucs-2-internal,ucs-2

" end-of-line format
set fileformat=unix             " buffer default (for new file)
set fileformats=unix,dos,mac    " EOL format for exist files


" filetype ----------------------------------------------------------------
filetype on         " filetype detection on
filetype plugin on  " for omni completion
filetype indent on  " each filetype indent on


" syntax highlight --------------------------------------------------------
syntax enable       " use syntax highlight

" color scheme: Janus.vim
colorscheme Janus   " my color scheme


" let ---------------------------------------------------------------------
" <Leader>
let mapleader=','

" plugin: autodate.vim
" date format to insert automatically
let autodate_format='%Y/%m/%d %H:%M:%S'


" autocmd -----------------------------------------------------------------
" open QuickFix window automatically
augroup showQuickFixWindow
    autocmd! showQuickFixWindow

    autocmd QuickFixCmdPost make cwindow    " make
    autocmd QuickFixCmdPost vimgrep cwindow " internal grep
augroup END

" for [x]html
augroup xhtml
    autocmd! xhtml

    " load xhtml template automatically
    autocmd BufNewFile *.html 0r $VIMPERSONAL/templates/xhtml.html
    " reindent by <C-b>
    " cludge: setting 'indentkeys' at ftplugin don't work in gvim
    autocmd FileType html,xhtml :setlocal indentkeys& indentkeys+=!

    " key mappings
    " ftplugin: html.vim
    " complete closing tab
    autocmd BufNewFile,BufRead *.html :inoremap <buffer><C-f> <Esc>:call InsertHTMLCloseTag()<CR>a<C-b>
    " modify by HTML Tidy
    autocmd BufNewFile,BufRead *.html :nnoremap <buffer><silent><Leader>h :call ModifyByHTMLTidy()<CR>
augroup END


" map ---------------------------------------------------------------------
" clear mappings
mapclear
mapclear!

" move cursor as it looks
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" tabnew is hard to complete
nnoremap t :tabnew<Space>

" switch tab
nnoremap <C-h> gT
nnoremap <C-l> gt

" move tab
" TabShift.vim plugin
nnoremap <silent><C-p> :call TabShift(-1)<CR>
nnoremap <silent><C-n> :call TabShift(+1)<CR>

" line break
nnoremap <silent><S-k> i<CR><Esc>

" scroll matched word to middle of screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" source
nnoremap <Leader>r :source ~/.gvimrc<CR>

" make
nnoremap <silent><Leader>m :update<CR>:make<CR>

" activate smart (keywords or omni) completion
" plugin: InsertTabWrapper.vim
inoremap <C-n> <C-r>=InsertTabWrapper()<CR>


" abbreviation ------------------------------------------------------------
" fix typo
abbreviate retrun return
abbreviate cosnt  const


" script ------------------------------------------------------------------
" detection character encoding automatically
" refer : http://www.kawaz.jp/pukiwiki/?vim#cb691f26
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " check which iconv can perform eucJP-ms
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    " check which iconv can perform JISX0213
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    " build fileencodings
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    " clear variables
    unlet s:enc_euc
    unlet s:enc_jis
endif

" if Japanese is not contained, set fileencoding to value of encoding
if has('autocmd')
    function! ReCheckFileEncoding()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call ReCheckFileEncoding()
endif

" show invisible characters
if has('autocmd') && has('syntax')
    syntax on
    function! ShowInvisibleCharacters()
        " double width space
        syntax match DoubleWidthSpace "\%u3000" display containedin=ALL
        " trailing whitespace characters
        syntax match TrailingWhitespace "\s\+$" display containedin=ALL
        " tab space
        syntax match TabSpace "\t" display containedin=ALL

        " these are performed as error
        highlight default link DoubleWidthSpace   Error
        highlight default link TrailingWhitespace Error
        highlight default link TabSpace           Search
    endf

    augroup showInvisible
        autocmd! showInvisible
        autocmd BufNew,BufRead * call ShowInvisibleCharacters()
    augroup END
endif

" for East Asia double width characters
if exists('&ambiwidth')
    set ambiwidth=double
endif


" vim: ts=4 sw=4 sts=0 et
