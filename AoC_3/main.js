/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 console.log("Hello");
 
functions = require('./functions.js');
fs = require('fs');

// 'C:/Users/Artturi/Documents/GitHub/AoC-2016/AoC_3/input.txt'
var infile = "input.txt";
var text = fs.readFileSync(infile,'utf8');

var output = functions.handleData(text);

console.log("Part 1:" + output);
console.log("Part 2:" + functions.handleData2(text))
