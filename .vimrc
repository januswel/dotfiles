" .vimrc
" Last Change: 2009/01/03 14:15:27.

" set ---------------------------------------------------------------------
" Display & Information
set number            " 行番号表示
set noruler           " カーソルの行,列数を非表示 ( statusline を設定するので )
set title             " 処理ファイル名をタイトルバーに表示
set laststatus=2      " 常にステータスラインを表示する
set showmode          " モード表示
set cmdheight=1       " コマンドラインは 1 行で
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
set wildmode=longest:full  " wildmenu + 共通する最長の文字列まで補完

" Tab Feature
set showtabline=2   " 常にタブバーを表示する


" syntax & colorscheme ----------------------------------------------------
syntax enable
colorscheme Janus


" let ---------------------------------------------------------------------
" very important
let maplocalleader='.'

" date format to insert automatically
let autodate_format='%Y/%m/%d %H:%M:%S'


" abbreviation ------------------------------------------------------------
abbr retrun return


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

" script ------------------------------------------------------------------


" vim: ft=vimperator sw=4 sts=4
