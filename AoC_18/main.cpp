/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.cpp
 * Author: Artturi
 *
 * Created on 19 March 2017, 11:18
 */

#include <cstdlib>
#include <bitset>
#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
using namespace std;

int height = 400000;
int const width = 100; // would rather tie this with input length, but cannot be runtime when using bitset
string input = "^.....^.^^^^^.^..^^.^.......^^..^^^..^^^^..^.^^.^.^....^^...^^.^^.^...^^.^^^^..^^.....^.^...^.^.^^.^";
bool isOut(int x) {
    return (x < 0 || x >= width);
}
int main(int argc, char** argv) {

    // safe = true
    
    replace(input.begin(), input.end(),'.','1');
    replace(input.begin(), input.end(),'^','0');
    bitset<width> previous (input);
    int totalCount = previous.count();
    for(int y = 1; y < height;++y)
    {
        bitset<width> row;
        for( int x = 0; x < width; ++x)
        {
            row[x] = (isOut(x-1) || previous[x-1]) == (isOut(x+1) || previous[x+1]);
        }
        totalCount += row.count();
        previous = row;
    }
    cout << totalCount;
    return 0;
}

