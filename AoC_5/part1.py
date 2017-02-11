import time
start_time = time.time()
import sys
import hashlib
input = sys.argv[1]
i = 0
code = ""
while len(code) < 8:
	md5 = hashlib.md5()
	md5.update(input + str(i))
	hash = md5.hexdigest()
	if hash.startswith("00000"):
		code += hash[5]
		print str(i) + ":" + code
	i += 1
print "final: " + code
print "took: " + str(time.time() - start_time)
