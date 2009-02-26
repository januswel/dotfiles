" Vim plugin file
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/02/25 23:55:52.
" Version:      0.10
" Remark:       define syntaxes for invisible characters

" show invisible characters
if has('autocmd') && has('syntax')
    syntax on
    function! ShowInvisibleCharacters()
        " double width space
        syntax match DoubleWidthSpace "\%u3000" display containedin=ALL
        " trailing whitespace characters
        syntax match TrailingWhitespace "\s\+$" display containedin=ALL
        " tab space
        syntax match TabSpace "\t" display containedin=ALL

        " these are performed as error
        highlight default link DoubleWidthSpace   Error
        highlight default link TrailingWhitespace Error
        highlight default link TabSpace           Search
    endf

    augroup showInvisible
        autocmd! showInvisible
        autocmd BufNew,BufRead * call ShowInvisibleCharacters()
    augroup END
endif

" vim: ts=4 sw=4 sts=0 et
