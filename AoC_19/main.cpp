/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.cpp
 * Author: Artturi
 *
 * Created on 19 March 2017, 12:02
 */

#include <cstdlib>
#include <iostream>
#include <list>
#include <algorithm>
#include <numeric>
using namespace std;

/*
 * 
 */
struct IncGenerator {
    int current_;
    IncGenerator (int start) : current_(start) {}
    int operator() () { return current_++; }
};
int main(int argc, char** argv) {
    
    int elfcount = 3018458;
    IncGenerator g (1);
    list<int> elves(elfcount) ; 
    generate( elves.begin(), elves.end(), g);
    list<int>::iterator it = elves.begin();
    
    cout << endl;
    while(elfcount > 1)
    {
        ++it;
        if(it == elves.end())
        {
            it = elves.begin();
        }
        elves.erase(it++);
        if(it == elves.end())
        {
            it = elves.begin();
        }
        elfcount--;
    }
    
    cout << "winner: " << *(elves.begin()) << endl;
    return 0;
}

