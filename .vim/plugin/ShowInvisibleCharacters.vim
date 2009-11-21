" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/11/21 11:56:07.
" Version:      0.23
" Remark:       define syntaxes for invisible characters

" check required features
if !has('autocmd') || !has('syntax')
    finish
endif

syntax on
function! ShowInvisibleCharacters()
    " double width space
    syntax match DoubleWidthSpace   /\%u3000/ display containedin=ALL
    " trailing whitespace characters
    syntax match TrailingWhitespace /\s\+$/ display containedin=ALL
    " tab space
    syntax match TabSpace           /\t/ display containedin=ALL

    if version >= 508 || !exists('did_invisiblecharacters_syntax_inits')
        if version < 508
            let did_invisiblecharacters_syntax_inits = 1
            command -nargs=+ HiLink hi link <args>
        else
            command -nargs=+ HiLink hi def link <args>
        endif

        HiLink DoubleWidthSpace     Error
        HiLink TrailingWhitespace   Error
        HiLink TabSpace             Error

        delcommand HiLink
    endif
endf

augroup showInvisible
    autocmd! showInvisible
    autocmd BufWinEnter,ColorScheme * call ShowInvisibleCharacters()
augroup END

" vim: ts=4 sw=4 sts=0 et
