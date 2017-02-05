/*
 * Created by SharpDevelop.
 * User: Artturi
 * Date: 05/02/2017
 * Time: 20:38
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Collections.Generic;

namespace AoC_1
{
	class Program
	{
		public static void Main(string[] args)
		{
			Console.WriteLine("Hello World!");
			
			string inputfile = args[0];
			string result = args[1];
			string visitedTwice = args[2];
			
			string input = System.IO.File.ReadAllText(inputfile);
			
			string[] instrucstions = input.Split(',');
			
			Player pekka = new Player();
			Coordinate start = new Coordinate();
			System.IO.File.WriteAllText( "debug.txt","");
			bool foundFirstDuplicate = false;
			
			foreach( string instruction in instrucstions)
			{
				// process
				// read next input
				// determine direction
				// travel distance
				string cleaned = instruction.Trim();
				
				string started = pekka.YourLocation().ToString();
				char turn = cleaned[0];
				int multiplier = Convert.ToInt32(cleaned.Substring(1));
				
				pekka.Move( turn, multiplier);
				
				string ended = pekka.YourLocation().ToString();
				
				System.IO.File.AppendAllText( "debug.txt", instruction + ": " + started + " --> " + ended + Environment.NewLine);
				
			}
			// count distance
			Coordinate firstDuplicate = pekka.FirstCrossing();
			
			int distance = Coordinate.CountDistance( start, pekka.YourLocation() );
			System.IO.File.WriteAllText( result, distance.ToString() );
			
			int distancePar2 = Coordinate.CountDistance( start, firstDuplicate );
			System.IO.File.WriteAllText( visitedTwice, distancePar2.ToString() );
		}
	}
}