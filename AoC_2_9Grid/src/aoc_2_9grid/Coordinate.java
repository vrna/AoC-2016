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
    private Integer minY_ = null;
    private Integer minX_ = null;
    private Integer maxY_ = null;
    private Integer maX_ = null;
    
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

    void setLimits(int minY, int minX, int maxY, int manX) {
        minY_ = new Integer(minY);
        minX_ = new Integer(minX);
        maxY_ = new Integer(maxY);
        maX_ = new Integer(manX);
    }

    void sum(Coordinate sum) {
        Integer targetX = x_ + sum.x_;
        Integer targetY = y_ + sum.y_;
        
        if( targetX >= minX_ && targetX <= maX_)
        {
            x_ = targetX;
        }
        
        if( targetY >= minY_ && targetY <= maxY_)
        {
            y_ = targetY;
        }
    }
}
