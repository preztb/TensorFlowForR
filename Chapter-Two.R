library(tensorflow)
library(keras)

mnist <- dataset_mnist()

train_images <- mnist$train$x
train_labels <- mnist$train$y
test_images <- mnist$test$x
test_labels <- mnist$test$y

model <- keras_model_sequential(list(
  layer_dense(units = 512, activation = "relu"),
  layer_dense(units = 10, activation = "softmax")
))

compile(model,
        optimizer = "rmsprop",
        loss = "sparse_categorical_crossentropy",
        metrics = "accuracy")

train_images <- array_reshape(train_images, c(60000, 28 * 28))
train_images <- train_images / 255
test_images <- array_reshape(test_images, c(10000, 28 * 28))
test_images <- test_images / 255

fit(model, train_images, train_labels, epochs = 5, batch_size = 128)

test_digits <- test_images[1:10, ]
predictions <- predict(model, test_digits)
str(predictions)
predictions[1, ]

#testing
which.max(predictions[1, ])

predictions[1, 8]

test_labels[1]

metrics <- evaluate(model, test_images, test_labels)
metrics["accuracy"]
