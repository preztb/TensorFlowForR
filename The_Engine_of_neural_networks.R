library(tensorflow)
library(keras)

#first model transforms data as such

output <- relu(dot(input, W) + b)

#W and b are Weights and trainable parameters