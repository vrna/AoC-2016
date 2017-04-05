import time
start_time = time.time()
import sys

class Node:
    y = 0
    x = 0
    d = 0
    name = ""
    def __init__(self,name, y, x, d):
        self.name = name
        self.y = y
        self.x = x
        self.d = d

    def __eq__(self, other):
        if isinstance(other, Node):
            return self.y == other.y and self.x == other.x
        return NotImplemented

    def __ne__(self, other):
        result = self.__eq__(other)
        if result is NotImplemented:
            return result
        return not result

    def printme(self):
        if self.name is not "":
            return self.name + ":" + str(self.y) + "," + str(self.x)
        else:
            return str(self.y) + "," + str(self.x)

    def move(self, y,x):
        dest = Node("",self.y + y, self.x + x, self.d + 1)
        return dest

def canMoveTo(visitedgrid, currentNode, dy, dx):
    y = currentNode.y + dy
    x = currentNode.x + dx

    if y < len(visitedgrid) and x < len(visitedgrid[y]) and visitedgrid[y][x] is not "#":
        return True
    else:
        return False

import copy
#new_list = copy.copy(old_list)
def findDistances(nodes, grid):
    distances = dict()
    # could optimize and stop counting when all found... let's check that later
    for key, sourceNode in nodes.iteritems():
        subdict = dict()
        distances[sourceNode.name] = subdict
        # starting point is the node
        # copy the grid to mark visited/unvisited
        visited = copy.deepcopy(grid)
        # init a list of nodes to check
        nodesToCheck = []
        nodesToCheck.append(sourceNode)
        #print visited
        i = 0
        #print "checking " + sourceNode.name
        while( i < len(nodesToCheck)):
            current = nodesToCheck[i]
            c = visited[current.y][current.x]

            if c is not "#":
                #print "checking " + current.printme()
                if c.isdigit() and c is not sourceNode.name:
                    if c not in distances[sourceNode.name]:
                        distances[sourceNode.name][c] = current.d
                        #print "found path from " + sourceNode.name + " to " + c + ", dis: " + str(current.d)

                visited[current.y][current.x] = "#"

                if canMoveTo(visited,current,-1,0):
                    nodesToCheck.append(current.move(-1,0))
                    #print "can move up from " + current.printme()
                if canMoveTo(visited, current,1,0):
                    nodesToCheck.append(current.move(1,0))
                    #print "can move down from " + current.printme()
                if canMoveTo(visited, current,0,1):
                    nodesToCheck.append(current.move(0,1))
                    #print "can right down from " + current.printme()
                if canMoveTo(visited, current,0,-1):
                    nodesToCheck.append(current.move(0,-1))
                    #print "can left down from " + current.printme()
            i += 1
    return distances

inputfile = "real.in"

F = open(inputfile, "r")
# handle row by row
lines = F.readlines()
i = 0
grid = []
nodes = dict()
nodenames = list()
for y in xrange(0, len(lines)):
    line = lines[y]
    chars = []
    line = line.replace("\n","")
    for x in xrange(0, len(line)):
        c = line[x]
        chars.append(c)
        if c.isdigit():
            node = Node(c,y,x,0)
            nodes[c] = node
            nodenames.append(c)
    grid.append(chars)

distances = findDistances(nodes, grid)

# :grin:
# we are startomg from 0. Skip it in the permutations
nodenames.remove("0")

import itertools
paths = itertools.permutations(nodenames)
smallestLength = 999999999
for path in paths:
    pathLength = distances["0"][path[0]]

    for i in xrange(0,len(path)-1):
        pathLength += distances[ path[i] ][ path[i+1] ]

    if pathLength < smallestLength:
        smallestLength = pathLength



print "smallest path: " + str(smallestLength)
print "took: " + str(time.time() - start_time)
