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

liberator.execute('noremap <C-1> <C-v><' + modifier + '-1>', null, true);
liberator.execute('noremap <C-2> <C-v><' + modifier + '-2>', null, true);
liberator.execute('noremap <C-3> <C-v><' + modifier + '-3>', null, true);
liberator.execute('noremap <C-4> <C-v><' + modifier + '-4>', null, true);
liberator.execute('noremap <C-5> <C-v><' + modifier + '-5>', null, true);
liberator.execute('noremap <C-6> <C-v><' + modifier + '-6>', null, true);
liberator.execute('noremap <C-7> <C-v><' + modifier + '-7>', null, true);
liberator.execute('noremap <C-8> <C-v><' + modifier + '-8>', null, true);
liberator.execute('noremap <C-9> <C-v><' + modifier + '-9>', null, true);

liberator.execute('inoremap <C-a> <' + modifier + '-a>', null, true);
liberator.execute('inoremap <C-c> <' + modifier + '-c>', null, true);
liberator.execute('inoremap <C-x> <' + modifier + '-x>', null, true);
liberator.execute('inoremap <C-v> <' + modifier + '-v>', null, true);
liberator.execute('inoremap <C-z> <' + modifier + '-z>', null, true);
liberator.execute('inoremap <C-y> ' + redo_key, null, true);

liberator.execute('cnoremap <C-c> <' + modifier + '-c>', null, true);
liberator.execute('cnoremap <C-x> <' + modifier + '-x>', null, true);
liberator.execute('cnoremap <C-v> <' + modifier + '-v>', null, true);
liberator.execute('cnoremap <C-z> <' + modifier + '-z>', null, true);
liberator.execute('cnoremap <C-y> ' + redo_key, null, true);

// vim: ts=4 sw=4 sts=4 et fdm=marker fdc=3
