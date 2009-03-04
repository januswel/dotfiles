" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/04 21:14:40.
" Version:      0.10
" Remark:       :set readonly, at opening specified path automatically.
"               the setting is possible with global variables
"               e.g.:
"
"           g:autoprotectfile_readonly_paths = "$VIMTUNTIME/*,~/importants/*"
"           g:autoprotectfile_nomodifiable_paths = "~/veryimportants/*"

if has('autocmd')
    " readonly
    if exists('g:autoprotectfile_readonly_paths') && g:autoprotectfile_readonly_paths
        augroup AutoProtectFileReadOnly
            autocmd! AutoProtectFileReadOnly
            execute 'autocmd BufReadPost ' . g:autoprotectfile_readonly_paths . ' setlocal readonly'
        augroup END
    endif

    " nomodifiable
    if exists('g:autoprotectfile_nomodifiable_paths') && g:autoprotectfile_nomodifiable_paths
        augroup AutoProtectFileNoModifiable
            autocmd! AutoProtectFileNoModifiable
            execute 'autocmd BufReadPost ' . g:autoprotectfile_nomodifiable_paths . ' setlocal nomodifiable'
        augroup END
    endif
endif

" vim: ts=4 sw=4 sts=0 et
