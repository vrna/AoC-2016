# get the input file name
import sys
inputfile = sys.argv[1]
# open file
F = open(inputfile, "r")
# handle row by row
lines = F.readlines()

for line in lines:
	for c in line
		new_ord = ord(c) + n
		if new_ord > ord('z'):
			new_ord = new_ord - (2*n)
		print c + " --> " + new_ord
	

