" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/13 12:17:46.
" Version:      0.13
" Remark:       :set readonly, at opening specified path automatically.
"               the setting is possible with global variables,
"               e.g.:
"
"      g:protec_readonly_paths = "$VIMTUNTIME/*,~/importants/*"
"      g:protec_nomodifiable_paths = "~/veryimportants/*"

" preparation {{{1
" check if this plugin is already loaded or not
if exists('loaded_protec')
    finish
endif
let loaded_protec = 1

" check vim has required features
if !has('autocmd')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" function {{{2
" stuff
function! s:Convert2String(srcname)
    " check the existence
    if !exists(a:srcname)
        return ''
    endif

    " expand the value
    execute 'let src = ' . a:srcname
    " check the type
    let t = type(src)
    if t ==# 1
        " string
        return src
    elseif t ==# 3
        " List
        return join(src, ',')
    endif

    return ''
endfunction

function! s:SetProtectorates()
    " readonly
    let paths = s:Convert2String('g:protec_readonly_paths')
    if paths !=# ''
        augroup ProtecReadOnly
            autocmd! ProtecReadOnly
            execute 'autocmd BufReadPost '
                        \ . paths
                        \ . ' setlocal readonly'
        augroup END
    endif

    " nomodifiable
    let paths = s:Convert2String('g:protec_nomodifiable_paths')
    if paths !=# ''
        augroup ProtecNoModifiable
            autocmd! ProtecNoModifiable
            execute 'autocmd BufReadPost '
                        \ . paths
                        \ . ' setlocal nomodifiable'
        augroup END
    endif
endfunction

" execute codes {{{2
call s:SetProtectorates()

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
