// mappings.js
// janus_wel <janus.wel.3@gmail.com>

let modifier = 'C';
let redo_key = '<C-y>';
if (liberator.has('MacUnix')) {
    modifier = 'M';
    redo_key = '<S-M-z>';
}

liberator.execute('noremap <C-a> <C-v><' + modifier + '-a>', null, true);
liberator.execute('noremap <C-c> <C-v><' + modifier + '-c>', null, true);
liberator.execute('noremap <C-s> <C-v><' + modifier + '-s>', null, true);

liberator.execute('inoremap <C-a> <C-v><' + modifier + '-a>', null, true);
liberator.execute('inoremap <C-x> <C-v><' + modifier + '-x>', null, true);
liberator.execute('inoremap <C-v> <C-v><' + modifier + '-v>', null, true);
liberator.execute('inoremap <C-z> <C-v><' + modifier + '-z>', null, true);
liberator.execute('inoremap <C-y> <C-v>' + redo_key, null, true);

liberator.execute('cnoremap <C-x> <C-v><' + modifier + '-x>', null, true);
liberator.execute('cnoremap <C-v> <C-v><' + modifier + '-v>', null, true);
liberator.execute('cnoremap <C-z> <C-v><' + modifier + '-z>', null, true);
liberator.execute('cnoremap <C-y> <C-v>' + redo_key, null, true);

// vim: ts=4 sw=4 sts=4 et fdm=marker fdc=3
