" vim plugin file
" Filename:     genctags.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/23 00:07:56.
" Version:      0.11
" Remark: {{{1
"   This plugin provides the command ":GenerateCtags" and mappings "<Leader>gc"
"   and "<Plug>GenerateCtags" to generate the file "tags" that includes tag
"   information, by "ctags" program.
"
"   The command ":GenerateCtags" can be specified the bang '!'. With the bang,
"   this command search directories recursively. This command must be specified
"   one or more arguments. Without the bang, the first argument is the target
"   directory. With the bang, the first one is the top of the target directory.
"   Ones from the second to the end are excluded directories.
"
"   To generate the "tags" file of the current directory, execute following
"   command:
"
"       :GenerateCtags .
"
"   To generate the file of your vim runtime but exclude GetLatest and spell
"   files:
"
"       :GenerateCtags! ~/.vim/ GetLatest spell
"
"   The internal mapping "<Plug>GenerateCtags" is mapped like following
"   command:
"
"       :GenerateCtags expand('%:p:h')

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_genctags')
    finish
endif
let loaded_genctags = 1

" check the system has the required command
let s:version = system('ctags --version')
if v:shell_error != 0
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" mappings {{{2
if !(exists('no_plugin_maps') && no_plugin_maps)
            \ && !(exists('no_genctags_maps') && no_genctags_maps)
    if !hasmapto('<Plug>GenerateCtags')
        nmap <unique><Leader>gc
                    \ <Plug>GenerateCtags
    endif
endif
nnoremap <silent><Plug>GenerateCtags
            \ :call <SID>GenerateCtags('', expand('%:p:h'))<CR>

" commands {{{2
if exists(':GenerateCtags') != 2
    command -bang -nargs=+ -complete=dir GenerateCtags
                \ call <SID>GenerateCtags('<bang>', <f-args>)
endif

" functions {{{2
function! s:GenerateCtags(bang, targetdir, ...)
    " assertion
    if a:targetdir ==# ''
        echoerr 'The target directory is empty!!'
        return
    endif

    " convert the bang to a number
    let recursive = (a:bang ==# '!') ? 1 : 0

    " executable command name
    let exe = 'ctags'

    " options
    let options = []
    " options not to be passed arguments
    if recursive
        call add(options, '-R')
    endif
    " excluded directories
    if !empty(a:000)
        call add(options, '--exclude=' . join(a:000, ','))
    endif

    " the result file
    let outfile = '-f ' . shellescape(fnamemodify(a:targetdir . '/tags', ':p'))
    " target files or the top of target directory
    let target = fnamemodify(a:targetdir, ':p')
    if !recursive
        let target .= '*'
    endif
    let target = shellescape(target)

    " build and execute the command
    let cmd = join(['!', exe, join(options), outfile, target])
    execute cmd
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
