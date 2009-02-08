// .vimperator.js
// author: janus_wel <janus.wel.3@gmail.com>
// for 2.0pre
// Last Change: 2009/02/08 07:57:09.

// key mappings for video services
// plugin : nnp_cooperation.js
// plugin : nicontroller.js
// plugin : youtubeamp.js
liberator.plugins.nicomap = function() {
    // stuff functions
    function registMaps(maps) {
        for (let i=0, max=maps.length ; i<max ; ++i) {
            liberator.modules.mappings.addUserMap(
                [liberator.modules.modes.NORMAL],
                [maps[i].command],
                maps[i].description,
                maps[i].action,
                maps[i].extra
            );
        }
        return true;
    }
    function removeMaps(maps) {
        for (let i=0 ; i<maps.length ; ++i) {
            liberator.modules.mappings.remove(liberator.modules.modes.NORMAL, maps[i].command);
        }
        return true;
    }

    // map definitions
    const defMaps = [
        {
            command:        'a',
            action:         function() {},
            description:    'Nop',
            extra:          {},
        },
        {
            command:        'v',
            action:         function() { liberator.execute('viewSBMComments -t hd'); },
            description:    'display social bookmark comments',
            extra:          { rhs: ':viewSBMComments -t hd<CR>', },
        },
        {
            command:        'p',
            action:         function() {},
            description:    'Nop',
            extra:          {},
        },
    ];

/*
        template
        {
            url:    '',
            maps:   [
                {
                    command:        '',
                    action:         function() {},
                    description:    '',
                    extra:          {},
                },
            ],
        },
*/
    const maps = [
        {
            url:    '^http://www\\.nicovideo\\.jp/(watch|ranking|mylist)',
            maps:   [
                {
                    command:        '<Leader>a',
                    action:         function() { liberator.execute('nnppushallvideos'); },
                    description:    'push all video in current tab to NicoNicoPlaylist',
                    extra:          { rhs: ':nnppushallvideos<CR>', },
                },
                {
                    command:        '<Leader>q',
                    action:         function() { liberator.execute('nnpclear'); },
                    description:    'clear NicoNicoPlaylist buffers',
                    extra:          { rhs: ':nnpclear<CR>', },
                },
                {
                    command:        'l',
                    action:         function() { liberator.execute('nnpgetlist'); },
                    description:    'display NicoNicoPlaylist',
                    extra:          { rhs: ':nnpgetlist<CR>', },
                },
                {
                    command:        '<Leader>i',
                    action:         function() { liberator.execute('nicoinfo') },
                    description:    'display "nicontroller.js" information',
                    extra:          { rhs: ':nicoinfo<CR>', },
                },
                {
                    command:        'p',
                    action:         function() { liberator.execute('nicopause'); },
                    description:    'toggle pause / play current tab\'s video',
                    extra:          { rhs: ':nicopause<CR>', },
                },
                {
                    command:        'm',
                    action:         function() { liberator.execute('nicomute'); },
                    description:    'toggle mute current tab\'s video',
                    extra:          { rhs: ':nicomute<CR>', },
                },
                {
                    command:        'v',
                    action:         function() { liberator.execute('nicommentvisible'); },
                    description:    'toggle comment visible current tab\'s video',
                    extra:          { rhs: ':nicommentvisible<CR>', },
                },
                {
                    command:        'z',
                    action:         function() { liberator.execute('nicosize'); },
                    description:    'toggle normal / fit-window size current tab\'s video',
                    extra:          { rhs: ':nicosize<CR>', },
                },
                {
                    command:        's',
                    action:         function() { liberator.execute('nicoseek'); },
                    description:    'seek to start current tab\'s video',
                    extra:          { rhs: ':nicoseek<CR>', },
                },
                {
                    command:        'h',
                    action:         function() { liberator.execute('nicodescription'); },
                    description:    'toggle display or not the description for video',
                    extra:          { rhs: ':nicodescription<CR>', },
                },
                {
                    command:        'x',
                    action:         function() { liberator.execute('normal :nicomment<Space>'); },
                    description:    'fill comment field by assigned string',
                    extra:          { rhs: 'normal :nicocomment<Space>', },
                },
                {
                    command:        'X',
                    action:         function() { liberator.execute('normal :nicommand<Space>'); },
                    description:    'fill command field by assigned string',
                    extra:          { rhs: 'normal :nicommand<Space>', },
                },
                {
                    // [N]n
                    // play N th video.
                    // if N is not specified, next video will be played.
                    command:        'n',
                    action:         function(count) {
                        if(count === -1) count = 1;
                        liberator.execute(':nnpplaynext ' + count);
                    },
                    description:    'play next item in NicoNicoPlaylist',
                    extra:          { flags:  liberator.modules.Mappings.flags.COUNT },
                },
                {
                    // [N]w
                    // delete N th video.
                    // if N is not specified, next video will be deleted.
                    command:        'D',
                    action:         function(count) {
                        if(count === -1) count = 1;
                        for(let i=0 ; i<count ; ++i) liberator.execute(':nnpremove');
                        liberator.execute(':nnpgetlist');
                    },
                    description:    'remove item in NicoNicoPlaylist',
                    extra:          { flags:  liberator.modules.Mappings.flags.COUNT },
                },
                {
                    // [N]-
                    // seek to minus N seconds.
                    // if N is not specified, minus 10 seconds.
                    command:        '-',
                    action:         function(count) {
                        if(count === -1) count = 10;
                        liberator.execute(':nicoseek! ' + '-' + count);
                    },
                    description:    'seek by count backward',
                    extra:          { flags:  liberator.modules.Mappings.flags.COUNT },
                },
                {
                    // [N]+
                    // seek to plus N seconds.
                    // if N is not specified, plus 10 seconds.
                    command:        '+',
                    action:         function(count) {
                        if(count === -1) count = 10;
                        liberator.execute(':nicoseek! ' + count);
                    },
                    description:    'seek by count forward',
                    extra:          { flags:  liberator.modules.Mappings.flags.COUNT },
                },
            ],
        },

        {
            url:    '^http://[^\\.]+\\.youtube\\.com/watch',
            maps:   [
                {
                    command:        '<Leader>i',
                    action:         function() { liberator.execute('ytinfo') },
                    description:    'display "youtubeamp.js" information',
                    extra:          { rhs: ':ytinfo<CR>', },
                },
                {
                    command:        'p',
                    action:         function() { liberator.execute('ytpause'); },
                    description:    'toggle pause / play current tab\'s video',
                    extra:          { rhs: ':ytpause<CR>', },
                },
                {
                    command:        'm',
                    action:         function() { liberator.execute('ytmute'); },
                    description:    'toggle mute current tab\'s video',
                    extra:          { rhs: ':ytmute<CR>', },
                },
                {
                    command:        'z',
                    action:         function() { liberator.execute('ytsize'); },
                    description:    'toggle normal / fit-window size current tab\'s video',
                    extra:          { rhs: ':ytsize<CR>', },
                },
                {
                    command:        's',
                    action:         function() { liberator.execute('ytseek'); },
                    description:    'seek to start current tab\'s video',
                    extra:          { rhs: ':ytseek<CR>', },
                },
                {
                    // [N]-
                    // seek to minus N seconds.
                    // if N is not specified, minus 10 seconds.
                    command:        '-',
                    action:         function(count) {
                        if(count === -1) count = 10;
                        liberator.execute(':ytseek! ' + '-' + count);
                    },
                    description:    'seek by count backward',
                    extra:          { flags:  liberator.modules.Mappings.flags.COUNT },
                },
                {
                    // [N]+
                    // seek to plus N seconds.
                    // if N is not specified, plus 10 seconds.
                    command:        '+',
                    action:         function(count) {
                        if(count === -1) count = 10;
                        liberator.execute(':ytseek! ' + count);
                    },
                    description:    'seek by count forward',
                    extra:          { flags:  liberator.modules.Mappings.flags.COUNT },
                },
            ],
        },
    ];

    // main
    let applyMaps;
    for (let i=0, max=maps.length ; i<max ; ++i) {
        if (buffer.URL.match(maps[i].url)) {
            liberator.log(maps[i].url, 9);
            applyMaps = maps[i].maps;
        }
        else {
            removeMaps(maps[i].maps);
        }
    }

    applyMaps
        ? registMaps(applyMaps)
        : registMaps(defMaps);
};


// plugin: migratestatusbar.js
liberator.globalVariables.migrate_elements = [
    {
        // star button of awesome bar
        id:    'star-button',
        dest:  'security-button',
        after: true,
    },
    {
        // icon that show the existence of RSS and Atom on current page
        id:    'feed-button',
        dest:  'security-button',
        after: true,
    },
    {
        // favicon of awesome bar
        id:    'page-proxy-stack',
        dest:  'liberator-statusline',
        after: false,
    },
];

// finished
liberator.echo('.vimperator.js sourced.');

// vim: sw=4 sts=4 ts=4 et
