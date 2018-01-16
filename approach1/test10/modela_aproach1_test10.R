#!/usr/bin/env Rscript
#modela_approach1_test10.R


library(h2o)
h2o.init(
  nthreads=-1            ## -1: use all available threads
  #max_mem_size = "2G"
)
#h2o.removeAll()



#carga datos escritos desde preparaDatos_SoloHojas.R
df_training_test10 <- h2o.importFile(path = normalizePath("./data/approach1/test10/training.csv"), header = TRUE)
df_validating_test10 <- h2o.importFile(path = normalizePath("./data/approach1/test10/validating_test1.csv"), header = TRUE)

train_test10 <- h2o.assign(df_training_test10, "train_test10.hex")
valid_test10 <- h2o.assign(df_validating_test10, "valid_test10.hex")

############
#naiveBayes#
############
nb_pruebaHojas_test10 <- h2o.naiveBayes(
  model_id="nb_pruebaHojas_test10",
  training_frame=train_test1, 
  validation_frame=valid_test10[,2:ncol(valid_test10)],
  x=2:(ncol(train_test1)-1),
  y=ncol(train_test1),
  seed = 1234)
h2o.saveModel(nb_pruebaHojas_test10, path="./output/models")

test10 <- h2o.predict(object = nb_pruebaHojas_test10, newdata = valid_test10[,2:(ncol(valid_test10)-1)])[1]

salida_test10 <- cbind(validating_test1[,1],as.data.frame(test10))
salida_test10$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test10[,c(1,2,3)] <- salida_test10[,c(1,3,2)]
colnames(salida_test10) <- c("s","o","p")
colnames(salida_test10) <- c("s","o")

write.csv(salida_test10, file = "./output/data/approach1/test1/test10_nb.ttl", fileEncoding = "UTF-8", row.names=FALSE)


##############
#RandomForest#
##############


rf_pruebaHojas_test10 <- h2o.randomForest(
  model_id="rf_pruebaHojas_test1",
  training_frame=train_test10, 
  validation_frame=valid_test10[,2:ncol(valid_test10)],
  x=2:(ncol(train_test1)-1),
  y=ncol(train_test1),
  ntrees = 200,
  max_depth = 120,
  stopping_rounds = 3,
  score_each_iteration = T,
  seed = 1234)
h2o.saveModel(rf_pruebaHojas_test1, path="./data/approach1/test1/")

test1 <- h2o.predict(object = rf_pruebaHojas_test1, newdata = valid_test10[,2:(ncol(valid_test10)-1)])[1]

salida_test1 <- cbind(validating_test10[,1],as.data.frame(test1))
colnames(salida_test1) <- c("s","o")
write.csv(salida_test1, file = "./output/data/approach1/test1/test1_rf.ttl", fileEncoding = "UTF-8", row.names=FALSE)



dl_pruebaHojas_test1 <- h2o.deeplearning(
  model_id="dl_pruebaHojas_test1",
  training_frame=train_test1, 
  validation_frame=valid_test10[,2:ncol(valid_test10)],
  x=2:(ncol(train_test1)-1),
  y=ncol(train_test1),
  stopping_rounds = 0,
  seed = 1234)
h2o.saveModel(dl_pruebaHojas_test1, path="./data/approach1/test1")

test1 <- h2o.predict(object = dl_pruebaHojas_test1, newdata = valid_test10[,2:(ncol(valid_test10)-1)])[1]


salida_test1 <- cbind(validating_test10[,1],as.data.frame(test1))
colnames(salida_test1) <- c("s","o")

write.csv(salida_test1, file = "./output/data/approach1/test1/test1_dl.ttl", fileEncoding = "UTF-8", row.names=FALSE)









