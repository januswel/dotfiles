// .vimperator.js
// janus_wel <janus.wel.3@gmail.com>

// options {{{1
// don't start new vim {{{2
let options = ' -f --remote-tab-wait-silent';
let editor = 'gvim';
if (liberator.has('MacUnix')) {
    editor = '/Applications/MacVim.app/Contents/MacOS/MacVim';
}

liberator.modules.options.editor = editor + options;


// mappings {{{1
// commands like win32 {{{2
let modifier = 'C';
let redo_key = '<C-y>';
if (liberator.has('MacUnix')) {
    modifier = 'M';
    redo_key = '<S-M-z>';
}

liberator.execute('noremap <C-a> <C-v><' + modifier + '-a>', null, true);
liberator.execute('noremap <C-c> <C-v><' + modifier + '-c>', null, true);
liberator.execute('noremap <C-s> <C-v><' + modifier + '-s>', null, true);

liberator.execute('inoremap <C-x> <C-v><' + modifier + '-x>', null, true);
liberator.execute('inoremap <C-v> <C-v><' + modifier + '-v>', null, true);
liberator.execute('inoremap <C-z> <C-v><' + modifier + '-z>', null, true);
liberator.execute('inoremap <C-y> <C-v>' + redo_key, null, true);

liberator.execute('cnoremap <C-x> <C-v><' + modifier + '-x>', null, true);
liberator.execute('cnoremap <C-v> <C-v><' + modifier + '-v>', null, true);
liberator.execute('cnoremap <C-z> <C-v><' + modifier + '-z>', null, true);
liberator.execute('cnoremap <C-y> <C-v>' + redo_key, null, true);


// finish {{{1
liberator.echo('.vimperator.js sourced.');

// }}}1
// vim: ts=4 sw=4 sts=4 et fdm=marker fdc=3
