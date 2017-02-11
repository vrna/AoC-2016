# get the input file name
import sys
inputfile = sys.argv[1]
# open file
F = open(inputfile, "r")
# handle row by row
lines = F.readlines()
for line in lines:
	rotated = ""
	text = filter(str.islower,line)
	sectorid = int(filter(str.isdigit,line))
	n = sectorid % 26
	for c in text:
		new_ord = ord(c) + n
		if new_ord > ord('z'):
			new_ord = new_ord - 26
		rotated += chr(new_ord)
	#print text
	print str(sectorid) + ":" + rotated
	#print "---"
	

