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
#include <sstream>
#include <iostream>
#include <list>
#include <set>
#include <conio.h>
using namespace std;
struct Node
{
    int x;
    int y;
    int size;
    int used;
    int avail;
    Node()
    {
        x = 0;
        y = 0;
        size = 0;
        used = 0;
        avail = 0;
    }
};
/*
 * 
 */

string tostring(int number)
{
    std::ostringstream ss;
    ss << number;
    return ss.str();
}
struct State
{
    vector<vector<Node> > Nodes;
    Node TargetData;
    int Steps;
    string Hash = "";
    
    State(vector<vector<Node> > nodes, Node trg, int steps)
    {
        Nodes = nodes;
        TargetData = trg;
        Steps = steps;
        countHash();
    }
    
    void countHash()
    {
        // create hash
        Hash = tostring(TargetData.x) + "," + tostring(TargetData.y) + " ";
        for(int x = 0; x < Nodes.size(); ++x )
        {
            for(int y = 0; y < Nodes.at(x).size(); ++y)
            {
                Hash = Hash + tostring(Nodes.at(x).at(y).avail) + "|";
            }
            
            Hash += "-";
        }
       // cout << Hash << endl;
        
    }
    
    void print()
    {
        for(int y = 0; y < Nodes.at(0).size(); ++y )
        {
            for(int x = 0; x < Nodes.size(); ++x)
            {
                if( TargetData.x == x && TargetData.y == y)
                {
                    cout << "G";
                }
                else if( Nodes.at(x).at(y).avail > 60)
                {
                    cout << "_";
                }
                else if( Nodes.at(x).at(y).used > 100)
                {
                    cout << "#";
                }
                else
                {
                    cout << ".";
                }
                //cout << " ";
                
            }
            
            cout << endl;
        }
        
        cout << endl;
    }
    
    bool matches( State* other)
    {
        return Hash == other->Hash;
        
        if(TargetData.x != other->TargetData.x || TargetData.y != other->TargetData.y)
        {
            return false;
        }
        for(unsigned x = 0; x < Nodes.size(); ++x)
        {
            for(unsigned y = 0; y < Nodes.at(x).size(); ++y)
            {
                if( Nodes.at(x).at(y).used != other->Nodes.at(x).at(y).used )
                {
                    return false;
                }
            }
        }
        return true;
    }
};
string between(string str, string start, string end) {
    unsigned first = str.find(start) + 1;
    unsigned last = str.find(end);
    string strNew = str.substr (first,last-first);
    
    return strNew;
}
int countViablePairs(vector< vector< Node > > &nodes)
{
    int viable = 0;
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
                            ++viable;
                        }
                    }

                }
            }
        }
    }
    
    return viable;
}
int maxX = 0;
int maxY = 0;
bool isWithinBorders(Node &A, int x, int y)
{
    bool inside = (A.x + x >= 0 && A.x + x < maxX && A.y + y >= 0 && A.y + y < maxY);
    return inside;
}

bool isViablePair(Node &A, Node &B)
{
    bool isSame = A.x == B.x && A.y == B.y;
    if( !isSame && A.used > 0 && A.used <= B.avail)
    {
        return true;
    }
    
    return false;
}

State* createState(State* previous, int x1,int y1, int dx, int dy)
{
    State* created = new State(previous->Nodes,previous->TargetData,previous->Steps + 1);
    int x2 = x1 + dx;
    int y2 = y1 + dy;
    // move data from current to new one
    int data = created->Nodes.at(x1).at(y1).used;
    created->Nodes.at(x1).at(y1).used = 0;
    created->Nodes.at(x1).at(y1).avail += data;
    created->Nodes.at(x2).at(y2).used += data;
    created->Nodes.at(x2).at(y2).avail -= data;
    
    // did you move the target data
    if( created->TargetData.x == x1 && created->TargetData.y == y1)
    {
        created->TargetData.x = x2;
        created->TargetData.y = y2;
    }
    // update the hash
    created->countHash();
    return created;
}

list<State*> states;
int countSteps(vector< vector< Node > > &nodes)
{
    // define initial state:
    Node target;
    target.y = 0;
    target.x = nodes.size() - 1;
    State* initial = new State(nodes,target,0);
    states.push_back(initial);
    maxX = nodes.size();
    maxY = nodes.at(0).size();
    // data amount of each grid cell and the location of our main data
    // find each step you can do (truly viable pairs)
    // each such step will form a state
    // if you moved your Goal data, change state of it
    // if state has already been checked, ignore it
    // if state hasn't been checked, add it to list
    int index = 0;
    int directions [4][2] = { {0,1},{0,-1},{1,0},{-1,0} };
    int lastAmountOfSteps = -1;
    set<string> hashes;
    
    while(index < states.size())
    {
        State* s = states.front();
        s->print();
        if( s->Steps > lastAmountOfSteps)
        {
            lastAmountOfSteps = s->Steps;
            cout << "step level: " << lastAmountOfSteps << ", states: " << states.size() << endl;
        }
        for(unsigned x = 0; x < nodes.size(); ++x)
        {
            for(unsigned y = 0; y < nodes.at(x).size(); ++y)
            {
                Node A = s->Nodes.at(x).at(y);
                
                for(int d = 0; d < 4; ++d)
                {
                    int dx = directions[d][0];
                    int dy = directions[d][1];
                    
                    if( isWithinBorders(A,dx,dy) && isViablePair(A,s->Nodes.at(x+dx).at(y+dy)))
                    {
                        // create a new State
                        State* created = createState(s,A.x,A.y,dx,dy);
                        

                        if( created->TargetData.x == 0 && created->TargetData.y == 0)
                        {
                            return created->Steps;
                        }
                        
                        // check that state hasn't been checked already!
                        bool found = hashes.find(created->Hash) != hashes.end();
                        
                        if( !found)
                        {
                            states.push_back(created);
                            hashes.insert(created->Hash);
                        }
                    }
                }
            }
        }
        
        //++index;
        delete states.front();
        states.pop_front();
    }
    return -1;
}

int walkthrough(vector< vector< Node > > &nodes)
{
    Node goal;
    goal.y = 0;
    goal.x = nodes.size() - 1;
    
    maxX = nodes.size();
    maxY = nodes.at(0).size();
    // start from x=3, y=28, and move that along
    int steps = 0;
    Node location = nodes.at(3).at(28);
    
    bool quit = false;
    while(!quit && (goal.y != 0 || goal.x != 0) )
    {
        // read direction
        
        for(int y = 0; y < nodes.at(0).size(); ++y )
        {
            for(int x = 0; x < nodes.size(); ++x)
            {
                if( goal.x == x && goal.y == y)
                {
                    cout << "G";
                }
                else if( nodes.at(x).at(y).avail > 60)
                {
                    cout << "_";
                }
                else if( nodes.at(x).at(y).used > 100)
                {
                    cout << "#";
                }
                else
                {
                    cout << ".";
                }
                
            }
            cout << endl;
        }
        cout << steps << endl;
        cout << endl;
        char key = ' ';
        key = _getch();
        
        
        int dx = 0;
        int dy = 0;
        
        switch (key)
        {
            case '8':
                dy = -1;
                break;
            case '2':
                dy = 1;
                break;
            case '4':
                dx = -1;
                break;
            case '6':
                dx = 1;
                break;
            case 'q':
                quit = true;
        }
        
        Node target = nodes.at(location.x+dx).at(location.y+dy);
        if( isWithinBorders(location,dx,dy) && isViablePair(target,location))
        {
            // move data
            if(target.x == goal.x && target.y == goal.y)
            {
                goal.x = location.x;
                goal.y = location.y;
            }
            // target becomes empty
            nodes.at(location.x).at(location.y).used += target.used;
            nodes.at(location.x).at(location.y).avail -= target.used;
            nodes.at(target.x).at(target.y).used = 0;
            nodes.at(target.x).at(target.y).avail = target.size;
            location = nodes.at(target.x).at(target.y);
            
            
            ++steps;
        }
        
    }
    return steps;
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
            
            
            if( !row.empty() && node.y == 0)
            {
                nodes.push_back(row);
                row.clear();
            }
            
            row.push_back(node);
        }
        
        
    }
     nodes.push_back(row);
    
     bool part1 = false;
     if(part1) {
        // now, scroll the bloody grid
        // part 1
        int viable = countViablePairs(nodes);
        cout << "Pairs: " << viable << endl;
     }
     else
     {
         // come on, doesn't work
         //int steps = countSteps(nodes);
         int steps = walkthrough(nodes);
         cout << "steps: " << steps << endl;
         cout << "press any key.." << endl;
         char key = _getch();
     }
     
     for( list<State*>::iterator it = states.begin(); it != states.end(); ++it)
     {
         delete *it;
     }
     
    return 0;
}

