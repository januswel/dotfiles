" vim plugin file
" Filename:     qfagent.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.
" Version:      0.10
" License:      New BSD License
"   See LICENSE.  Note that redistribution is permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" Dependency:
"   This plugin requires following files
"
"   autoload/shell.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/shell.vim

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_qfagent')
    finish
endif
let loaded_qfagent = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" functions {{{2
" see :help QuickFixCmdPost-example
" in win32 with cmd.exe, remove ^M from each lines
function s:RemoveCRFromQFList()
    if shell#GetType() ==# 'cmd'
        let qflist = getqflist()
        for item in qflist
            let item.text = substitute(item.text, '$', '', '')
        endfor
        call setqflist(qflist)
    endif
endfunction

function s:ConvertEncodingQFList()
    let shellenc = shell#GetEncoding()
    if shellenc !=? &encoding
        let qflist = getqflist()
        for item in qflist
            let item.text = iconv(item.text, &encoding, shellenc)
        endfor
        call setqflist(qflist)
    endif
endfunction

" autocmds {{{2
" for make, internal grep, external grep
augroup qfagent
    autocmd QuickfixCmdPost make,vimgrep,grep   call s:RemoveCRFromQFList()
    autocmd QuickfixCmdPost make,vimgrep,grep   call s:ConvertEncodingQFList()
    " show quickfix window automatically
    autocmd QuickFixCmdPost make,vimgrep,grep   cwindow
augroup END

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
