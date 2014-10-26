## Practical Machine Learning - Course Project
### Introduction and Goals
The provided dataset in this assignment contains accelerometer measurements of movements by people performing barbell lifts.

The dataset was generously provided by the authors of following paper:<br>
*Velloso, E.; Bulling, A.; Gellersen, H.; Ugulino, W.; Fuks, H. Qualitative Activity Recognition of Weight Lifting Exercises. Proceedings of 4th International Conference in Cooperation with SIGCHI (Augmented Human '13) . Stuttgart, Germany: ACM SIGCHI, 2013.*

Whilst doing these exercises, people were asked to perform the exercises in 5 different ways.<br> Only 1 way was correct (classe A), whilst the other ways were incorrect in a distinctly different way (classe B to E).

The goal of this assignment is to build a model to predict the way the exercise was done, i.e. correct (classe A) of incorrect in one of the distinctly different manners (classes B to E).

#### Overall Summary

A data set of 19622 measurement observations regarding movement of people lifting barbells. Based on the measurement data and it's classification, the goal is to build a model to predict if the lifing excercise is done correcly, or if wrong in which way (4 possible cases) it is performed wrong.

The provided data set is split in 2 data sets. <br>
75%  is used for model training, the remaining 25% is used for validating the obtained model.

The model fitted is Random Forrest. The train function from the caret package was tuned to speed up the calculation.

Validating the obtained model on the test data kept asside we obtain 99.5% correct predictions. This indicates that the model is quite accurate.
With this model the 20 prediction cases (where the outcome is unknown) are predicted and prepared for submission.


#### Data Summary


```r
library(caret)
library(doParallel)
setwd("/home/ruben/R/practmachlearn_data")
set.seed(256)
train <- read.csv("pml-training.csv") #, colClasses="character")
test <- read.csv("pml-testing.csv") #, colClasses="character")
nrow(train)
```

```
## [1] 19622
```

```r
str(train$classe)
```

```
##  Factor w/ 5 levels "A","B","C","D",..: 1 1 1 1 1 1 1 1 1 1 ...
```

```r
# str(train)
# summary(train)
```

#### Data Selection & Preparation

Looking at the data and reading the description of the data (see references in the Introduction):
- We consider the timing information is irrelevant for this exercise.
- Who performed the excercise is irrelevant, we want to predict outcome based on measurements.
- The data contains both the actual measurements and calculated average, min, max, ... values. Looking at the test data we see that actual measurement data is provided to predict on.

Therefor we select only the actual measuring data.<br>
In this way we can strongly reduce the number of variables to take into account.


```r
# only retain the measurement data (i.e. not the time window calculated averages)
meastraindata <- train[train$new_window=="no", ]
rm(train)
#retain only columns containing measurement data
meascolumns <- c("roll_belt",  "pitch_belt",	"yaw_belt",	"total_accel_belt",	"gyros_belt_x",	"gyros_belt_y",	"gyros_belt_z",	"accel_belt_x",	"accel_belt_y",	"accel_belt_z",	"magnet_belt_x",	"magnet_belt_y",	"magnet_belt_z",	"roll_arm",	"pitch_arm",	"yaw_arm",	"total_accel_arm",	"gyros_arm_x",	"gyros_arm_y",	"gyros_arm_z",	"accel_arm_x",	"accel_arm_y",	"accel_arm_z",	"magnet_arm_x",	"magnet_arm_y",	"magnet_arm_z",	"roll_dumbbell",	"pitch_dumbbell",	"yaw_dumbbell",	"total_accel_dumbbell",	"gyros_dumbbell_x",	"gyros_dumbbell_y",	"gyros_dumbbell_z",	"accel_dumbbell_x",	"accel_dumbbell_y",	"accel_dumbbell_z",	"magnet_dumbbell_x",	"magnet_dumbbell_y",	"magnet_dumbbell_z",	"roll_forearm",	"pitch_forearm",	"yaw_forearm",	"total_accel_forearm",	"gyros_forearm_x",	"gyros_forearm_y",	"gyros_forearm_z",	"accel_forearm_x",	"accel_forearm_y",	"accel_forearm_z",	"magnet_forearm_x",	"magnet_forearm_y",	"magnet_forearm_z",	"classe")

meastraindata <- meastraindata[, meascolumns]
```

To provide for test data against which we can evaluate the resulting model, we split the training data set into 2 partitions.


```r
nrow(meastraindata)
```

```
## [1] 19216
```

```r
inTrain <- createDataPartition(y=meastraindata$classe,p=0.75, list=FALSE)
modtrain <- meastraindata[inTrain,]
modtest <- meastraindata[-inTrain,]
nrow(modtrain)
```

```
## [1] 14414
```

#### Fitting a model

Considering that the remaining nr of variables is still substantial (large number of dimensions), we select the Random Forrest method to build a model.
From earlier experiments and knowing that Random Forrest require a lot of calculation we change the default parameters of the Random Forrest to speed up the calculation.
* the number of trees is reduced from default (500) to 50
* the number of variables to at each level is fixed in steps

In the background we also configure the R session so that advantage is taken of the dual CPU of the PC. That also is the reason why the method parRF is used.


```
## [[1]]
## [1] "foreach"   "methods"   "stats"     "graphics"  "grDevices" "utils"    
## [7] "datasets"  "base"     
## 
## [[2]]
## [1] "foreach"   "methods"   "stats"     "graphics"  "grDevices" "utils"    
## [7] "datasets"  "base"
```


```r
nrow(modtrain)
```

```
## [1] 14414
```

```r
Sys.time()
```

```
## [1] "2014-10-26 14:36:37 CET"
```

```r
#method for training cross-validation and 10-folds will be created
cvCtrl <- trainControl(method = "repeatedcv", number = 10, repeats = 10)
grid_rf <- expand.grid(.mtry = c(2, 4, 8, 16, 32, 64))
#cvCtrl <- trainControl(method = "cv", number=5, seeds=123, allowParallel = TRUE)
#modfitmeas <- train(classe ~ . , data=meastraindata, method="rf", traincontrol= cvCtrl)
modfitmeas <- train(classe ~ . , data=modtrain, method="parRF",traincontrol= cvCtrl, ntree=50, tuneGrid = grid_rf)
print(modfitmeas$finalModel)
```

```
## 
## Call:
##  randomForest(x = "x", y = "y", ntree = 25, mtry = 8, traincontrol = structure(list(     method = "repeatedcv", number = 10, repeats = 10, p = 0.75,      initialWindow = NULL, horizon = 1, fixedWindow = TRUE, verboseIter = FALSE,      returnData = TRUE, returnResamp = "final", savePredictions = FALSE,      classProbs = FALSE, summaryFunction = function (data, lev = NULL,          model = NULL)      {         if (is.character(data$obs))              data$obs <- factor(data$obs, levels = lev)         postResample(data[, "pred"], data[, "obs"])     }, selectionFunction = "best", preProcOptions = structure(list(         thresh = 0.95, ICAcomp = 3, k = 5), .Names = c("thresh",      "ICAcomp", "k")), index = NULL, indexOut = NULL, timingSamps = 0,      predictionBounds = c(FALSE, FALSE), seeds = NA, adaptive = structure(list(         min = 5, alpha = 0.05, method = "gls", complete = TRUE), .Names = c("min",      "alpha", "method", "complete")), allowParallel = TRUE), .Names = c("method",  "number", "repeats", "p", "initialWindow", "horizon", "fixedWindow",  "verboseIter", "returnData", "returnResamp", "savePredictions",  "classProbs", "summaryFunction", "selectionFunction", "preProcOptions",  "index", "indexOut", "timingSamps", "predictionBounds", "seeds",  "adaptive", "allowParallel"))) 
##                Type of random forest: classification
##                      Number of trees: 50
## No. of variables tried at each split: 8
```

```r
Sys.time()
```

```
## [1] "2014-10-26 14:49:51 CET"
```

#### Out of Sample error on testdata

To validate the obtained Random Forest model we predict with the obtained model on the test data set that was set asside.
In this test dataset both the prediction and the actuall outcome is known.

We create a function to calculate the number of correctly predicted cases.
The figure is expressed in % correct cases.


```r
modtest$pred <- predict(modfitmeas, newdata = modtest)
ftest = function(val, pred) { (sum((pred == val)*1)/length(val))*100 }
nrow(modtest)
```

```
## [1] 4802
```

```r
ftest(modtest$classe, modtest$pred)
```

```
## [1] 99.46
```

#### Conclusion

On the provided test data and using the Random Forest method it was possible to create a very accurate model to predict if the barbell lifing excercise is done correctly.
Validating the model on set aside test data, we find accurate predictions in 99.5% of the cases.

#### Predict the provided test cases for submission

The assignement provided in 20 test cases for which the outcome is unknown.
For these test cases a prediction is made and save to a seperate files for submission.


```r
answers<- predict(modfitmeas, newdata = test)
answers <- as.vector(answers)
print(answers)
```

```
##  [1] "B" "A" "B" "A" "A" "E" "D" "B" "A" "A" "B" "C" "B" "A" "E" "E" "A"
## [18] "B" "B" "B"
```

```r
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}
pml_write_files(answers)
```
