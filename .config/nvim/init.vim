" leader
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
source ~/.config/nvim/lua/init.lua
let mapleader = ','
let maplocalleader = ';'

nmap , <Nop>
nmap ; <Nop>
vmap , <Nop>
vmap ; <Nop>

" status line
let &statusline = join([
            \ '%3(%m%) %<%3n %t %y',
            \ '[%{&fenc!=#""?&fenc:&enc}:%{&ff}]',
            \ '%r',
            \ '%=',
            \ '[%{tabpagenr()}/%{tabpagenr("$")}]',
            \ '[%v:%l/%L]',
            \ '[%2(%{strtrans(matchstr(getline("."),".",col(".")-1))}%)',
            \ ' 0x%04B]',
            \ '[%3P]',
            \ ], '')

" clipboard
if has('clipboard')
    set clipboard=unnamed
endif

" search
nnoremap n  nzvzt
nnoremap N  Nzvzt
nnoremap *  *zvzt
nnoremap #  #zvzt
nnoremap g* g*zvzt
nnoremap g# g#zvzt

nnoremap <silent><Leader>h :nohlsearch<CR>

nnoremap <silent><Leader><S-h> :let @/=''<CR>

" editing
" line break, mnemonic: "S"plit
nnoremap <S-s> i<CR><Esc>

" to upper case
inoremap <C-u> <Esc>gUiw`]a
" to camel case
inoremap <C-c> <Esc>bgUllgue`]a

" camelCase to kebabu-case
vnoremap <Leader>cck :s/\<\@!\([A-Z]\)/-\l\1/g<CR>:nohlsearch<CR>
" kebabu-case to camelCase
vnoremap <Leader>ckc :s/-\([a-z]\)/\u\1/g<CR>:nohlsearch<CR>
" camelCase to SNAKE_CASE
vnoremap <Leader>ccs :s/\<\@!\([A-Z]\)/_\1/g<CR>:nohlsearch<CR>gUiw
" SNAKE_CASE to camelCase
vnoremap <Leader>csc gugv:s/_\([a-z]\)/\U\1/g<CR>:nohlsearch<CR>

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
" U+003A COLON
vnoremap <Leader>: <Esc>`>a:<Esc>`<i:<Esc>
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

vnoremap <Leader>r <Esc>`>a<lt>rt><lt>/rt><lt>/ruby><Esc>`<i<lt>ruby><Esc>f>a

source ~/.config/nvim/lua/init.lua
