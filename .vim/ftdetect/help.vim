" vim ftdetect file
" Filename:     help.vim
" Language:     help
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 03.
" Version:      0.11
" License:      New BSD License
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

autocmd BufNewFile,BufRead ~/vimfiles/doc/*.txt setfiletype help
autocmd BufNewFile,BufRead ~/.vim/doc/*.txt     setfiletype help

" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
