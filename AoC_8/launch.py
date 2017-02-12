# get the input file
import sys
inputfile = sys.argv[1]
# open file
F = open(inputfile, "r")

def find_between( s, first, last ):
	try:
		start = s.index( first ) + len( first )
		end = s.index( last, start )
		return s[start:end]
	except ValueError:
		return ""
		
import numpy as np
from scipy.ndimage.interpolation import shift

def printarray( ar ):
	global depth
	global width
	pixels = 0
	for y in xrange(0,depth):
		row = ""
		for x in xrange(0,width):
			ch = ar[y,x]
			if ch == 0:
				row += " "
			else:
				row += "#"
				pixels += 1
			
		print row
	print pixels
	
# handle row by row
lines = F.readlines()

# init array
width = 50
depth = 6
a = np.zeros((depth,width))

#stdscr = curses.initscr()
#curses.noecho()
#pad = curses.newpad(depth,width)
for line in lines:
	# rect AxB
	#print line
	if line.startswith("rect"):
		x = int(find_between(line,"rect","x"))
		y = int(line[line.index("x")+1:])
		b = np.ones((y,x))
		a[0:y,0:x] = b
	if line.startswith("rotate column"):
		i = int(find_between(line,"x=","by").strip())
		by = int(line[line.index("by ")+3:])
		a[:,i] = np.roll(a[:,i],by)
	if line.startswith("rotate row"):
		i = int(find_between(line,"y=","by").strip())
		by = int(line[line.index("by ")+3:])
		a[i] = np.roll(a[i],by)
	# used to sequence my output :)
	#print a
	#raw_input();
	
printarray(a)

"""
a = np.zeros((2,3))
print a
print ""
# sets y, x
a[0,0] = 4
a[0,1] = 5
a[0,2] = 6
a[1,0] = 1
a[1,1] = 2
a[1,2] = 3
print a
print ""
#array = np.rollaxis(array,1)
a[0] = np.roll(a[0],-1)
print a
print ""
a[:,1] = np.roll(a[:,1],1)
print a

b = np.ones((2,2))

a[0:2,1:3] = b
print a

"""