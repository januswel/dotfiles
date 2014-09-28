'use strinct';

// RequireJS config
var require = {
    baseUrl: './scripts',
    paths: {
        jquery: 'http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min',
        'jQuery.UI': 'http://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min',
        Backbone: 'http://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone-min',
        underscore: 'http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.1/underscore-min',
        json2: 'http://cdnjs.cloudflare.com/ajax/libs/json2/20121008/json2'
    },
    shim: {
        'jQuery.UI': ['jquery'],
        underscore: {
            exports: '_'
        },
        Backbone: {
            deps: ['underscore', 'json2', 'jquery'],
            exports: 'Backbone'
        }
    }
};

// define module
define(['jquery'], function () {
});

// script
require(['jquery', 'jQuery.UI'], function ($) {
    $(document).ready(function () {
        $('input.datepicker').datepicker();
    });
});
