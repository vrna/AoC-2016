# get the input file name
import sys
from collections import Counter
inputfile = sys.argv[1]
columns = int(sys.argv[2])
# open file
F = open(inputfile, "r")
# handle row by row
lines = F.readlines()
counters = list()
# init counter
for i in xrange(0,columns):
	counters.append( Counter() )
for line in lines:
	for i in xrange(0,len(line)):
		if str.isalpha(line[i]):
			counters[i].update(line[i])

code = list()
reverse = list()
for counter in counters:
	code.append(str(counter.most_common(1)[0][0]))
	reverse.append(str(counter.most_common()[-1][0]))
	
print "Code: " + "".join(code)
print "Reverse Code: " + "".join(reverse)
