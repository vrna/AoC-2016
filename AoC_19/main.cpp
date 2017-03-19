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
#include <iterator>
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
    list<int>::iterator removable;
    bool part1 = false;
    if( part1 )
    {
        while(elfcount > 1)
        {
            //cout << "elf now: " << *it << endl;
            removable = it;
            ++removable;

            if(removable == elves.end())
            {
                removable = elves.begin();
            }
            //cout << "remove " << *removable << endl;
            elves.erase(removable);
            elfcount--;

            ++it;
            if(it == elves.end())
            {
                it = elves.begin();
            }
            //cout << "elves: " << elfcount << endl;

        }
    }
    else
    {
        removable = it;
        advance(removable, elfcount / 2);
        bool even = (elfcount % 2 == 0);
        while(elfcount > 1)
        {
            //cout << "elf now: " << *it << endl;
            //cout << "remove " << *removable << endl;
            elves.erase(removable++);
            elfcount--;
            even = !even;
            
            ++it;
            if(it == elves.end())
            {
                it = elves.begin();
            }

            if(removable == elves.end())
            {
                removable = elves.begin();
            }
            if(even)
            {
                ++removable;

                if(removable == elves.end())
                {
                    removable = elves.begin();
                }
            }
        }
    }
    cout << "winner: " << *(elves.begin()) << endl;
    return 0;
}

