" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/06 20:22:04.
" Version:      0.20
" Remark:       load template along with ext automatically.
"               the position of template files can be seted
"               by g:autoloadtemplate_path. default is
"                   UNIX / Linux: ~/.vim/template
"                   Windows     : %HOME%\vimfiles\template

if has('autocmd')
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
    function! IsBufferEmpty()
        if !(line('$') == 1 && getline(1) == '')
            return 1
        endif
        return 0
    endfunction

    " return list
    " get absolute path of template files
    function! GetTemplateFiles()
        return split(expand(s:templatepath), '\n')
    endfunction

    " return none
    " read specified file to buffer
    function! ReadTemplateFile(file)
        execute '0read ' . a:file
    endfunction

    " along with ext
    function! AutoLoadTemplateExt()
        if IsBufferEmpty()
            return 1
        endif

        " get extension name of buffer
        let l:ext = fnamemodify(bufname(''), ':e')

        " load template if ext has matched
        for l:t in GetTemplateFiles()
            if l:ext == fnamemodify(l:t, ':e')
                call ReadTemplateFile(l:t)
            endif
        endfor
    endfunction

    " along with filetype
    function! AutoLoadTemplateFileType()
        if IsBufferEmpty()
            return 1
        endif

        " get filetype of buffer
        let l:ft = &l:filetype

        " load template if ext has matched
        for l:t in GetTemplateFiles()
            if l:ft == fnamemodify(l:t, ':t:r')
                call ReadTemplateFile(l:t)
            endif
        endfor
    endfunction

    " autocmd
    augroup AutoLoadTemplate
        autocmd! AutoLoadTemplate
        autocmd BufNewFile *    call AutoLoadTemplateExt()
        autocmd FileType *      call AutoLoadTemplateFileType()
    augroup END
endif

" vim: ts=4 sw=4 sts=0 et
