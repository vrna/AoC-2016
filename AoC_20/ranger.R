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
#print (sorted)
smallest <- valid[2]
for(i in 1:(dim(sorted)[1] - 1) ) {
  end <- sorted[i,2]
  start <- sorted[i+1,1]
  if( end < start) {
    # TODO: replace only if smaller than previous
    if(end+1 < smallest)
    {
      smallest <- end + 1
    }
  }

  # TODO: check that smallest is not in the range
  if(smallest >= sorted[i,1] && smallest <= sorted[i,2] )
  {
    smallest <- valid[2]
  }
}
print ("smallest:") # 17 348 574 first ry
print (smallest)
end.time <- Sys.time()
time.taken <- end.time - start.time
print (time.taken)
