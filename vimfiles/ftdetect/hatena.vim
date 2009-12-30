" vim ftdetect file
" Filename:     hatena.vim
" Language:     hatena notation
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.
" Version:      0.21
" License:      New BSD License
"   See LICENSE.  Note that redistribution may be permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" from vimperator
autocmd BufRead */vimperator-d.hatena.ne.jp*.tmp    setfiletype hatena

" local editing
autocmd BufRead,BufNewFile ~/work/hatena/diary/*    setfiletype hatena

" vim: ts=4 sw=4 sts=0 et
