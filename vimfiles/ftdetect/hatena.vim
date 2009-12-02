" Vim ftdetect file
" Language:     hatena notation
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/03/06 19:15:26.
" Version:      0.20

" from vimperator
autocmd BufRead */vimperator-d.hatena.ne.jp*.tmp    setfiletype hatena

" local editing
autocmd BufRead,BufNewFile ~/work/hatena/diary/*    setfiletype hatena

" vim: ts=4 sw=4 sts=0 et
