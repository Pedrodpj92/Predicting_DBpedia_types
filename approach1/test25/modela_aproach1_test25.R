#!/usr/bin/env Rscript
#modela_approach1_test25.R


library(h2o)
h2o.init(
  nthreads=-1            ## -1: use all available threads
  #max_mem_size = "2G"
)
#h2o.removeAll()



#carga datos escritos desde preparaDatos_SoloHojas.R
df_training_test25 <- h2o.importFile(path = normalizePath("./data/approach1/test25/training.csv"), header = TRUE)
df_validating_test25 <- h2o.importFile(path = normalizePath("./data/approach1/test25/validating_test25.csv"), header = TRUE)

train_test25 <- h2o.assign(df_training_test25, "train_test25.hex")
valid_test25 <- h2o.assign(df_validating_test25, "valid_test25.hex")

############
#naiveBayes#
############
nb_pruebaHojas_test25 <- h2o.naiveBayes(
  model_id="nb_pruebaHojas_test25",
  training_frame=train_test25, 
  validation_frame=valid_test25[,2:ncol(valid_test25)],
  x=2:(ncol(train_test25)-1),
  y=ncol(train_test25),
  seed = 1234)
h2o.saveModel(nb_pruebaHojas_test25, path="./output/models")

test25 <- h2o.predict(object = nb_pruebaHojas_test25, newdata = valid_test25[,2:(ncol(valid_test25)-1)])[1]

salida_test25 <- cbind(validating_test25[,1],as.data.frame(test25))
salida_test25$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test25[,c(1,2,3)] <- salida_test25[,c(1,3,2)]
colnames(salida_test25) <- c("s","o","p")
colnames(salida_test25) <- c("s","o")

write.csv(salida_test25, file = "./output/data/approach1/test25/test25_nb.ttl", fileEncoding = "UTF-8", row.names=FALSE)


##############
#RandomForest#
##############


rf_pruebaHojas_test25 <- h2o.randomForest(
  model_id="rf_pruebaHojas_test25",
  training_frame=train_test25, 
  validation_frame=valid_test25[,2:ncol(valid_test25)],
  x=2:(ncol(train_test25)-1),
  y=ncol(train_test25),
  ntrees = 200,
  max_depth = 120,
  stopping_rounds = 3,
  score_each_iteration = T,
  seed = 1234)
h2o.saveModel(rf_pruebaHojas_test25, path="./data/approach1/test25/")

test25 <- h2o.predict(object = rf_pruebaHojas_test25, newdata = valid_test25[,2:(ncol(valid_test25)-1)])[1]

salida_test25 <- cbind(validating_test25[,1],as.data.frame(test25))
colnames(salida_test25) <- c("s","o")
write.csv(salida_test25, file = "./output/data/approach1/test25/test25_rf.ttl", fileEncoding = "UTF-8", row.names=FALSE)



dl_pruebaHojas_test25 <- h2o.deeplearning(
  model_id="dl_pruebaHojas_test25",
  training_frame=train_test25, 
  validation_frame=valid_test25[,2:ncol(valid_test25)],
  x=2:(ncol(train_test25)-1),
  y=ncol(train_test25),
  stopping_rounds = 0,
  seed = 1234)
h2o.saveModel(dl_pruebaHojas_test25, path="./data/approach1/test25")

test25 <- h2o.predict(object = dl_pruebaHojas_test25, newdata = valid_test25[,2:(ncol(valid_test25)-1)])[1]


salida_test25 <- cbind(validating_test25[,1],as.data.frame(test25))
colnames(salida_test25) <- c("s","o")

write.csv(salida_test25, file = "./output/data/approach1/test25/test25_dl.ttl", fileEncoding = "UTF-8", row.names=FALSE)









