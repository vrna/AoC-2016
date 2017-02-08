# get the input file name
import sys
from collections import Counter
inputfile = sys.argv[1]
# open file
F = open(inputfile, "r")
# handle row by row
lines = F.readlines()
total = 0
for line in lines:
	# extract checksum
	checksum = line[line.find("[")+1:line.find("]")]
	# get rid of the checksum
	other = line[0:line.find("[")]
	# extract numeric and alpha values
	sectorid = int(filter(str.isdigit,other))
	name = filter(str.islower,other)
	# count the frequencies, sort
	count = Counter(name)
	arrangedCount = sorted(count,key=lambda x: (-count[x], x))
	# count checksum
	mychecksum = ""
	for i in xrange(0,5):
		mychecksum += arrangedCount[i][0]
	# verify the checksum
	if mychecksum == checksum:
		total += sectorid
		print name
print total
