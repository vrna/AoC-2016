# My first program in R Programming
# print ( myString)

starttime <- 0
discIndex <- 1
discLength <- 5
discPos <- 4

# print( (starttime + discIndex + discLength + discPos ) %% discLength )
f  <- readLines("input.txt")
l  <- length(f)
# Disc #1 has 5 positions; at time=0, it is at position 4.
#  1    2  3  4   5         6   7      8 9   10   11    12
discs <- matrix(NA,nrow=l,ncol=3)
for(i in 1:l) {
  # print (f[i])
  ss <- strsplit(f[i], " ")[[1]]
  index <- as.numeric(gsub('#','',ss[2]))
  size <- as.numeric(ss[4])
  pos <- as.numeric(ss[12])
  discs[i,] <- c(index, pos, size)

  #print (discs)
  }

fun <- function(x,t) {
  return ((t + x[1] + x[2] ) %% x[3])
}

sum <- -1
time <- -1

while( sum != 0 ) {
  sum <- 0
  time <- time + 1
  for( i in 1:l )
  {
    sum = sum + fun( discs[i,],time )
  }
  #print (sum)
}
# part 1 = 376777
print (time)
