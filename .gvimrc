" .gvimrc
" Last Change: 2009/01/03 14:16:12.

" set ---------------------------------------------------------------------
" Compatible mode off
set nocompatible

" Path setting
" 自作コマンドを置いてあるディレクトリに path を通す
set path=path,"C:/Documents and Settings/Janus/My Documents/Software/bin"

" Backup
set backup              " make backup file
set writebackup         " 書き込み時にバックアップを作る
set backupdir=~/backup  " バックアップディレクトリの設定
set backupcopy=auto     " バックアップファイルの作成方法
set backupext=~         " バックアップファイルの末尾につけられる文字
set noautowrite         " 自動保存を off にする
set noautowriteall      " 同上

" Display & Information
set number            " 行番号表示
set noruler           " カーソルの行,列数を非表示 ( statusline を設定するので )
set title             " 処理ファイル名をタイトルバーに表示
set laststatus=2      " 常にステータスラインを表示する
set showmode          " モード表示
set cmdheight=1       " コマンドラインは 1 行で
set background=dark   " 暗い背景を使う
set nolist            " 非表示文字は表示しないまま
set showmatch         " 対になるカッコを強調表示
set scrolloff=3       " カーソルの周りは常に 3 行表示
" ファイル名、モード、文字コード、改行コード、読み取り専用フラグ、変更フラグ、列数 : 行数 / 全行数 [ カーソル位置の % ]
set statusline=%t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L[%3p%%] 

" Tab & Space
set tabstop=4      " タブ幅
set shiftwidth=4   " cindent や << / >> のインデント幅
set softtabstop=0  " tab キーを押したときに挿入される幅。 0 は tabstop の設定
set autoindent     " auto indent on
set expandtab      " タブを空白文字に置換する

" Search
set incsearch   " incremental search on
set hlsearch    " 検索語のハイライト
set ignorecase  " 大文字小文字を区別しない
set smartcase   " 大文字が含まれていた場合は区別する
set wrapscan    " ファイル終端までいったら最初に戻る

" Cursor
set backspace=2  " indent,eol,start

" Wild card
set wildmenu               " 補完候補表示
set wildmode=full:longest  " wildmenu + 共通する最長の文字列まで補完

" Tab
set showtabline=2   " 常にタブバーを表示する

" Syntax Highlight
syntax enable       " シンタクスハイライトを使う
colorscheme Janus   " 独自定義のカラースキーマを使用する

" character encoding
" line feed code
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,utf-16,ucs-2-internal,ucs-2
set encoding=utf-8
set fileformats=unix,dos,mac


" highlight ---------------------------------------------------------------


" autocmd -----------------------------------------------------------------


" let ---------------------------------------------------------------------
" very important
let maplocalleader='.'

" date format to insert automatically
let autodate_format='%Y/%m/%d %H:%M:%S'


" map ---------------------------------------------------------------------
" tabnew は補完が聞きづらいので定義しとく
map t :tabnew<Space>

" タブ移動
nnoremap <special> <C-h> gT
nnoremap <special> <C-l> gt

" タブ入れ替え
" TabShift.vim plugin
nnoremap <silent> <special> <C-p> :call TabShift(-1)<CR>
nnoremap <silent> <special> <C-n> :call TabShift(+1)<CR>

" カーソルの位置で改行
nmap <silent> <special> <S-k> i<CR><Esc>

" 検索語が画面の真ん中に来るようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz


" abbreviation ------------------------------------------------------------
abbr retrun return


" script ------------------------------------------------------------------
" refer : http://www.kawaz.jp/pukiwiki/?vim#cb691f26
" 文字コードの自動認識
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    " fileencodingsを構築
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
    " 定数を処分
    unlet s:enc_euc
    unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" 日本語入力時にカーソルの色を変更する
if has('multi_byte_ime') || has('xim')
    highlight CursorIM guibg=Red guifg=NONE
endif


" vim: ft=vimperator sw=4 sts=4
