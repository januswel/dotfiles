" vim plugin name
" Filename:     profile.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" Last Change:  2009/12/23 00:38:14.
" Version:      0.12
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
" variables {{{2
let s:numoftrials_default = 10000
lockvar s:numoftrials_default

" commands {{{2
if exists(':Profile') != 2
    command -nargs=1 -complete=function Profile
                \ call <SID>Profile(<q-args>)
endif

" functions {{{2
" main
function! TimeExpression(expression)
    let evaluated = eval(a:expression)
    let trials = s:GetNumofTrials()
    let i = 0

    " measure
    let start = reltime()
    while i < trials
        call eval(a:expression)
        let i += 1
    endwhile

    let elapsed = reltime(start)
    let all = str2float(reltimestr(elapsed))
    return [a:expression, evaluated, trials, all]
endfunction

" stuff
" for display
function! s:Profile(expression)
    try
        let [expression, evaluated, trials, all] = TimeExpression(a:expression)
    catch
        echoerr v:exception
        return
    endtry

    let template = [
                \       'expression:       %s',
                \       'evaluated:        %s',
                \       'number of trials: %d',
                \       'time for all:     %f msec',
                \       'time for a trial: %f msec',
                \  ]
    echo printf(join(template, "\n"),
                \ a:expression,
                \ string(evaluated),
                \ trials,
                \ all,
                \ all / trials)
endfunction

" global or script local
function! s:GetNumofTrials()
    if (exists('g:profile_numoftrials')
                \   && type(g:profile_numoftrials) ==# 0
                \   && g:profile_numoftrials > 0)
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
