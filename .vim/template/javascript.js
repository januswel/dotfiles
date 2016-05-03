'use strict';

var solver = function (input) {
    var answer = input;
    return answer;
};

process.stdin.resume();
process.stdin.setEncoding('utf8');

var input = '';
process.stdin.on('data', function (chunk) {
    input += chunk;
});
process.stdin.on('end', function () {
    var lines = input.trim().split('\n');
    var answer = solver(lines);
    console.log(answer);
});
