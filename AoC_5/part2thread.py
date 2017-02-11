import time
start_time = time.time()
import sys
import hashlib
import threading
input = sys.argv[1]
i = -1
code = list("--------")
lock = threading.Lock()

class myThread (threading.Thread):
    def __init__(self, threadID, name, ):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
		
		
    def run(self):
		global i
		global code
		print "Starting " + self.name
		while "-" in code:
			with lock:
				i += 1
			md5 = hashlib.md5()
			md5.update(input + str(i))
			hash = md5.hexdigest()
			if hash.startswith("00000"):
				if hash[5].isdigit():
					p = int(hash[5])
					if p < 8 and code[p] == "-":
						code[p] = hash[6]
						
						print self.name + " found " + "".join(code)
			if i % 1000000 == 0:
				print self.name + " checked " + str(i) + ", code: " + "".join(code)
			
		print "Exiting " + self.name

l = list()

for t in xrange(0,8):
	thread = myThread(t, "Thread-"+str(t+1))
	thread.start()
	l.append(thread)

for t in l:
	t.join()
"""	
# Create new threads
thread1 = myThread(1, "Thread-1")
thread2 = myThread(2, "Thread-2")

# Start new Threads
thread1.start()
thread2.start()
	
thread1.join()
thread2.join()
"""
	

print "final: " + "".join(code)
print "time: " + str(time.time() - start_time)
