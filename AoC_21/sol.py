import time
start_time = time.time()
import sys

inputfile = "input.txt"
inp = list("abcdefgh")
F = open(inputfile, "r")
lines = F.readlines()
print "".join(inp)
for line in lines:
    line = line.replace("\r","").replace("\n","")
    print line
    args = line.split(" ")
    # swap position X with position Y
    # swap letter X with letter Y
    if args[0] == "swap":
        x = 0
        y = 0
        if args[1] == "position":
            x = int(args[2])
            y = int(args[5])
        else:
            x = inp.index(args[2])
            y = inp.index(args[5])
        temp = inp[x]
        inp[x] = inp[y]
        inp[y] = temp
    # rotate left/right X
    # rotate based on position of letter X
    elif args[0] == "rotate":
        x = 0
        if args[1] == "based":
            x = inp.index(args[6])
            if x >= 4:
                x = x + 1
            x = x + 1
            x = x % len(inp)
            inp = inp[-x:] + inp[:-x]
        else:
            x = int(args[2])
            if args[1] == "left":
                x = x * -1
            inp = inp[-x:] + inp[:-x]
    # reverse positions X through Y
    elif args[0] == "reverse":
        x = int(args[2])
        y = int(args[4]) + 1
        inp = inp[0:x] + list(reversed(inp[x:y])) + inp[y:]
    # move position X to position Y
    elif args[0] == "move":
        x = int(args[2])
        y = int(args[5])
        charx = inp[x]
        inp.remove(charx)
        inp.insert(y,charx)
    print " " + "".join(inp)
print " " + "".join(inp)
print "took: " + str(time.time() - start_time)
