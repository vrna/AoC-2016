import time
start_time = time.time()
import sys
import hashlib
import threading
input = sys.argv[1]
i = 0
code = list("--------")
codeWasFound = [-1,-1,-1,-1,-1,-1,-1,-1]
lock = threading.Lock()
blocksize = 100000
# python.exe part2indepentthread.py reyedfim

class myThread (threading.Thread):
    def __init__(self, threadID, name, start):
		threading.Thread.__init__(self)
		self.threadID = threadID
		self.name = name
		self.st = start
		self.end = start + blocksize
		
		
    def run(self):
		global i
		global code
		print "Starting " + self.name
		while "-" in code :
			#print self.name + " checking thru " + str(self.st) + "-" + str(self.end)
			for n in xrange(self.st, self.end):
				md5 = hashlib.md5()
				md5.update(input + str(n))
				hash = md5.hexdigest()
				if hash.startswith("00000"):
					if hash[5].isdigit():
						p = int(hash[5])
						if p < 8 and (code[p] == "-" or (codeWasFound[p] >= 0 and codeWasFound[p] > n)):
							code[p] = hash[6]
							codeWasFound[p] = n
							print self.name + " found " + "".join(code)
			with lock:
				i += blocksize
				self.st = i
				self.end = i + blocksize
		print "Exiting " + self.name

l = list()

for t in xrange(0,4):
	thread = myThread(t, "Thread-"+str(t+1),i)
	thread.start()
	l.append(thread)
	i += blocksize

for t in l:
	t.join()

	

print "final: " + "".join(code)
print "time: " + str(time.time() - start_time)
