/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

module.exports = {

    handleData: function (data) {
         return process(data);
    },
    
    handleData2: function(data) {
         return process2(data);
    }

};

function process(data)
{
           var lines = data.toString().split("\n");
           var count = 0;
           
           for(var i = 0; i < lines.length - 1; i++) {
               
                var line = lines[i];
                
                if( line) {
                    line = line.trim();
                    line = line.replace(/\s+/g, ' ');

                    var pieces = line.split(" ");
                    var sorted = numerifyAndSort(pieces);
                    //console.log(sorted);
                    // In a valid triangle, the sum of any two 
                    // sides must be larger than the remaining side
                    //if( sorted[0] + sorted[1] > sorted[2] &&
                    //        sorted[1] + sorted[2] > sorted[0] &&
                    //        sorted[2] + sorted[0] > sorted[1]) {
                    if( isValidTriangle(sorted)) {
                        count++;
                    }
                }
           }
           
           return count;
}

function process2(data)
{
           var lines = data.toString().split("\n");
           var count = 0;
           
           for(var i = 0; i < lines.length - 1; i = i+3) {
               //console.log(i);
                if( lines[i] && lines[i+1] && lines[i+2]) {
                    var threeLines = [lines[i],lines[i+1],lines[i+2]];
                    
                    for(var j = 0; j < 3; j++) {
                        var line = threeLines[j];
                        line = line.trim();
                        line = line.replace(/\s+/g, ' ');
                        threeLines[j] = line;
                    }
                    var grid = [threeLines[0].split(" "),threeLines[1].split(" "),threeLines[2].split(" ")];
                    for(var j = 0; j < 3; j++) {
                        var triangle = constructTriangle(grid,j);
                        var sorted = numerifyAndSort(triangle);
                        if( isValidTriangle(sorted )) {
                            ++count;
                        }
                    }
                }
           }
           
           return count;
}

function constructTriangle(grid, i) {
    var construct = [grid[0][i], grid[1][i], grid[2][i]];
    return construct
}

function isValidTriangle(triangle) {
    //console.log(triangle);
    if( triangle.length > 0 && 
            triangle[0] + triangle[1] > triangle[2] &&
            triangle[1] + triangle[2] > triangle[0] &&
            triangle[2] + triangle[0] > triangle[1]) {
        return true;
    }
    else
    {
        return false;
    }
}

function numerifyAndSort(myArray) {
    for(var i=0; i<myArray.length; i++) { myArray[i] = +myArray[i]; } 
    myArray.sort(sortNumber);
    
    return myArray
    
}

function sortNumber(a,b) {
    return a - b;
}
