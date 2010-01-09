" vim plugin name
" Filename:     profile.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2010 Jan 09.
" Version:      0.18
" Dependency:
"   This plugin requires following files
"
"   autoload/jwlib/profile.vim
"   http://github.com/januswel/dotfiles/blob/master/vimfiles/autoload/jwlib/profile.vim
"
" License:      New BSD License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   http://github.com/januswel/dotfiles/vimfiles/LICENSE
"
" Remark: {{{1
"   This plugin provides the function and the command to profile expressions.
"
"   The function TimeExpression() must be specified an expression to measure
"   execution time. this function return the List that has the executed
"   expression, the number of trials and the time through all execusions. The
"   following command:
"
"       :echo TimeExpression('abs(-1)')
"
"   will echo like ['abs(-1)', 10000, 0.122485].
"
"   In default settings, the number of trials is 10000.  In order to change
"   this value, define the global variable "g:profile_numoftrials". this must
"   be a positive number. E.g.:
"
"       let g:profile_numoftrials = 100000
"
"   The command :Profile must be also an expression but no need to quote. The
"   equivalent command of above instance is following one:
"
"       :Profile abs(-1)
"
"   Then you will get following display
"
"       expression:       abs(-1)
"       number of trials: 10000
"       time for all:     0.122485 msec
"       time for a trial: 0.000012 msec
"
"   You may use the command :profile to measure execution time of your function
"   or script. See :help profile

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_profile')
    finish
endif
let loaded_profile = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" constants {{{2
let s:numoftrials_default = 10000
lockvar s:numoftrials_default

let s:items = [
            \   'expression:       %s',
            \   'evaluated:        %s',
            \   'number of trials: %d',
            \   'time for all:     %f msec',
            \   'time for a trial: %f msec',
            \ ]
let s:template = join(s:items, "\n")
lockvar s:template
unlet s:items

" commands {{{2
if exists(':Profile') != 2
    command -nargs=1 -complete=expression Profile
                \ call <SID>Profile(<q-args>)
endif

" functions {{{2
" for display
function! s:Profile(expression)
    try
        let evaluated = eval(a:expression)
        let trials = s:GetNumofTrials()
        let time = jwlib#profile#Expression(a:expression, trials)
    catch
        echoerr v:exception
        return
    endtry

    echo printf(s:template,
                \ a:expression,
                \ string(evaluated),
                \ trials,
                \ time,
                \ time / trials)
endfunction

" global or script local
function! s:GetNumofTrials()
    if exists('g:profile_numoftrials')
        if type(g:profile_numoftrials) != 0 || g:profile_numoftrials <= 0
            throw '"g:profile_numoftrials" must be a positive Number'
        endif
        return g:profile_numoftrials
    else
        return s:numoftrials_default
    endif
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
