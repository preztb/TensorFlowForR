library(tensorflow)
library(keras)

#scalars are numbers eg 1 is scalar

#vectors are in 1 dimension

x <- as.array(c(12,3,6,7))
str(x)

length(dim(x))

#matricies 2 vectors

x <- array(seq(3 * 5), dim = c(3, 5))

dim(x)


# Rank 3 or higher tensors (dimensions)

