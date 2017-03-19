# My first program in R Programming
# print ( myString)

start.time <- Sys.time()
input = "input.txt"
valid <- range(0,4294967295)
#print (valid)
library(data.table)
#require(data.table)

inputdata <- read.table(input,sep="-")
sorted <- data.table(inputdata,key="V1")
smallest <- valid[2]
sectionStart <- 0
section <- valid
unblocked <- 0
for(i in 1:(dim(sorted)[1] - 1) ) {
  startOfCurrent <- sorted[i,1]
  endOfCurrent <- sorted[i,2]
  startOfNext <- sorted[i+1,1]

  if( startOfCurrent > section[1] ) {
    sectionLength <- startOfCurrent - section[1]
    unblocked <- unblocked + sectionLength
    if( section[1] < smallest)
    {
      smallest <- section[[1]]
    }
  }

  if( endOfCurrent > section[1]) {
    section[1] <- endOfCurrent + 1
  }
}
print(paste("unblocked: ",unblocked))
print (paste("smallest:",smallest)) # 17348574 first ry

end.time <- Sys.time()
time.taken <- end.time - start.time
print (time.taken)
