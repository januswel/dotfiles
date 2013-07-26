" vim autoload file
" Filename:     profile.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.10
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
" check vim has required features
if !has('reltime')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions {{{2
function! jwlib#profile#Expression(expression, trials)
    let i = 0

    " measure
    let start = reltime()
    while i < a:trials
        call eval(a:expression)
        let i += 1
    endwhile

    let elapsed = reltime(start)
    return str2float(reltimestr(elapsed))
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
