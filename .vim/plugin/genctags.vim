" vim plugin file
" Filename:     genctags.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 06.
" Version:      0.22
" Dependency:
"   This plugin requires following file
"
"   autoload/jwlib/shell.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/shell.vim
"
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_genctags')
    finish
endif
let loaded_genctags = 1

" check the system has the required command
if !executable('ctags')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
            \ && !(exists('no_genctags_maps') && no_genctags_maps)

    if !hasmapto('<Plug>GenerateCtags', 'n')
        nmap <unique><Leader>gc
                    \ <Plug>GenerateCtags
    endif
endif
nnoremap <silent><Plug>GenerateCtags
            \ :call <SID>GenerateCtags('', expand('%:p:h'))<CR>

" commands {{{2
if exists(':GenerateCtags') != 2
    command -bang -nargs=+ -complete=file GenerateCtags
                \ call <SID>GenerateCtags('<bang>', <f-args>)
endif

" constants {{{2
" executable command name
let s:exe = 'ctags'
lockvar s:exe
" tags filename
let s:filename = 'tags'
lockvar s:filename
" options
let s:opt_recursive = '-R'
lockvar s:opt_recursive
let s:opt_exclude = '--exclude='
lockvar s:opt_exclude
let s:opt_outfile = '-f'
lockvar s:opt_outfile

" functions {{{2
function! s:GenerateCtags(bang, targetdir, ...)
    " assertion {{{3
    if empty(a:targetdir)
        echoerr 'The target directory is empty.'
        return
    endif

    if !isdirectory(a:targetdir)
        echoerr 'The target is not directory: ' . a:targetdir
        return
    endif
    " }}}3

    " get an absolute path
    let targetdir = fnamemodify(a:targetdir, ':p')
    " convert the bang to a number
    let recursive = (a:bang ==# '!') ? 1 : 0

    " options
    let options = []
    " options not to be passed arguments
    if recursive
        call add(options, s:opt_recursive)
    endif
    " excluded directories
    if !empty(a:000)
        let excludes = map(copy(a:000), 's:opt_exclude . v:val')
        call add(options, join(excludes))
    endif
    " a result file
    call add(options, s:opt_outfile)
    call add(options, shellescape(targetdir . s:filename))

    " target files or the top of target directory
    let target = shellescape(recursive ? targetdir : targetdir . '*')

    " build and execute the command
    let cmd = join(['!', s:exe, join(options), target])
    let shellenc = jwlib#shell#GetEncoding()
    if &encoding !=? shellenc
        let cmd = iconv(cmd, &encoding, shellenc)
    endif
    execute cmd
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=4
