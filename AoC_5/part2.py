import time
start_time = time.time()
import sys
import hashlib
input = sys.argv[1]
i = 0
code = list("--------")
while "-" in code:
	md5 = hashlib.md5()
	md5.update(input + str(i))
	hash = md5.hexdigest()
	if hash.startswith("00000"):
		if hash[5].isdigit():
			p = int(hash[5])
			if p < 8 and code[p] == "-":
				code[p] = hash[6]
				print str(i) + ":" + "".join(code)
	i += 1
print "final: " + "".join(code)
print "time: " + str(time.time() - start_time)
