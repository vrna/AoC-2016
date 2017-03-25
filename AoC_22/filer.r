start.time <- Sys.time()

f  <- readLines("input.txt")
l  <- length(f)

# Node A is not empty (its Used is not zero).
# Nodes A and B are not the same node.
#The data on node A (its Used) would fit on node B (its Avail).
library(data.table)
#require(data.table)

inputdata <- read.table("input.txt",sep=" ")
print (inputdata)
#for(3 in 1:l) {
#   ss <- strsplit(f[i], " ")[[1]]

  #print (f[i])
#}

end.time <- Sys.time()
time.taken <- end.time - start.time
print (time.taken)
