" .vimrc
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/11/19 16:00:44.

" options {{{1
" general {{{2
set nocompatible    " compatible mode off

" path setting
set path^=~/bin/    " prepend my bin to 'path'

" timing to write
set noautowrite     " disable writing files automatically
set noautowriteall  " make my wish to vim thoroughly

" backup {{{2
" The "backup" directory that be found in runtime path at first,
" is backupdir.
let s:backupdir = globpath(&runtimepath, 'backup')
" Backup feature is enable when the backupdir exists.
if s:backupdir != ''
    set backup          " backup feature on
    set writebackup     " make a backup file before overwriting a file
    set backupcopy=auto " how backup files are created, best one
    set backupext=~     " trailing character of backup file
    let &backupdir = s:backupdir . ',' . &backupdir
endif
unlet s:backupdir

" display & information {{{2
set showtabline=2   " show tab bar always
set number          " show line numbers
set noruler         " don't show row and column number of cursor
set title           " display editing file name at title bar
set laststatus=2    " show status line always
set showmode        " show mode name
set cmdheight=1     " height of command-line is 1 row
set showmatch       " show pair parentheses, brackets and so on
set scrolloff=3     " above and below cursor number is 3 line
set nolist          " don't show space characters (tab, line break)
" sequence backslash ( yen in Japanese ), space "\ "
" are interpreted just space " ". thus, below command
" sets "  " to "tab" directive in 'listchars' option
set listchars=tab:\ \   " don't show tab even if 'list' is on
" filename [filetype][fileencoding:fileformat][RO]?[+]?    column:line/all-line[ percentage-of-buffer%]
set statusline=%t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L[%3p%%]

" tab, space and indent {{{2
set tabstop=4       " tab width
set shiftwidth=4    " number of spaces inserted by cindent, <<, >> and so on
" number of spaces inserted by <Tab> or deleted by <BS> (enterd by user)
set softtabstop=0   " when this is setted to 0, use content of 'tabstop'
set expandtab       " expand tab to spaces
set autoindent      " auto indent on

" search {{{2
set incsearch   " incremental search on
set hlsearch    " highlight matched word
set ignorecase  " use ignore case normally
set smartcase   " but use match case when capital character is contained
set wrapscan    " search wrap around the end of the file

" backspacing {{{2
" allow backspacing over autoindent, line breakes, start of insert
set backspace=indent,eol,start

" completion {{{2
" command-line mode
set wildmenu            " command-line completion on
set wildmode=list:full  " list all candidates and complete full words

" insert mode
" scanning places (and order) by keyword completion
" . : current buffer
" w : buffers from other windows
" b : other loaded buffers
" t : tab completion
" i : current and included files
set complete=.,w,b,t,i
" options
" menu      : use a popup menu
" menuone   : use a popup menu also when only one match
" preview   : show extra information in the preview window
set completeopt=menu,menuone,preview

" encoding & format {{{2
" character encoding
set encoding=utf-8      " inside Vim
set langmenu=ja.utf-8   " language of menu
set fileencoding=utf-8  " buffer default (for new file)
" character encodings for exist files
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,utf-16,ucs-2-internal,ucs-2

" end-of-line format
set fileformat=unix             " buffer default (for new file)
set fileformats=unix,dos,mac    " EOL format for exist files


" filetype {{{1
filetype on         " filetype detection on
filetype plugin on  " for omni completion
filetype indent on  " each filetype indent on


" syntax highlight {{{1
syntax enable       " use syntax highlight

" color scheme: Janus.vim
colorscheme Janus   " my color scheme


" let {{{1
" general {{{2
" <Leader>
let mapleader=','

" plugin: autodate.vim
" date format to insert automatically
let autodate_format='%Y/%m/%d %H:%M:%S'

" setting for bash (:help sh.vim)
let g:is_bash=1

" plugin: ProtectFile.vim
" runtime file is untouchable
let g:autoprotectfile_readonly_paths = "$VIMRUNTIME/*"


" autocmd {{{1
" open QuickFix window automatically {{{2
augroup showQuickFixWindow
    autocmd! showQuickFixWindow

    " make
    autocmd QuickFixCmdPost make    cwindow
    " internal grep
    autocmd QuickFixCmdPost vimgrep cwindow
augroup END

" for [x]html {{{2
augroup xhtml
    autocmd! xhtml

    " reindent by <C-b>
    " kludge: setting 'indentkeys' at ftplugin don't work in gvim
    autocmd FileType html,xhtml     setlocal indentkeys& indentkeys+=!

    " key mappings
    " ftplugin: html.vim
    " complete closing tab
    autocmd FileType html,xhtml     inoremap <buffer><C-f> <Esc>:call InsertHTMLCloseTag()<CR>a<C-b>
    " modify by HTML Tidy
    autocmd FileType html,xhtml     nnoremap <buffer><silent><Leader>h :call ModifyByHTMLTidy()<CR>
augroup END

" tabs in help file {{{2
augroup tabinhelp
    autocmd! tabinhelp

    " don't highlight tab characters in help file
    " to use 'list' mode
    autocmd BufWinEnter *.txt           if &ft ==# "help" | setlocal list | endif
augroup END


" mappings {{{1
" clear mappings
mapclear
mapclear!

" general {{{2
" make
nnoremap <silent><Leader>m :update<CR>:make<CR>
" source
nnoremap <silent><Leader>r :source ~/.vimrc<CR>

" cursor {{{2
" move cursor as it looks
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" tabpage {{{2
" :tabnew is hard to complete
nnoremap t :tabnew<Space>
" switch tabpage
nnoremap <C-h> gT
nnoremap <C-l> gt
" move around tabpage
" plugin: TabShift.vim
nnoremap <silent><C-p> :TabShift -1<CR>
nnoremap <silent><C-n> :TabShift +1<CR>

" searches {{{2
" scroll matched word to middle of screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" editing {{{2
" line break
nnoremap <silent><S-k> i<CR><Esc>
" activate completion depending to the situation
" plugin: SmartComplete.vim
if has('insert_expand')
    if has('gui_running')
        inoremap <expr> <C-Space> SmartComplete()
        inoremap <C-S-Space> <C-p>
    else
        " <C-@> = <Nul> = <C-Space>
        inoremap <expr> <C-@> SmartComplete()
    endif
endif

" utils {{{2
" toggle spell check
nnoremap <silent><Leader>s :set spell!<CR>

" path operation {{{2
" change directory to one that has editing file
nnoremap <silent><Leader>c :cd %:p:h<CR>:pwd<CR>
" open explorer
" plugin: OpenWin32Explorer.vim
if has('win32')
    nnoremap <silent><Leader>e :OpenWin32Explorer<CR>
endif


" abbreviation {{{1
" fix typo
abbreviate retrun return
abbreviate cosnt  const
abbreviate scirpt script
abbreviate cludge kludge


" script {{{1


" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
