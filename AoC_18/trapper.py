import time
start_time = time.time()
input = "^.....^.^^^^^.^..^^.^.......^^..^^^..^^^^..^.^^.^.^....^^...^^.^^.^...^^.^^^^..^^.....^.^...^.^.^^.^"
height = 400000
width = len(input)
upperrow = input
def out(x):
    return x < 0 or x >= width

safes = input.count(".")
for y in range(1,height):
    row = ""
    for x in range(0,width):
        if (out(x-1) or upperrow[x-1] == ".") is not (out(x+1) or upperrow[x+1] == "."):
            row += "^"
        else:
            row += "."
    upperrow = row
    safes += row.count(".")

print "safe tiles: " + str(safes)
print "took: " + str(time.time() - start_time)
