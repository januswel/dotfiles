" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/12 18:23:47.
" Version:      0.30
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
" functions {{{2
" return bool
" 0    : the buffer has something
" not 0: the buffer is empty
function! s:IsBufferEmpty()
    if line('$') ==# 1 && getline(1) ==# ''
        return 1
    endif
    return 0
endfunction

" return bool
" 0    : the buffer is not modifiable
" not 0: the buffer is modifiable
function! s:IsBufferModifiable()
    if &modifiable && !&readonly
        return 1
    endif
    return 0
endfunction

" return bool
" 0    : the buffer has special attributes
" not 0: the buffer is normal
function! s:IsBufferNormal()
    if &buftype ==# ''
        return 1
    endif
    return 0
endfunction

" return List
function! s:GetTemplateFiles()
    let files = ''

    if exists('g:autotmpl_tmpls') && g:autotmpl_tmpls !=# ''
        let files = glob(g:autotmpl_tmpls)
    else
        " default
        let files = globpath(&runtimepath, 'template/**')
    endif

    return split(files, '\n')
endfunction

" read the specified file to the buffer
function! s:ReadTemplateFile(file)
    execute 'read ' . a:file
    1delete _
endfunction

function! s:LoadTemplateAlongWithExtension()
    " assertion
    if !(s:IsBufferEmpty() && s:IsBufferModifiable() && s:IsBufferNormal())
        return 1
    endif

    " get extension name of buffer
    let extension = fnamemodify(bufname(''), ':e')

    " load template if ext has matched
    for template in s:GetTemplateFiles()
        if extension ==? fnamemodify(template, ':e')
            call s:ReadTemplateFile(template)
        endif
    endfor
endfunction

function! s:LoadTemplateAlongWithFileType()
    " assertion
    if !(s:IsBufferEmpty() && s:IsBufferModifiable() && s:IsBufferNormal())
        return 1
    endif

    " get filetype of buffer
    let filetype = &filetype

    " load template if ext has matched
    for template in s:GetTemplateFiles()
        if filetype ==? fnamemodify(template, ':t:r')
            call s:ReadTemplateFile(template)
        endif
    endfor

    " why 'modified' is set by calling this function only...?
    setlocal nomodified
endfunction

" autocmd {{{2
augroup autotmpl
    autocmd! autotmpl

    autocmd BufNewFile *    call s:LoadTemplateAlongWithExtension()
    autocmd FileType *      call s:LoadTemplateAlongWithFileType()
augroup END

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
