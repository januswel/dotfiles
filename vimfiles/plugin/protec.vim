" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/13 12:08:34.
" Version:      0.11
" Remark:       :set readonly, at opening specified path automatically.
"               the setting is possible with global variables,
"               e.g.:
"
"      g:protec_readonly_paths = "$VIMTUNTIME/*,~/importants/*"
"      g:protec_nomodifiable_paths = "~/veryimportants/*"

if has('autocmd')
    " readonly
    if exists('g:protec_readonly_paths')
                \ && len(g:protec_readonly_paths)
        augroup ProtecReadOnly
            autocmd! ProtecReadOnly
            execute 'autocmd BufReadPost '
                        \ . g:protec_readonly_paths
                        \ . ' setlocal readonly'
        augroup END
    endif

    " nomodifiable
    if exists('g:protec_nomodifiable_paths')
                \ && len(g:protec_nomodifiable_paths)
        augroup ProtecNoModifiable
            autocmd! ProtecNoModifiable
            execute 'autocmd BufReadPost '
                        \ . g:protec_nomodifiable_paths
                        \ . ' setlocal nomodifiable'
        augroup END
    endif
endif

" vim: ts=4 sw=4 sts=0 et
