import hashlib
class Location:
    y = 0
    x = 0
    def __init__(self, y, x):
        self.y = y
        self.x = x
    def printme(self):
        return "["+ str(self.y)+ "," + str(self.x) +"]"

    def up(self):
        return Location(self.y-1,self.x)

    def down(self):
        return Location(self.y+1,self.x)

    def left(self):
        return Location(self.y,self.x-1)

    def right(self):
        return Location(self.y,self.x+1)

class State:
    def __init__(self, loc, path):
        self.loc = loc
        self.path = path

    def printme(self):
        return "loc " + self.loc.printme() + " path " + self.path

def canMoveTo( loc, code):
    if code in ('b','c','d','e','f'):
        if loc.y >= 0 and loc.x >= 0 and loc.y < 4 and loc.x < 4:
            return True

    return False


s = State(Location(0,0),"")
input = "vwbaicqe"
dest = Location(3,3)
states = [s]
foundpath = ""
allpaths = []
while len(states) > 0:
    cur = states.pop(0)
    #print cur.path
    if dest.printme() == cur.loc.printme():
        allpaths.append(cur.path)
    else:
        md5 = hashlib.md5()
        hash = md5.update(input + cur.path)
        hash = md5.hexdigest()
        des = Location(0,0)
        #print "current " + cur.loc.printme()
        #print hash
        if canMoveTo(cur.loc.up(),hash[0]):
            states.append( State(cur.loc.up(), cur.path + "U"))
            #print "can move up"
        if canMoveTo(cur.loc.down(),hash[1]):
            states.append( State(cur.loc.down(), cur.path + "D"))
            #print "can move down"
        if canMoveTo(cur.loc.left(),hash[2]):
            states.append( State(cur.loc.left(), cur.path + "L"))
            #print "can move left"
        if canMoveTo(cur.loc.right(),hash[3]):
            states.append( State(cur.loc.right(), cur.path + "R"))
            #print "can move right"

if len(allpaths) == 0:
    print "nay"
else:
    print "shortest: " + allpaths[0]
    print "length of longest: " + str(len(allpaths[-1]))
