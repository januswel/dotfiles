" vim ftdetect file
" Filename:     hatena.vim
" Language:     hatena notation
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Version:      0.22
" License:      New BSD License
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

" from vimperator
autocmd BufRead */vimperator-*.hatena.ne.jp*.tmp setfiletype hatena

" local editing
autocmd BufRead,BufNewFile *.hnt    setfiletype hatena

" vim: ts=4 sw=4 sts=0 et
