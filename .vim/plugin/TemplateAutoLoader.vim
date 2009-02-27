" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/28 00:36:50.
" Version:      0.10
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

    " define functions
    function! TemplateAutoLoader()
        " get buffer extension name
        " :help filename-modifiers
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

    " autocmd
    augroup TemplateAutoLoader
        autocmd! TemplateAutoLoader
        autocmd BufNewFile *    call TemplateAutoLoader()
    augroup TemplateAutoLoader
endif

" vim: ts=4 sw=4 sts=0 et
