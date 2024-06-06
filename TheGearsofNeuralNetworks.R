library(tensorflow)
library(keras)

#2.3 The gears of neural networks: Tensor Operations

layer_dense(units = 512, activation = "relu")

output <- relu(dot(W, input) + b)

#Element-Wise Operations and production speed

naive_relu <- function(x) {
  stopifnot(length(dim(x)) == 2) #x is a rank 2 tensor (matrix)
  for (i in 1:nrow(x))
    for (j in 1:ncol(x))
      x[i, j] <- max(x[i, j], 0)
  x
}

naive_add <- function(x, y) {
  stopifnot(length(dim(x)) == 2, dim(x) == dim(y)) #x and y are rank 2 tensors
  for (i in 1:nrow(x))
    for (j in 1:ncol(x))
      x[i, j] <- x[i, j] + y[i, j]
  x
}

z <- x + y # element wise addition
z[z < 0] <- 0 # element-wise relu

#timing the difference

#blas

random_array <- function(dim, min = 0, max = 1)
  array(runif(prod(dim), min , max),
        dim)

x <- random_array(c(20, 100))
y <- random_array(c(20, 100))

system.time({
  for (i in seq_len(1000)) {
    z <- x + y
    z[z < 0] <- 0
  }
})[["elapsed"]]

#naive 

system.time({
  for (i in seq_len(1000)) {
    z <- naive_add(x, y)
    z <- naive_relu(z)
  }
})[["elapsed"]]


# 2.3.2 broadcasting

x <- random_array(c(32, 10))
y <- random_array(c(10))

# add size 1 to first axis so it become 1, 10

dim(y) <- c(1, 10)
str(y)

#repeat 32 times to end with tensor shape 32,10, where Y[i, ] == y for i in seq(32):

Y <- y[rep(1, 32), ] # repeat 32 times and att to Y
str(Y)

#naive implementation

naive_add_matrix_and_vector <- function(x, y){
  stopifnot(length(dim(x)) == 2, #x is a rank 2 tensor
            length(dim(y)) == 1, #y is a vector
            ncol(x) == dim(y))
  for (i in seq(dim(x) [1]))
    for (j in seq(dim(x) [2])) 
      x[i,j] <- x[i, j] + y[j]
  x
}


#2.3.3 Tensor Product

x <- random_array(c(32))
y <- random_array(c(32))
z <- x %*% y

#dot product in mathematics:

naive_vector_dot <- function(x,y){
  stopifnot(length(dim(x)) == 1, #x and y are the same size
            length(dim(y)) == 1,
            dim(x) == dim(y))
  z <- 0
  for (i in seq_along(x)) 
    z <- z + x[i] * y[i]
  z
}

#different size tensors

naive_matrix_vector_dot <- function(x, y){
  stopifnot(length(dim(x)) == 2,
            length(dim(y)) == 1,
            nrow(x) == dim(y)) # first dimension of x must be the same as the first dimension of y
  z <- array(0, dim = dim(y)) # this operation returns a vector of zeros the same shape as y
  for (i in 1:nrow(x))
    for (j in 1:ncol(x))
      z[i] <- z[i] + x[i, j] * y[j]
  z
    
}

#using the recursion method
naive_matrix_vector_dot <- function(x, y){
  z <- array(0, dim = c(nrow(x)))
  for (i in 1:nrow(x)) 
    z[i] <- naive_matrix_vector_dot(x[i, j, y])
  z
}

#full implementation of dotproduct
naive_vector_dot <- function(x, y){
  stopifnot(length(dim(x)) == 2,
            length(dim(y)) == 2,
            ncol(x) == nrow(y))
  z <- array(0, dim = c(nrow(x), ncol(y)))
  for (i in 1:nrow(x))
    for (j in 1:ncol(y)){
      row_x <- x[i, ]
      column_y <- y[, j]
      z[i, j] <- naive_vector_dot(row_x, column_y)
    }
    
  
}

#2.3.4 Tensor Reshaping

train_images <- array_reshape(train_images, c(60000, 28 * 28))

x <- array(1:6)
x

#different array structures
array_reshape(x, dim = c(3,2))

x <-array_reshape(x, dim = c(2,3))
x


#transpose of x
t(x)


"
2.3.5 Geometric Interpretation of tensor operations

basically linear algebra



2.3.6

a geometric interpretation of deep learning

"


