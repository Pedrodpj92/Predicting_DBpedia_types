#!/usr/bin/env Rscript
#approach1_GlobalApproach.R

library(h2o)

#sometimes you may have permission problems and h2o.init should be executed manually
h2o.init(
  nthreads=-1            ## -1: use all available threads
  #max_mem_size = "2G"
)
#h2o.removeAll()




#./data/approach1/test1/training.csv
#./data/approach1/test10/training.csv
#./data/approach1/test25/training.csv
df_training_test <- h2o.importFile(path = normalizePath("./data/approach1/test25/training.csv"), header = TRUE)
df_validating_test <- h2o.importFile(path = normalizePath("./data/approach1/test25/validating_test25.csv"), header = TRUE)


train_test <- h2o.assign(df_training_test, "train_test.hex")
valid_test <- h2o.assign(df_validating_test, "valid_test.hex")
#./data/approach1/test1/validating_test1.csv
#./data/approach1/test10/validating_test10.csv
#./data/approach1/test25/validating_test25.csv
validating_test <- read.csv(file="./data/approach1/test25/validating_test25.csv",
                             header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(validating_test) <- validating_test[1,]
validating_test <- validating_test[-1,]
validating_test[2:ncol(validating_test)] <- lapply(validating_test[,2:(ncol(validating_test)-1)], function(x) as.numeric(as.character(x)))



############
#naiveBayes#
############

#nb_global_Approach1_test <- h2o.naiveBayes(
#  model_id="nb_global_Approach1_test_test25",
#  training_frame=train_test, 
#  validation_frame=valid_test[,2:ncol(valid_test)],
#  x=2:(ncol(train_test)-1),
#  y=ncol(train_test),
#  seed = 1234)
#careful with model id, can't be duplicated if you running several tests, it must be changed
#h2o.saveModel(nb_global_Approach1_test, path="./output/models/approach1")


#test <- h2o.predict(object = nb_global_Approach1_test, newdata = valid_test[,2:(ncol(valid_test)-1)])[1]

#salida_test <- cbind(validating_test[,1],as.data.frame(test))
#colnames(salida_test) <- c("s","o")


#write.csv(salida_test, file = "./output/data/approach1/test25_nb.csv", fileEncoding = "UTF-8", row.names=FALSE)


###############
#Deep Learning#
###############


#dl_global_Approach1_test <- h2o.deeplearning(
#  model_id="dl_global_Approach1_test25",
#  training_frame=train_test, 
#  validation_frame=valid_test[,2:ncol(valid_test)],
#  x=2:(ncol(train_test)-1),
#  y=ncol(train_test),
#  stopping_rounds = 0,
#  seed = 1234)
#h2o.saveModel(dl_global_Approach1_test, path="./output/models/approach1")


#test <- h2o.predict(object = dl_global_Approach1_test, newdata = valid_test[,2:(ncol(valid_test)-1)])[1]

#salida_test <- cbind(validating_test[,1],as.data.frame(test))
#colnames(salida_test) <- c("s","o")

#write.csv(salida_test, file = "./output/data/approach1/test25_dl.csv", fileEncoding = "UTF-8", row.names=FALSE)




##############
#RandomForest#
##############


rf_global_Approach1_test <- h2o.randomForest(
  model_id="rf_global_Approach1_test25",
  training_frame=train_test, 
  validation_frame=valid_test[,2:ncol(valid_test)],
  x=2:(ncol(train_test)-1),
  y=ncol(train_test),
  ntrees = 200,
  max_depth = 120,
  stopping_rounds = 3,
  score_each_iteration = T,
  seed = 1234)
h2o.saveModel(rf_global_Approach1_test, path="./output/models/approach1")

test <- h2o.predict(object = rf_global_Approach1_test, newdata = valid_test[,2:(ncol(valid_test)-1)])[1]

salida_test <- cbind(validating_test[,1],as.data.frame(test))
colnames(salida_test) <- c("s","o")


write.csv(salida_test, file = "./output/data/approach1/test25_rf.csv", fileEncoding = "UTF-8", row.names=FALSE)



h2o.shutdown(prompt=FALSE)


