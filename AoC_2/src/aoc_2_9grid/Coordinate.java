/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aoc_2_9grid;

/**
 *
 * @author Artturi
 */
class Coordinate {
    public Integer x_;
    public Integer y_;
    
    public Coordinate()
    {
        x_ = null;
        y_ = null;
    }
    
    public Coordinate(int y, int x)
    {
        x_ = new Integer(x);
        y_ = new Integer(y);
    }

    
    public Coordinate sum(Coordinate sum)
    {
        return new Coordinate(sum.y_ + y_, sum.x_ + x_);
        
        
    }

}
