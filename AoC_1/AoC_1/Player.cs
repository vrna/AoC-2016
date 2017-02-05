/*
 * Created by SharpDevelop.
 * User: Artturi
 * Date: 05/02/2017
 * Time: 20:49
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Collections.Generic;

namespace AoC_1
{
	/// <summary>
	/// Description of Player.
	/// </summary>
	public class Player
	{
		private Coordinate location;
		private Direction FacingAt;
		private HashSet<string> History = new HashSet<string>();
		private Coordinate FirstDuplicate = null;
		
		public Player()
		{
			location = new Coordinate();
			FacingAt = Direction.NORTH;
			History.Add( location.ToString() );
		}

		public Coordinate YourLocation()
		{
			return location;
		}

		public void Move(char turn, int multiplier)
		{
			int change = 0;
			
			if( turn.ToString().ToUpper() == "R")
			{
				change = -1;
			}
			else if( turn.ToString().ToUpper() == "L")
			{
				change = 1;
			}
			int newDirection = (4 + (int)FacingAt + change) % 4;
			FacingAt = (Direction)newDirection;
			
			for( int i = 0; i < multiplier; ++i)
			{
				location.MoveTo( FacingAt, 1);
				
				if( FirstDuplicate == null && !History.Add(location.ToString() ) )
				{
					FirstDuplicate = location.Copy();
				}
			}
			
		}
		
		public Coordinate FirstCrossing()
		{
			return FirstDuplicate;
		}
	}
}
