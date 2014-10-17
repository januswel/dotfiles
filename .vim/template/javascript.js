'use strict';

// RequireJS config
var require = {
    baseUrl: './scripts',
    paths: {
        jquery: 'http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min',
        'jQuery.UI': 'http://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min',
        Backbone: 'http://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.2/backbone-min',
        underscore: 'http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.7.0/underscore-min',
        json2: 'http://cdnjs.cloudflare.com/ajax/libs/json2/20130526/json2.min'
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

(function () {

// define module
define(['jquery'], function () {
});

// script
require(['jquery', 'jQuery.UI'], function ($) {
    $(document).ready(function () {
        $('input.datepicker').datepicker();
    });
});

})();
