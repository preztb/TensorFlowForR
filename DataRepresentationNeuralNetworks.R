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

x <- array(seq(2 * 3 * 4), dim = c(2,3,4))
str(x)

length(dim(x))

#usually go from rank 0 - 4, but use rank 5 for video data

mnist <- dataset_mnist()
train_images <- mnist$train$x
train_labels <- mnist$train$y
test_images <- mnist$test$x
test_labels <- mnist$test$y

#2.2.5

length(dim(train_images))

dim(train_images)

typeof(train_images)

#2.8 displaying the fifth digit

digit <- train_images[5, , ]
plot(as.raster(abs(255 - digit), max = 255))

train_labels[5]

#2.2.6 Manulaping Tensors in R

my_slice <- train_images[10:99, , ]
dim(my_slice)

my_slice <- train_images[, 15:28, 15:28]
dim(my_slice)

#1st batch of data - split into batches of 128
batch <- train_images[1:128, , ]

#2nd batch of data
batch <- train_images[129:256, , ]

#nth batch of data
n <- 3
batch <- train_images[seq(to = 128 * n, length.out = 128), , ]

#2.2.8 real applications of 

