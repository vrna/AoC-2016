/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.cpp
 * Author: Artturi
 *
 * Created on 18 March 2017, 12:27
 */

#include <cstdlib>
#include<iostream>
#include<string>
#include<vector>
#include <algorithm>
using namespace std;

/*
 * 
 */

string stringify(vector<bool> &a)
{
    string output = "";
    
    for(int i = 0; i < a.size(); ++i)
    {
        if( a.at(i))
        {
            output.push_back('1');
        }
        else
        {
            output.push_back('0');
        }
    }
    return output;
}

vector<bool> createData(string input,int length)
{
    // generating data
    // Call the data you have at this point "a".
    // Make a copy of "a"; call this copy "b".
    // Reverse the order of the characters in "b".
    // In "b", replace all instances of 0 with 1 and all 1s with 0.
     // The resulting data is "a", then a single 0, then "b"
    vector<bool> a;
    for(int i = 0; i < input.size(); ++i)
        a.push_back(input.at(i) == '1');
    
    while( a.size() < length)
    {
        vector<bool> b = a;
        reverse(b.begin(), b.end());
        
        a.push_back(false);
        for(int i = 0; i < b.size(); ++i)
        {
            a.push_back(!b.at(i));
        }
    }
            
    return a;
}

string createChecksum(vector<bool> data, int length)
{
    //take pair
    // if match = 1
    // if not match = 0
    // length even - repeat
    vector<bool> result;
    for(int i = 0; i < length && i < data.size(); i = i+2)
    {
        result.push_back(data.at(i) == data.at(i+1));
        //cout << stringify(result) << endl;
    }
    
    if(result.size() % 2 == 0)
    {
        return createChecksum(result,length);
    }
    else
    {
        return stringify(result);
    }
    return stringify(data);
}
int main(int argc, char** argv) {

    // part 1 details
    string input = "10111011111001111";
    //int datalength = 272; // part 1
    
    // part 2 details
    int datalength = 35651584;
    
    vector<bool> data = createData(input,datalength);
    
    // calculate checksum
    string checksum = createChecksum(data,datalength);
    cout << checksum;
    return 0;
}
