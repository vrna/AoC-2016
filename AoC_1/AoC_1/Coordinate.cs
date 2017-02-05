/*
 * Created by SharpDevelop.
 * User: Artturi
 * Date: 05/02/2017
 * Time: 20:49
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;

namespace AoC_1
{
	
	public enum Direction {NORTH, WEST, SOUTH, EAST};
	
	/// <summary>
	/// Description of Coordinate.
	/// </summary>
	public class Coordinate
	{
		public int x_;
		public int y_;
		
		public Coordinate()
		{
			x_ = 0;
			y_ = 0;
		}
		
		public Coordinate(int x, int y)
		{
			x_ = x;
			y_ = y;
		}
		
		public Coordinate Copy()
		{
			return new Coordinate(x_, y_);
		}

		public void MoveTo(Direction direction, int multiplier)
		{
			if( direction == Direction.NORTH)
			{
				y_ += multiplier;
			}
			else if( direction == Direction.SOUTH)
			{
				y_ -= multiplier;
				
			}
			else if( direction == Direction.WEST)
			{
				x_ -= multiplier;
			}
			else if( direction == Direction.EAST)
			{
				x_ += multiplier;
				
			}
		}

		public static int CountDistance(Coordinate start, Coordinate end)
		{
			int diff_x = end.x_ - start.x_;
			int diff_y = end.y_ - start.y_;
			
			return Math.Abs(diff_x) +  Math.Abs(diff_y);
			
		}
		
		public override string ToString()
		{
			return "(" + y_ + "," + x_ + ")";
		}

		public Coordinate(string coord)
		{
			string[] coordinates = coord.Split(',');
			string y = coordinates[0].Replace("(","");
			y_ = Convert.ToInt32(y);
			
			string x = coordinates[1].Replace(")","");
			x_ = Convert.ToInt32(x);
		}
	}
}
