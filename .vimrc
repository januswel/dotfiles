" .vimrc
" janus_wel <janus.wel.3@gmail.com>

" basic options {{{1
set nocompatible    " compatible mode off

" NeoBundle {{{1
filetype off
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle/'))
endif

NeoBundle 'mattn/emmet-vim'

" plugins
NeoBundle 'januswel/jwlib.vim'

NeoBundle 'januswel/binedit.vim'
NeoBundle 'januswel/fencdefault.vim'
NeoBundle 'januswel/fencja.vim'
NeoBundle 'januswel/protect.vim'
NeoBundle 'januswel/setscroll.vim'
NeoBundle 'januswel/smrtcmpl.vim'
NeoBundle 'januswel/sweepbuf.vim'
NeoBundle 'januswel/tabshift.vim'
NeoBundle 'januswel/visualiz.vim'
NeoBundle 'januswel/zoomfont.vim'

NeoBundle 'januswel/autotmpl.vim'
NeoBundle 'januswel/count.vim'
NeoBundle 'januswel/expand.vim'
NeoBundle 'januswel/filer.vim'
NeoBundle 'januswel/profile.vim'
NeoBundle 'januswel/sendbrowser.vim'
NeoBundle 'januswel/uniconv.vim'

NeoBundle 'januswel/rlhelp.vim'

" filetype settings
NeoBundle 'januswel/html5.vim'
NeoBundle 'januswel/powershell.vim'

call neobundle#end()

" options {{{1
" general {{{2
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
" The directories that are named as "backup" and found in runtime-paths are
" setted in 'backupdir'.
let s:candidates = split(globpath(&runtimepath, 'backup'), '\n')
let s:backupdirs = []
let s:candidate = ''
for s:candidate in s:candidates
    if isdirectory(s:candidate)
        call add(s:backupdirs, s:candidate)
    endif
endfor
" Backup feature is enabled when there are one or more directories that suit
" above conditions exist.
let s:backupdir = join(s:backupdirs, ',')
if s:backupdir != ''
    set backup          " backup feature on
    set writebackup     " make a backup file before overwriting a file
    set backupcopy=auto " how backup files are created, best one
    set backupext=~     " trailing character of backup file
    let &backupdir = s:backupdir . ',' . &backupdir
endif
unlet s:candidates s:backupdirs s:candidate s:backupdir

" undo {{{2
if has('persistent_undo')
    " The directories that are named as "undo" and found in runtime-paths are
    " set in 'undodir'.
    let s:candidates = split(globpath(&runtimepath, 'undo'), '\n')
    let s:undodirs = []
    let s:candidate = ''
    for s:candidate in s:candidates
        if isdirectory(s:candidate)
            call add(s:undodirs, s:candidate)
        endif
    endfor

    let s:undodir = join(s:undodirs, ',')
    if s:undodir != ''
        let &undodir = s:undodir . ',' . &undodir
    endif
    unlet s:candidates s:undodirs s:candidate s:undodir
endif

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
set confirm         " confirm me before quitting modified buffers

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
" %3P                       : percentage through file of displayed window
let s:statusline = [
            \ '%3(%m%) %<%3n %t %y',
            \ '[%{&fenc!=#""?&fenc:&enc}:%{&ff}]',
            \ '%r',
            \ '%=',
            \ '[%{tabpagenr()}/%{tabpagenr("$")}]',
            \ '[%v:%l/%L]',
            \ '[%2(%{strtrans(matchstr(getline("."),".",col(".")-1))}%)',
            \ ' 0x%04B]',
            \ '[%3P]',
            \ ]
let &statusline = join(s:statusline, '')
unlet s:statusline

" show status line always
set laststatus=2

" tabline {{{2
let &tabline =  '%!jwlib#tabline#NoMouseTabLine('
            \ .     '"jwlib#tabline#ExtAndFileTypeTabLabel"'
            \ . ')'

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

" diff {{{2
set diffopt=filler,context:5    " show filler lines
                                " and use a context of 5 lines

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
set wildmenu                " command-line completion on
set wildmode=list:longest   " list all candidates and complete longest matched

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
        let &termencoding = &encoding
        set encoding=utf-8
    else
        set encoding=cp932
    endif
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

" C/Migemo
" this settings influence only Kaoriya version
if has('migemo')
    set migemo
    set migemodict=$VIM/dict/utf-8.d/migemo-dict
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
let autodate_format = '%Y %3m %d'

" for :TOhtml
let g:html_font = 'VL Gothic'
"let g:html_ignore_folding = 1
let g:html_no_pre = 1
let g:html_number_lines = 1
let g:html_use_css = 1
let g:html_use_encoding = &encoding
let g:use_xhtml = 1

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
nnoremap <silent><Leader>m :update<CR>:make! "%"<CR>
" source
nnoremap <silent><Leader><S-s> :source ~/.vimrc<CR>:source ~/.gvimrc<CR>
" jump to the tag under the cursor
nnoremap <silent><Leader>p :execute ':ptag ' . expand('<cword>')<CR>
" toggle 'paste'
nnoremap <silent><Leader><S-p> :setlocal paste!<CR>:setlocal paste?<CR>
" show buffer list
nnoremap <silent><Leader>b :buffers<CR>
" yank all lines of the buffer
nnoremap <silent><Leader>y :%yank<CR>
" to write commit messages of tortoisegit
nnoremap <silent><Leader>gc :setlocal bt=nofile ft=gitcommit spell<CR>
" generate tags for help
if has('win32')
    nnoremap <silent><Leader>gh :helptags ~/vimfiles/doc<CR>
else
    nnoremap <silent><Leader>gh :helptags ~/.vim/doc<CR>
endif
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

" disable "," and ";" to use as mapleader and maplocalleader
nnoremap , <Nop>
nnoremap ; <Nop>
vnoremap , <Nop>
vnoremap ; <Nop>

" window & tabpage {{{2
" move cursor among windows, to next one and to previous one
nnoremap <silent><C-j> :wincmd w<CR>
nnoremap <silent><C-k> :wincmd W<CR>

" move the window to a new tab page
nnoremap <silent><Leader>w :wincmd T<CR>

" adjust heights and widths of all visible windows equally
nnoremap <silent><Leader>= :wincmd =<CR>

" open the result of looking up a keyword under the cursor in new tabpage
nnoremap <silent><S-k> K:wincmd T<CR>

" :tabnew is hard to complete
nnoremap t :tabnew<Space>
" open the buffer in a new tab page from the buffer list
nnoremap <S-t> :tab sbuffer<Space>

" shows list if there are more than one candidates, when jump over tags
nnoremap <silent><C-]> g]

" switch between tabpages
nnoremap <C-h> gT
nnoremap <C-l> gt

" move a tabpage around
" plugin: TabShift.vim
nnoremap <silent><C-p> :TabShift! -1<CR>
nnoremap <silent><C-n> :TabShift! +1<CR>

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
" line break, mnemonic: "S"plit
nnoremap <S-s> i<CR><Esc>

" to upper case
nnoremap g<S-l> gU
inoremap <C-u> <Esc>gUiw`]a
" to lower case
nnoremap gl gu
" to camel case
inoremap <C-c> <Esc>bgUllgue`]a

" tuck it
" U+0020 SPACE
vnoremap <Leader><Space> <Esc>`>a <Esc>`<i <Esc>
" U+0027 APOSTROPHE and U+0022 QUOTATION MARK
vnoremap <Leader>' <Esc>`>a'<Esc>`<i'<Esc>
vnoremap <Leader>" <Esc>`>a"<Esc>`<i"<Esc>
" U+0060 GRAVE ACCENT
vnoremap <Leader>` <Esc>`>a`<Esc>`<i`<Esc>
" U+002A ASTERISK
vnoremap <Leader>* <Esc>`>a*<Esc>`<i*<Esc>
" parentheses, curly, square and angle brackets
vnoremap <Leader>( <Esc>`>a)<Esc>`<i(<Esc>
vnoremap <Leader>{ <Esc>`>a}<Esc>`<i{<Esc>
vnoremap <Leader>[ <Esc>`>a]<Esc>`<i[<Esc>
vnoremap <Leader>< <Esc>`>a><Esc>`<i<<Esc>
" U+0025 PERCENT SIGN
vnoremap <Leader>% <Esc>`>a%<Esc>`<i%<Esc>
" U+005F LOW LINE
vnoremap <Leader>_ <Esc>`>a_<Esc>`<i_<Esc>
" U+007C VERTICAL LINE
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
" U+FF5E FULLWIDTH TILDE
vnoremap <Leader>w <Esc>`>a <C-q>uff5e<Esc>`<i<C-q>uff5e <Esc>`[
" U+300C LEFT CORNER BRACKET and U+300D RIGHT CORNER BRACKET
vnoremap <Leader>b <Esc>`>a<C-q>u300d<Esc>`<i<C-q>u300c<Esc>`[
" C style comment
vnoremap <Leader><S-c> <Esc>`>a*/<Esc>`<i/*<Esc>

" completion {{{2
inoremap <expr><Tab>    pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<Tab>"

" path operation {{{2
" show current directory
nnoremap <silent><Leader>d :pwd<CR>
" change directory to one that has the editing file
nnoremap <silent><Leader><S-d> :lcd %:p:h<CR>:pwd<CR>
" change directory to the upper one
nnoremap <silent><Leader>u :lcd ../<CR>:pwd<CR>

" plugin {{{2
" sweepbuflist.vim
nmap <silent><Leader><S-b> :SweepBuffers<CR>:buffers<CR>
" expandvar.vim
nmap <silent><Leader>e <Plug>ExpandExpression
nmap <silent><Leader><S-e> <Plug>EvalExpression
nmap <silent><Leader>c  <Plug>GenerateCtags
" zoomfont.vim
nmap <silent>+ <Plug>ZoomIn
nmap <silent>- <Plug>ZoomOut
nmap <silent>& <Plug>ZoomReset


" abbreviation {{{1
" fix typo
abbreviate retrun          return
abbreviate cosnt           const
abbreviate scirpt          script
abbreviate cludge          kludge
abbreviate hlep            help
abbreviate parcent         percent
abbreviate persent         percent
abbreviate parsent         percent
abbreviate tilda           tilde
abbreviate appropreate     appropriate
abbreviate acknowledgement acknowledgment


" script {{{1

augroup tags
    autocmd!
    autocmd BufNewFile,BufRead *.h,*.hpp,*.c,*.cpp set tags+=~/tags
augroup END

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
