/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aoc_2_9grid;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Artturi
 */
class Grid {
    
    private List< List< String > > m_Grid;
    private Coordinate m_Location;
    private String NULLGRID = "-";
    
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

    Grid(String gridFile) {
        
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
        
        try (BufferedReader br = new BufferedReader(new FileReader(gridFile))) {
            String line;
            while ((line = br.readLine()) != null) {
               // process the line.
               ArrayList<String> row = new ArrayList<String>();
               for( int i = 0; i < line.length(); ++i)
               {
                   Character value = line.charAt(i);
                   
                   row.add(value.toString());
               }
               m_Grid.add(row);
            }
        } catch (IOException ex) {
            Logger.getLogger(AoC_2_9Grid.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    void addRow(String... gridValues) {
        ArrayList< String > row = new ArrayList< String > ( Arrays.asList(gridValues));
        
        m_Grid.add(row);
    }

    void setStartingLocation(int y, int x) {
        m_Location = new Coordinate(y,x);
    }

    void setStartingLocation(String loc) {
        for( int y = 0; y < m_Grid.size() && m_Location == null; ++y)
        {
            for( int x = 0; x < m_Grid.size() && m_Location == null; ++x)
            {
                String gridValue = m_Grid.get(y).get(x);
                
                if( !gridValue.equals(NULLGRID) && gridValue.equals(loc) )
                {
                    m_Location = new Coordinate(y,x);
                }
            }
        }
    }

    void moveToDirection(Character direction) {
        Coordinate desiredTarget = m_Location.sum(m_Directions.get(direction));
        
        if( insideMyBorders( desiredTarget))
        {
            m_Location = desiredTarget;
        }
    }

    String valueAtCurrentLocation() {
        return m_Grid.get(m_Location.y_).get(m_Location.x_);
    }

    private boolean insideMyBorders(Coordinate desiredTarget) {
        // y must match
        if( desiredTarget.y_ >= 0 && desiredTarget.y_ < m_Grid.size() )
        {
            // x must match
            if( desiredTarget.x_ >= 0 && desiredTarget.x_ < m_Grid.get(desiredTarget.y_).size())
            {
                if( !m_Grid.get(desiredTarget.y_).get(desiredTarget.x_).equals(NULLGRID) )
                {
                    return true;
                }
            }
        }
        
        return false;
    }
}
