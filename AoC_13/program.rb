# oh god.. apparently ruby does not support two dimensional arrays
favNr = Integer(ARGV[0])
class Room
  def squares
    @squares
  end
  def distance
    @distance
  end
  def location
    @location
  end

  def initialize(height, width, favnr,distance)
    @squares = Array.new(height) {"." * width}
    @width = width
    @height = height
    @fav = favnr
    @distance = distance
    calculate(favnr)
  end

  def calculate(favour)
    for y in 0..@height-1
      row = @squares[y]
      for x in 0..@width-1
        ch = row[x]
        @squares[y][x] = code(y,x,favour)

      end
    end
  end

  def addRow
    row = "." * @height
    for x in 0..@width - 1
      row[x] = code(@height,x,@fav)
    end
    @height += 1
    @squares.push(row)
  end

  def addColumn
    for y in 0..@height -1
      ch = code(y,@width,@fav)
      @squares[y] += ch
    end

    @width += 1
  end

  def code(y,x,fav)
    nr = x*x + 3*x + 2*x*y + y + y*y + fav
    bin = nr.to_s(2)
    if bin.count("1") % 2 == 1
      return "#"
    else
      return "."
    end
  end

  def canMoveTo(loc)
    #puts "looking to move to " + loc.to_s
    #puts "current height " + @height.to_s + " , width " + @width.to_s
    # inside borders
    y = loc[0]
    x = loc[1]
    if( y < 0 or x < 0)
      return false
    end

    if y >= @height
      #puts "let's add a row!"
      addRow
      #print
    end

    if x >= @width
      #puts "let's add a column"
      addColumn
      #print
    end

    # not a wall
    # not moved to already
    if(@squares[y][x] == "#" or @squares[y][x] == "O")
      return false
    end
    #puts "can move to " + loc.to_s
    return true
  end

  def copy
    c = Room.new @height,@width,@fav,@distance+1
    for y in 0..@height - 1
      for x in 0..@width - 1
        c.squares[y][x] = @squares[y][x]
      end
    end

    return c
  end

  def moveTo(loc)

    if canMoveTo(loc)
      @squares[loc[0]][loc[1]] = "O"
      @location = loc
    end
  end


  def print
    # print x indexes
    header = "  "
    for x in 0..@width-1
      header += x.to_s[-1]
    end
    puts header
    for y in 0..@height-1
      row = y.to_s
      row += " "
      row += @squares[y]
      puts row
    end
  end
end

r = Room.new 10,10,favNr,0
# let's find the way!
r.print

# starting point 1,1
r.moveTo([1,1])
destination = [39,31]
states = Array.new
states.push(r)
index = 0
dist = -1
while index < states.size do
  cRoom = states[index]
  #puts ""
  #cRoom.print
  cLoc = cRoom.location
  # check if you reached the destination
  if cLoc == destination
    puts "reached destination " + cLoc.to_s
    cRoom.print
    distance = cRoom.distance
    break
  end
  # define possible directions (up, down, left, right)
  # check for each if you can move there
  # if you can, copy the room and move to new place
  up = [cLoc[0] - 1,cLoc[1]]
  if cRoom.canMoveTo(up)
    c = cRoom.copy
    c.moveTo(up)
    states.push(c)
  end
  down = [cLoc[0] + 1,cLoc[1]]
  if cRoom.canMoveTo(down)
    c = cRoom.copy
    c.moveTo(down)
    states.push(c)
  end
  right = [cLoc[0],cLoc[1]+1]
  if cRoom.canMoveTo(right)
    c = cRoom.copy
    c.moveTo(right)
    states.push(c)
  end
  left = [cLoc[0],cLoc[1]-1]
  if cRoom.canMoveTo(left)
    c = cRoom.copy
    c.moveTo(left)
    states.push(c)
  end
  index += 1
end

puts "distance: " + distance.to_s
#z.print
#r.print
