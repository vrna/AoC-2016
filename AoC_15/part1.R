# My first program in R Programming
# print ( myString)

start.time <- Sys.time()

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
findzero <- function(d) {
  sum <- -1
  time <- -1
  while( sum != 0 ) {
    sum <- 0
    time <- time + 1
    #sum <- sum(apply(d,1,fun,t=time)) slow
    i <- 1
    while( i <= l & sum == 0)
    {
      sum <- sum + fun(d[i,],time)
      i <- i + 1
    }
  }
  time
}
# part 1
#print(discs)
time <- findzero(discs)
print (time)

# part 2
l <- l + 1
disc7 <- c(l,0,11)
discs <- rbind(discs,disc7)
time <- findzero(discs)
print (time)

end.time <- Sys.time()
time.taken <- end.time - start.time
print (time.taken)
