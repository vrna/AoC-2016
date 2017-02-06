/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aoc_2_9grid;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Artturi
 */
class Grid {
    
    private List< List< String > > m_Grid;
    private Coordinate m_Location;
    
    private Map< Character, Coordinate> m_Directions;
    public Grid()
    {
        m_Grid = new ArrayList< List< String > > ();
        m_Location = null;
        
        // U: -1,0
        // L: 0.-1
        // R: 0,1
        // D: 1,0
        m_Directions = new HashMap<Character, Coordinate>();
        m_Directions.put('U', new Coordinate(-1,0));
        m_Directions.put('L', new Coordinate(0,-1));
        m_Directions.put('R', new Coordinate(0,1));
        m_Directions.put('D', new Coordinate(1,0));
    }

    void addRow(String... gridValues) {
        ArrayList< String > row = new ArrayList< String > ( Arrays.asList(gridValues));
        
        m_Grid.add(row);
        
    }

    void setStartingLocation(int y, int x) {
        m_Location = new Coordinate(y,x);
        m_Location.setLimits(0,0,m_Grid.size() - 1,m_Grid.get(0).size() - 1);
    }

    void moveToDirection(Character direction) {
        
        m_Location.sum(m_Directions.get(direction));
    }

    String valueAtCurrentLocation() {
        return m_Grid.get(m_Location.y_).get(m_Location.x_);
    }
}
