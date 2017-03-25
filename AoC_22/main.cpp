/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.cpp
 * Author: Artturi
 *
 * Created on 25 March 2017, 18:35
 */

#include <cstdlib>
#include <string>
#include <vector>
#include <fstream>
#include <iostream>
using namespace std;
struct Node
{
    int x;
    int y;
    int size;
    int used;
    int avail;
};
/*
 * 
 */

string between(string str, string start, string end) {
    unsigned first = str.find(start) + 1;
    unsigned last = str.find(end);
    string strNew = str.substr (first,last-first);
    
    return strNew;
}
int main(int argc, char** argv) {
    std::ifstream file("input.txt");
    std::string line; 
    
    vector< vector< Node > > nodes;
    vector< Node > row;
    while (std::getline(file, line))
    {
        if( line.size() > 0 && line.substr(0,9) == "/dev/grid")
        {
            // 0123456789 123456789 123456789 123456789 123456
            // Filesystem              Size  Used  Avail  Use%
            // /dev/grid/node-x32-y30   85T   65T    20T   76%
            Node node;
            
            // str.substr (pos)
            //int value = atoi(myString.c_str());
            string part1 = line.substr(15);
            node.x = atoi(  (between(part1, "x","-")).c_str()   );
            node.y = atoi(  (between(part1, "y"," ")).c_str()   );
            node.size = atoi( (line.substr(22,5).c_str()));
            node.used = atoi( (line.substr(28,5).c_str()));
            node.avail = atoi( (line.substr(34,6).c_str()));
            //cout << node.x << "," << node.y << "," << node.size << "," << node.used << "," << node.avail << endl;
            
            if( !row.empty() && node.y == 0)
            {
                nodes.push_back(row);
                row.clear();
            }
            
            row.push_back(node);
        }
        
        
    }
     nodes.push_back(row);   
    // now, scroll the bloody grid
    int viable = 0;
    int unviable = 0;
    int total = 0;
    unsigned xsize = nodes.size();
    unsigned ysize = nodes.at(0).size();
    for(unsigned x = 0; x < xsize; ++x)
    {
        for(unsigned y = 0; y < ysize; ++y)
        {
            for(unsigned x1 = 0; x1 < xsize; ++x1)
            {
                for(unsigned y1 = 0; y1 < ysize; ++y1)
                {
                    total++;
                    // Nodes A and B are not the same node.
                    if( x != x1 || y != y1)
                    {
                        // Size  Used  Avail  Use%
                        Node A = nodes.at(x).at(y);
                        Node B = nodes.at(x1).at(y1);
                        // Node A is not empty (its Used is not zero)
                        // The data on node A (its Used) would fit on node B (its Avail)
                        if( A.used > 0 && A.used <= B.avail)
                        {
                            //cout << "Viable pair: (" << x << "," << y << ") - (" << x1 << "," << y1 << ")" << endl;
                            ++viable;
                        }
                        else
                        {
                            ++unviable;
                            string foo = "bar";
                        }
                    }

                }
            }
        }
    }
    cout << "Pairs: " << viable << endl;
    cout << "non: " << unviable << endl;
    cout << "total: " << total << endl;
    // 33 x 31 = 1023
    // 1023 * 1022 = 1 045 506
    // 982112 + 960 = 983072 hmm
    // 1023 * 1023 = 1046529
    return 0;
}

