" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/22 21:19:15.
" Version:      0.33
" Dependency:
"   This plugin needs following files
"
"   * autoload/buf.vim
"       http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/buf.vim
"
" Remark:       This plugin provides the feature to load a template file along
"               with the extension or the filetype of the buffer automatically.
"               The path of template files can be setted with
"               "g:autotmpl_tmpls" like following codes. Take care that the
"               path includes wildcard like '*' or '**'.
"
"                   let g:autotmpl_tmpls = '~/templates/*'
"                   let g:autotmpl_tmpls = '/home/mymaster/template/**'
"                   let g:autotmpl_tmpls = '%HOMEDRIVE%%HOMEPATH%\template\*'
"
"               With the default settings, this plugin will search
"               "template/**" in 'runtimepath'. This represents template files
"               are all files that exists in each values of 'runtimepath' below
"               "template" directory.
"
"               The name of the template file matter in order to be loaded as
"               intended. You must name your template file like "filetype.ext".
"               e.g. the typical template file for scripting language perl
"               should be named "perl.pl".

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
function! s:LoadTemplateAlongWithExtension()
    " assertion
    if !s:IsTarget()
        return
    endif

    " get extension name of buffer
    let extension = fnamemodify(bufname(''), ':e')

    " load template if ext has matched
    for template in s:GetTemplateFiles()
        if extension ==? fnamemodify(template, ':e')
            call s:ReadTemplateFile(template)
            return
        endif
    endfor
endfunction

function! s:LoadTemplateAlongWithFileType()
    " assertion
    if !s:IsTarget()
        return
    endif

    " get filetype of buffer
    let filetype = &filetype

    " load template if ext has matched
    for template in s:GetTemplateFiles()
        if filetype ==? fnamemodify(template, ':t:r')
            call s:ReadTemplateFile(template)

            " why 'modified' is set by calling this function only...?
            setlocal nomodified

            return
        endif
    endfor
endfunction

" stuff
" is target buffer ?
function! s:IsTarget()
    if buf#IsEmpty() && buf#IsModifiable() && buf#IsNormalType()
        return 1
    endif
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
