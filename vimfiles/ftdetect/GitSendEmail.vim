" vim ftdetect file
" Filename:     GitSendEmail.vim
" Language:     git send-email --compose
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009 Dec 31.
" Version:      0.10
" License:      New BSD License
"   See LICENSE.  Note that redistribution may be permitted with this file.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE

autocmd BufRead .msg.* :setfiletype mail
