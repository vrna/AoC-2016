/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aoc_2_9grid;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Artturi
 */
public class AoC_2_9Grid {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        //String inputfile = args[0];
        String inputFile = "C:\\Users\\Artturi\\Documents\\GitHub\\AoC-2016\\finalinput.txt";
        
        // initialize your grid to create the keypad
        Grid myGrid = new Grid();
       
        myGrid.addRow("1","2","3");
        myGrid.addRow("4","5","6");
        myGrid.addRow("7","8","9");
        myGrid.setStartingLocation(1,1);
        
        
        String finalCode = new String("");
        
        // okay, well start reading
        try (BufferedReader br = new BufferedReader(new FileReader(inputFile))) {
            String line;
            while ((line = br.readLine()) != null) {
               // process the line.
               for( int i = 0; i < line.length(); ++i)
               {
                   Character direction = line.charAt(i);
                   myGrid.moveToDirection(direction);
               }
               
               finalCode += myGrid.valueAtCurrentLocation();
            }
        } catch (IOException ex) {
            Logger.getLogger(AoC_2_9Grid.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        //System.console().print(finalCode);
        //System.out.print(finalCode);
        System.out.println(finalCode);
    }
    
}
