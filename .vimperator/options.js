// options.js
// janus_wel <janus.wel.3@gmail.com>

// options
// don't start new vim
let options = ' -f --remote-tab-wait-silent';
let editor = 'gvim';
if (liberator.has('MacUnix')) {
    editor = '/Applications/MacVim.app/Contents/MacOS/MacVim';
}

liberator.modules.options.editor = editor + options;

// vim: ts=4 sw=4 sts=4 et fdm=marker fdc=3
