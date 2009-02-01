" .vimrc
" setting file for vim
"
" author janus_wel <janus.wel.3@gmail.com>
" Last Change: 2009/02/01 18:25:26.

" initialization ----------------------------------------------------------
" get vim runtime directory and set environment variable
" for compatibility between Windows and Linux
let $VIM_RUNTIME_DIR = $HOME . "/.vim"
if has("win32")
    let $VIM_RUNTIME_DIR = $HOME . "/vimfiles"
endif


" options -----------------------------------------------------------------
" compatible mode off
set nocompatible

" path setting
" add path to my bin
set path="~/bin",path

" timing to write
set noautowrite     " set off writing a file automatically
set noautowriteall  " completely

" backup
" backup directory
let &backupdir = $VIM_RUNTIME_DIR . "/backup/"
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
set background=dark " low impact for eye
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
autocmd QuickFixCmdPost make cwindow    " make
autocmd QuickFixCmdPost vimgrep cwindow " internal grep

" for [x]html
" I will write xhtml only
autocmd BufNewFile,BufRead *.html :set filetype=xhtml
" load xhtml template automatically
autocmd BufNewFile *.html 0r $VIM_RUNTIME_DIR/templates/xhtml_template.html
" ftplugin: html.vim
" complete closing tab
autocmd BufNewFile,BufRead *.html :inoremap <buffer><C-f> <Esc>:call InsertHTMLCloseTag()<CR>b2hi
" modify by HTML Tidy
autocmd BufNewFile,BufRead *.html :nnoremap <buffer><silent><Leader>h :call ModifyByHTMLTidy()<CR>


" map ---------------------------------------------------------------------
" move cursor as it looks
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" tabnew is hard to complete
nnoremap t :tabnew<Space>

" switch tab
nnoremap <special><C-h> gT
nnoremap <special><C-l> gt

" move tab
" TabShift.vim plugin
nnoremap <silent><special><C-p> :call TabShift(-1)<CR>
nnoremap <silent><special><C-n> :call TabShift(+1)<CR>

" line break
nnoremap <silent><special><S-k> i<CR><Esc>

" set matched word to middle of screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" source
nnoremap <Leader>r :source ~/.gvimrc<CR>
nnoremap <Leader>R :mapclear<CR>:source ~/.gvimrc<CR>

" make
nnoremap <silent><Leader>m :update<CR>:make<CR>

" activate smart (keywords or omni) completion
" plugin: InsertTabWrapper.vim
inoremap <C-n> <c-r>=InsertTabWrapper()<cr>


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
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" for East Asia double width characters
if exists('&ambiwidth')
    set ambiwidth=double
endif

" change cursor color to red on IME mode
if has('multi_byte_ime') || has('xim')
    highlight CursorIM guibg=Red guifg=NONE
endif


" vim: sw=4 sts=4
