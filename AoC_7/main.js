/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var infile = "real.txt";
fs = require('fs');
var data = fs.readFileSync(infile,'utf8');

var lines = data.toString().split("\n");
var supportCount = 0;
var SSLsupportCount = 0;

for(var i = 0; i < lines.length ; i++) {
    
    if( supportsTLS(lines[i]) ) {
        ++supportCount;
        //console.log(lines[i] + " supports TLS");
    }
    if( supportsSSL(lines[i] )) {
        ++SSLsupportCount;
        //console.log(lines[i] + " supports SSL");
    }
    
}

console.log(supportCount + " IPs supports TLS.");
console.log(SSLsupportCount + " IPs supports SLS.");

function supportsTLS(ip) {
    var hasABBA = false;
    var hasABBAInsideBrackets = false;
    var insideBrackets = false;
    for( var j = 0, len = ip.length; j < len; j++ ) {
        var ch = ip[j];
        
        if( ch == "[") {
            insideBrackets = true;
        }
        
        if( insideBrackets && ch == "]") {
            insideBrackets = false;
        }
        
        if( j > 2 && !insideBrackets) {
            if( ch != ip[j-1] && ch == ip[j-3] && ip[j-2] == ip[j-1] ) {
                hasABBA = true;
            }
        }
        if( j > 2 && insideBrackets) {
            if( ch != ip[j-1] && ch == ip[j-3] && ip[j-2] == ip[j-1] ) {
                hasABBAInsideBrackets = true;
            }
            
        }
    }
    
    return hasABBA && !hasABBAInsideBrackets;
}
function supportsSSL(ip) {
    var hypernetABAs = []; // outside brackets
    var supernetABAs = new Set(); // inside brackets
    var insideBrackets = false;
    for( var j = 0, len = ip.length; j < len; j++ ) {
        var ch = ip[j];
        
        if( ch == "[") {
            insideBrackets = true;
        }
        
        if( insideBrackets && ch == "]") {
            insideBrackets = false;
        }
        
        if( j > 1 ) {
            var aba = ip.substring(j-2,j+1);
            if( aba[0] == aba[2] && aba[0] != aba[1] && !aba.includes("[") && !aba.includes("]")) {
                if(insideBrackets) {
                    supernetABAs.add(aba);
                    //console.log("found supernet aba '" + aba + "' in " + ip);
                }
                else {
                    hypernetABAs.push(aba);
                    //console.log("found hypernet aba '" + aba + "' in " + ip);
                }
            }
        }
    }
    
    for( var i = 0; i < hypernetABAs.length; ++i) {
        var aba = hypernetABAs[i];
        var reverse = aba[1] + aba[0] + aba[1];
        if(supernetABAs.has(reverse)) {
            return true;
        }
    }
    
    return false;
}


