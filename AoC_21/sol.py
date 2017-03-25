import time
start_time = time.time()
import sys
# with reverse, demo.txt: decab --> abcde (this won't work!!!)
# with reverse, input.txt: aefgbcdh --> abcdefgh
inputfile = "input.txt"
inp = list("fbgdceah")
F = open(inputfile, "r")
lines = F.readlines()
print "".join(inp)
reverse = True
start = 0
end = len(lines)
for i in range(start,end):
    j = i + 1
    if reverse:
        i = end - i - 1
    line = lines[i]
    line = line.replace("\r","").replace("\n","")
    #print line
    args = line.split(" ")
    # swap position X with position Y
    # swap letter X with letter Y
    # not infcluenced by reverse
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
            if reverse:
                x = inp.index(args[6])
                org = 0
                if x % 2 == 0:
                    if(x == 0):
                        org = 7
                    else:
                        org = x / 2 + 3
                else:
                    org = (x-1) / 2
                rot = (org - x)
                inp = inp[-rot:] + inp[:-rot]
                #print "rotated " + str(x) + " to " + str(org) + " (" + str(rot) + ")"
            else:
                x = inp.index(args[6])
                inp = inp[-1:] + inp[:-1]
                if x >= 4:
                    x += 1
                x = x % len(inp)
                inp = inp[-x:] + inp[:-x]
        else:
            x = int(args[2])
            if args[1] == "left":
                x *= -1
            if reverse:
                x *= -1
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
        if reverse:
            temp = x
            x = y
            y = temp
        charx = inp[x]
        #print "moving " + charx + " to " + str(y)
        inp.remove(charx)
        inp.insert(y,charx)
    print "".join(inp)
print "".join(inp)
print "took: " + str(time.time() - start_time)
