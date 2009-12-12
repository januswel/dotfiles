" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/12 16:29:14.
" Version:      0.25
" Remark:       load template along with ext automatically.
"               the position of template files can be seted
"               by g:autoloadtemplate_path. default is
"                   UNIX / Linux: ~/.vim/template
"                   Windows     : %HOME%\vimfiles\template

" preparation {{{1
" check if this plugin is already loaded or not
if exists('loaded_autotmpl')
    finish
endif
let loaded_autotmpl = 1

" check vim has required features
if !(has('autocmd') && has('modify_fname'))
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" path to template files
" default
let s:templatepath = split(&runtimepath, ',')[0] . '/template/*'
" load setting from global variable
if exists('g:autoloadtemplate_path')
    let s:templatepath = g:templateautoloader_path . '/*'
endif

" return bool
" 0    : buffer has something
" not 0: buffer is empty
function! s:IsBufferEmpty()
    if !(line('$') == 1 && getline(1) == '')
        return 1
    endif
    return 0
endfunction

" return list
" get absolute path of template files
function! s:GetTemplateFiles()
    return split(expand(s:templatepath), '\n')
endfunction

" return none
" read specified file to buffer
function! s:ReadTemplateFile(file)
    execute 'read ' . a:file
    1delete _
endfunction

" along with ext
function! s:AutoLoadTemplateExt()
    if s:IsBufferEmpty()
        return 1
    endif

    " get extension name of buffer
    let l:ext = fnamemodify(bufname(''), ':e')

    " load template if ext has matched
    for l:t in s:GetTemplateFiles()
        if l:ext == fnamemodify(l:t, ':e')
            call s:ReadTemplateFile(l:t)
        endif
    endfor
endfunction

" along with filetype
function! s:AutoLoadTemplateFileType()
    if s:IsBufferEmpty()
        return 1
    endif

    " get filetype of buffer
    let l:ft = &l:filetype

    " load template if ext has matched
    for l:t in s:GetTemplateFiles()
        if l:ft == fnamemodify(l:t, ':t:r')
            call s:ReadTemplateFile(l:t)
        endif
    endfor

    " why 'modified' is set by calling this function only...?
    setlocal nomodified
endfunction

" autocmd
augroup AutoLoadTemplate
    autocmd! AutoLoadTemplate
    autocmd BufNewFile *    call s:AutoLoadTemplateExt()
    autocmd FileType *      call s:AutoLoadTemplateFileType()
augroup END

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
