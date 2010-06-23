" vim plugin file
" Filename:     autotmpl.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 10.
" Version:      0.43
" Dependency:
"   This plugin requires following file[s].
"
"   autoload/jwlib/buf.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/buf.vim
"
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

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
" constants {{{2
let s:tmpls_default = 'template/**'
lockvar s:tmpls_default

" functions {{{2
function s:LoadTemplateAlongWithExtension()
    " assertion
    if !s:IsTarget()
        return
    endif

    " get extension name of buffer
    let extension = expand('%:e')
    if empty(extension)
        return
    endif

    " load template if ext has matched
    for template in s:GetTemplateFiles()
        if extension ==? fnamemodify(template, ':e')
            call s:ReadTemplateFile(template)
            return
        endif
    endfor
endfunction

function s:LoadTemplateAlongWithFileType()
    " If the file associated with the current buffer does not exist, load a
    " template file along with an extension. Because a FileType event will
    " happen in advance of a BufNewFile event when a buffer is opened with
    " filename - the cause is autocmd defined by ftdetect plugins. In this
    " case, the event sequense is:
    "
    "   1. ftdetect's BufNewFile
    "       A value of 'filetype' is setted and trigger FileType.
    "   2. this plugin's FileType
    "       s:LoadTemplateAlongWithFileType() is called and load any template.
    "       In order to get the intended result (we need to load a template
    "       along with an extension), it is required to call
    "       s:LoadTemplateAlongWithExtension in this function.
    "   3. this plugin's BufNewFile
    "       s:LoadTemplateAlongWithExtension() is called and may load any
    "       template. But when any template is already loaded, this event is
    "       meaningless in effect.
    if !jwlib#fs#Exists(expand('%:p'))
        call s:LoadTemplateAlongWithExtension()
    endif

    " assertion
    if !s:IsTarget()
        return
    endif

    " get filetype of buffer
    let filetype = &filetype
    if empty(filetype)
        return
    endif

    " load template if ext has matched
    for template in s:GetTemplateFiles()
        if filetype ==? fnamemodify(template, ':t:r')
            call s:ReadTemplateFile(template)

            " why 'modified' is setted by calling this function only...?
            setlocal nomodified

            return
        endif
    endfor
endfunction

" stuff
" is target buffer ?
function s:IsTarget()
    if               jwlib#buf#IsEmpty()
                \ && jwlib#buf#IsModifiable()
                \ && jwlib#buf#IsNormalType()
        return 1
    endif
endfunction

" return List
function s:GetTemplateFiles()
    let files = []
    if exists('g:autotmpl_tmpls') && !empty(g:autotmpl_tmpls)
        let typeofpaths = type(g:autotmpl_tmpls)
        if     typeofpaths == 1 " String
            let paths = split(g:autotmpl_tmpls, '\s*,\s*')
        elseif typeofpaths == 3 " List
            let paths = g:autotmpl_tmpls
        elseif typeofpaths == 4 " Dictionary
            let paths = values(g:autotmpl_tmpls)
        endif

        for path in paths
            let line = glob(path)
            let files += split(line, '\n')
        endfor
    else
        " default
        let files = split(globpath(&runtimepath, s:tmpls_default), '\n')
    endif

    return files
endfunction

" read the specified file to the buffer
function s:ReadTemplateFile(file)
    execute 'read' a:file
    1delete _
endfunction

" autocmds {{{2
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
