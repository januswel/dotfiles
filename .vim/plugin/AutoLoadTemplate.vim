" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/01 20:15:41.
" Version:      0.12
" Remark:       load template along with ext automatically.
"               the position of template files can be seted
"               by g:templateautoloader_path. default is
"                   UNIX / Linux: ~/.vim/template
"                   Windows     : ~/vimfiles/template

if has('autocmd')
    " path to template files
    " default
    let s:templatepath = split(&runtimepath, ',')[0] . '/template/*'
    " load setting from global variable
    if exists('g:templateautoloader_path')
        let s:templatepath = g:templateautoloader_path . '/*'
    endif

    " get path separator
    let s:separator = '/'
    if has('win32') && !(exists('+shellslash') && &shellslash == 1)
        let s:separator = '\\'
    endif

    " along with ext
    function! AutoLoadTemplateExt()
        if !(line('$') == 1 && getline(1) == '')
            return 1
        endif

        " get extension name of buffer
        let s:ext = split(bufname(''), '\.')[-1]

        " get list of template files
        let s:templates = split(expand(s:templatepath), '\n')
        " load template if ext has matched
        for s:t in s:templates
            if s:ext == split(s:t, '\.')[-1]
                execute '0read ' . s:t
            endif
        endfor
    endfunction

    " along with filetype
    function! AutoLoadTemplateFileType()
        if !(line('$') == 1 && getline(1) == '')
            return 1
        endif

        " get filetype of buffer
        let s:ft = &l:filetype

        " get list of template files
        let s:templates = split(expand(s:templatepath), '\n')
        " load template if ext has matched
        for s:t in s:templates
            if s:ft == split(split(s:t, s:separator)[-1], '\.')[0]
                execute '0read ' . s:t
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
