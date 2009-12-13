" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/13 12:10:57.
" Version:      0.12
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

" post-processing {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
