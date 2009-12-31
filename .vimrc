" .vimrc
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.

" options {{{1
" general {{{2
set nocompatible    " compatible mode off

" viminfo
set viminfo+=%      " save and restore the buffer list

" path setting
set path^=~/bin/    " prepend my bin to 'path'

" timing to write
set noautowrite     " disable writing files automatically
set noautowriteall  " make my wish to vim thoroughly

" wait till input is determined
set notimeout       " don't make me hurry
set nottimeout      " once agein, don't

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
set showcmd         " show entered and partial command
set nolist          " don't show space characters (tab, line break)

" statusline {{{2
" %3(%m%)                   : modified flag (bracketed, fixed)
" %<                        : where to truncate line
" %3n                       : buffer number (3 digit)
" %t                        : filename (only leaf)
" %y                        : filetype (bracketed)
" %{&fenc!=#""?&fenc:&enc}  : fileencoding
" %{&ff}                    : fileformat
" %r                        : read only flag (bracketed)
" %=                        : spliter left between right
" %{tabpagenr()}            : current tabnumber
" %{tabpagenr("$")}         : tabpage count
" %v                        : virtual column
" %l                        : line number
" %L                        : lines count
" %{strtrans(matchstr(getline("."),".",col(".")-1))} : chars under the cursor
" 0x%04B                    : hexadecimal octets
" %4P                       : percentage through file of displayed window
let s:statusline = [
            \ '%3(%m%) %<%3n %t %y',
            \ '[%{&fenc!=#""?&fenc:&enc}:%{&ff}]',
            \ '%r',
            \ '%=',
            \ '[%{tabpagenr()}/%{tabpagenr("$")}]',
            \ '[%v:%l/%L]',
            \ '[%2(%{strtrans(matchstr(getline("."),".",col(".")-1))}%)',
            \ ' 0x%04B]',
            \ '[%4P]',
            \ ]
let &statusline = join(s:statusline, '')
unlet s:statusline

" tabline {{{2
set tabline=%!tabline#NoMouseTabLine('tabline#ExtAndFileTypeTabLabel')

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

" window {{{2
set splitbelow      " make a new window at the below of the current window
set splitright      " make a new window at the right of the current window
set helpheight=0    " a height of help window is half of the current window

" editing {{{2
" allow backspacing over autoindent, line breakes, start of insert
set backspace=indent,eol,start
" <C-A> and <C-X> affect also hexadecimal number and single alphabet
set nrformats=hex,alpha

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
" 'fileencodings' is setted by plugin "jaencs.vim"
if has('win32')
    if has('gui')
        set encoding=utf-8
    else
        set encoding=cp932
    endif
else
    set encoding=utf-8
endif

" end-of-line format
" candidates of EOL format for exist files
" first one is used as new file's EOL format
set fileformats=unix,dos

" platform specific {{{2
" clipboard is used as unnamed register
if has('gui') || has('xterm_clipboard')
    set clipboard=unnamed
endif

" :hardcopy
if has('printer')
    set printoptions=number:y
    set printheader=%<%t%=page\ %N

    if has('win32')
        set printfont=VL_Gothic:h12:cSHIFTJIS
    endif
endif


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
" <Leader>, <LocalLeader>
let mapleader = ','
let maplocalleader = ';'

" plugin: autodate.vim
" date format to insert automatically
let autodate_format = '%Y/%m/%d %H:%M:%S'

" plugin: ProtectFile.vim
" runtime file is untouchable
let autoprotectfile_readonly_paths = "$VIMRUNTIME/*"

" disable plugin {{{2
" settings for Kaoriya version
if has('kaoriya')
    let plugin_cmdex_disable = 1
    let plugin_dicwin_disable = 1
    let plugin_format_disable = 1
    let plugin_hz_ja_disable = 1
    let plugin_scrnmode_disable = 1
    let plugin_verifyenc_disable = 1

    " don't source gvimrc_example.vim in $VIM
    " see $VIM/gvimrc
    let no_gvimrc_example = 1
endif

" platform specific {{{2
if has('win32')
    " in Windows, processing tar, gzip and zip with vim is non-sense...
    let loaded_gzip = 1
    let loaded_tarPlugin = 1
    let loaded_zipPlugin = 1
else
    " setting for bash (:help sh.vim)
    let is_bash = 1
endif


" mappings {{{1
" general {{{2
" make
nnoremap <silent><Leader>m :update<CR>:make "%"<CR>
" source
nnoremap <silent><Leader>r :source ~/.vimrc<CR>
" jump to the tag under the cursor
nnoremap <silent><Leader>p :execute ':ptag ' . expand('<cword>')<CR>
" toggle 'paste'
nnoremap <silent><Leader><S-p> :setlocal paste!<CR>:setlocal paste?<CR>
" show buffer list
nnoremap <silent><Leader>b :buffers<CR>
" yank all lines of the buffer
nnoremap <silent><Leader>y :1,$:yank<CR>
" toggle spell check
if has('spell') && has('syntax')
    nnoremap <silent><Leader>s :setlocal spell!<CR>:setlocal spell?<CR>
endif

" cursor {{{2
" move cursor as it looks
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$
vnoremap j gj
vnoremap k gk
vnoremap 0 g0
vnoremap ^ g^
vnoremap $ g$

" window & tabpage {{{2
" move cursor among windows, to next one and to previous one
nnoremap <silent><C-j> :wincmd w<CR>
nnoremap <silent><C-k> :wincmd W<CR>

" move the window to a new tab page
nnoremap <silent><Leader>w :wincmd T<CR>

" :tabnew is hard to complete
nnoremap t :tabnew<Space>
" open the buffer in a new tab page from the buffer list
nnoremap <S-t> :tab sbuffer<Space>

" open the tag under the cursor in a new tabpage
nnoremap <silent><C-]> :tab wincmd ]<CR>

" switch between tabpages
nnoremap <C-h> gT
nnoremap <C-l> gt

" move a tabpage around
" plugin: TabShift.vim
nnoremap <silent><C-p> :TabShift -1<CR>
nnoremap <silent><C-n> :TabShift +1<CR>

" searches {{{2
" put matched word in the top of the screen
" "zv" indicates to open fold
" "zt" indicates to redraw screen with the cursor line as the top of the screen
nnoremap n  nzvzt
nnoremap N  Nzvzt
nnoremap *  *zvzt
nnoremap #  #zvzt
nnoremap g* g*zvzt
nnoremap g# g#zvzt

" stop the highlighting matched texts
nnoremap <silent><Leader>h :nohlsearch<CR>
" clear search pattern
nnoremap <silent><Leader><S-h> :let @/=''<CR>

" matches {{{2
" clear match pattern
nnoremap <silent><Leader><S-t> :match<CR>
" show CHARACTER TABULATION
nnoremap <silent><Leader>t :match Error /\t/<CR>

" editing {{{2
" line break
nnoremap <S-k> i<CR><Esc>

" to upper case
nnoremap g<S-l> gU
inoremap <C-u> <Esc>gUiw`]a
" to lower case
nnoremap gl gu
" to camel case
inoremap <C-c> <Esc>bgUllgue`]a

" tuck it
" single and double quote
vnoremap <Leader>' <Esc>`>a'<Esc>`<i'<Esc>
vnoremap <Leader>" <Esc>`>a"<Esc>`<i"<Esc>
" parentheses, curly, square and angle brackets
vnoremap <Leader>( <Esc>`>a)<Esc>`<i(<Esc>
vnoremap <Leader>{ <Esc>`>a}<Esc>`<i{<Esc>
vnoremap <Leader>[ <Esc>`>a]<Esc>`<i[<Esc>
vnoremap <Leader>< <Esc>`>a><Esc>`<i<<Esc>
" percent
vnoremap <Leader>% <Esc>`>a%<Esc>`<i%<Esc>
" bar
" see :help map_bar
vnoremap <Leader>| <Esc>`>a|<Esc>`<i|<Esc>
" entity references, less and greater than sign
vnoremap <Leader>a <Esc>`>a&gt;<Esc>`<i&lt;<Esc>`[
" xhtml inline tags
vnoremap <Leader>k <Esc>`>a<lt>/kbd><Esc>`<i<lt>kbd><Esc>`[
vnoremap <Leader>c <Esc>`>a<lt>/code><Esc>`<i<lt>code><Esc>`[
vnoremap <Leader>d <Esc>`>a<lt>/del><Esc>`<i<lt>del><Esc>`[
vnoremap <Leader>i <Esc>`>a<lt>/ins><Esc>`<i<lt>ins><Esc>`[
vnoremap <Leader>q <Esc>`>a<lt>/q><Esc>`<i<lt>q><Esc>`[
" FULLWIDTH TILDE
vnoremap <Leader>w <Esc>`>a <C-q>uff5e<Esc>`<i<C-q>uff5e <Esc>`[
" LEFT CORNER BRACKET and RIGHT CORNER BRACKET
vnoremap <Leader>b <Esc>`>a<C-q>u300d<Esc>`<i<C-q>u300c<Esc>`[

" path operation {{{2
" show current directory
nnoremap <silent><Leader>d :pwd<CR>
" change directory to one that has the editing file
nnoremap <silent><Leader><S-d> :lcd %:p:h<CR>:pwd<CR>
" change directory to the upper one
nnoremap <silent><Leader>u :lcd ../<CR>:pwd<CR>

" open explorer
" plugin: OpenWin32Explorer.vim
if has('win32')
    nnoremap <silent><Leader>e :OpenWin32Explorer<CR>
endif


" abbreviation {{{1
" fix typo
abbreviate retrun   return
abbreviate cosnt    const
abbreviate scirpt   script
abbreviate cludge   kludge
abbreviate hlep     help
abbreviate parcent  percent
abbreviate persent  percent
abbreviate parsent  percent
abbreviate tilda    tilde


" script {{{1


" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
