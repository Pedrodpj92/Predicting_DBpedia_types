#!/usr/bin/env Rscript
#modela_pruebaHojas.R


library(h2o)
#library(reshape2)
#library(randomForest)
#library(caret)
h2o.init(
  nthreads=-1            ## -1: use all available threads
  #max_mem_size = "2G"
)
#h2o.removeAll()

#327 opciones aprox.

#carga datos escritos desde preparaDatos_SoloHojas.R
df_training_test1 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest1/training.csv"), header = TRUE)
df_training_test2 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest2/training.csv"), header = TRUE)
df_training_test3 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest3/training.csv"), header = TRUE)
#df_validating <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/validating_test1_2_3.csv"), header = TRUE)
df_validating_test1 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest1/validating_test1.csv"), header = TRUE)
df_validating_test2 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest2/validating_test2.csv"), header = TRUE)
df_validating_test3 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest3/validating_test3.csv"), header = TRUE)

validating_test1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest1/validating_test1.csv",
                           header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(validating_test1) <- validating_test1[1,]
validating_test1 <- validating_test1[-1,]
validating_test1[2:ncol(validating_test1)] <- lapply(validating_test1[,2:(ncol(validating_test1)-1)], function(x) as.numeric(as.character(x)))

validating_test2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest2/validating_test2.csv",
                           header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(validating_test2) <- validating_test2[1,]
validating_test2 <- validating_test2[-1,]
validating_test2[2:ncol(validating_test2)] <- lapply(validating_test2[,2:(ncol(validating_test2)-1)], function(x) as.numeric(as.character(x)))

validating_test3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest3/validating_test3.csv",
                           header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(validating_test3) <- validating_test3[1,]
validating_test3 <- validating_test3[-1,]
validating_test3[2:ncol(validating_test3)] <- lapply(validating_test3[,2:(ncol(validating_test3)-1)], function(x) as.numeric(as.character(x)))



train_test1 <- h2o.assign(df_training_test1, "train_test1.hex")
train_test2 <- h2o.assign(df_training_test2, "train_test2.hex") 
train_test3 <- h2o.assign(df_training_test3, "train_test3.hex") 
#valid <- h2o.assign(df_validating, "valid.hex")
valid_test1 <- h2o.assign(df_validating_test1, "valid_test1.hex")
valid_test2 <- h2o.assign(df_validating_test2, "valid_test2.hex")
valid_test3 <- h2o.assign(df_validating_test3, "valid_test3.hex")



############
#naiveBayes#
############
#DESCOMENTAR CUANDO SE PRESENTE FINALMENTE

#nb_pruebaHojas_test1 <- h2o.naiveBayes(
#  model_id="nb_pruebaHojas_test1",
#  training_frame=train_test1, 
#  validation_frame=valid_test1[,2:ncol(valid_test1)],
#  x=2:(ncol(train_test1)-1),
#  y=ncol(train_test1),
#  seed = 1234)
#h2o.saveModel(nb_pruebaHojas_test1, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest1")

#nb_pruebaHojas_test2 <- h2o.naiveBayes(
#  model_id="nb_pruebaHojas_test2",
#  training_frame=train_test2, 
#  validation_frame=valid_test2[,2:ncol(valid_test2)],
#  x=2:(ncol(train_test2)-1),
#  y=ncol(train_test2),
#  seed = 1234)
#h2o.saveModel(nb_pruebaHojas_test2, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest2")

#nb_pruebaHojas_test3 <- h2o.naiveBayes(
#  model_id="nb_pruebaHojas_test3",
#  training_frame=train_test3, 
#  validation_frame=valid_test3[,2:ncol(valid_test3)],
#  x=2:(ncol(train_test3)-1),
#  y=ncol(train_test3),
#  seed = 1234)
#h2o.saveModel(nb_pruebaHojas_test3, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest3")



#test1 <- h2o.predict(object = nb_pruebaHojas_test1, newdata = valid_test1[,2:(ncol(valid_test1)-1)])[1]
#test2 <- h2o.predict(object = nb_pruebaHojas_test2, newdata = valid_test2[,2:(ncol(valid_test2)-1)])[1]
#test3 <- h2o.predict(object = nb_pruebaHojas_test3, newdata = valid_test3[,2:(ncol(valid_test3)-1)])[1]


#salida_test1 <- cbind(validating_test1[,1],as.data.frame(test1))
#salida_test1$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
#salida_test1[,c(1,2,3)] <- salida_test1[,c(1,3,2)]
#colnames(salida_test1) <- c("s","o","p")
#colnames(salida_test1) <- c("s","o")

#salida_test2 <- cbind(validating_test2[,1],as.data.frame(test2))
#salida_test2$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
#salida_test2[,c(1,2,3)] <- salida_test2[,c(1,3,2)]
#colnames(salida_test2) <- c("s","p","o")
#colnames(salida_test2) <- c("s","o")

#salida_test3 <- cbind(validating_test3[,1],as.data.frame(test3))
#salida_test3$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
#salida_test3[,c(1,2,3)] <- salida_test3[,c(1,3,2)]
#colnames(salida_test3) <- c("s","p","o")
#colnames(salida_test3) <- c("s","o")


#write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest1/test1_nb.ttl", fileEncoding = "UTF-8", row.names=FALSE)
#write.csv(salida_test2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest2/test2_nb.ttl", fileEncoding = "UTF-8", row.names=FALSE)
#write.csv(salida_test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest3/test3_nb.ttl", fileEncoding = "UTF-8", row.names=FALSE)





################################
#GBM: Gradient Boosting Machine#
################################



#gbm_pruebaHojas_default <- h2o.gbm(
#  model_id="gbm_pruebaHojas_default",
#  training_frame=train, 
#  validation_frame=valid[,2:ncol(valid)],
#  x=2:ncol(train),
#  y=ncol(train),
#  ntrees = 50,
#  max_depth = 5,
#  seed = 1234)
#h2o.saveModel(gbm_pruebaHojas, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas")


#gbm_pruebaHojas_tunning1 <- h2o.gbm(
#  model_id="gbm_pruebaHojas_tunning1",
#  training_frame=train, 
#  validation_frame=valid[,2:ncol(valid)],
#  x=2:ncol(train),
#  y=ncol(train),
#  ntrees = 200,
#  max_depth = 120,
#  seed = 1234)
#h2o.saveModel(gbm_pruebaHojas_tunning1, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas")

### default
#test1 <- h2o.predict(object = gbm_pruebaHojas_default, newdata = valid_test1[,2:(ncol(valid_test1)-1)])[1]
#test2 <- h2o.predict(object = gbm_pruebaHojas_default, newdata = valid_test2[,2:(ncol(valid_test2)-1)])[1]
#test3 <- h2o.predict(object = gbm_pruebaHojas_default, newdata = valid_test3[,2:(ncol(valid_test3)-1)])[1]

#salida_test1 <- cbind(validating_test1[,1],as.data.frame(test1))
#colnames(salida_test1) <- c("s","o")
#salida_test2 <- cbind(validating_test2[,1],as.data.frame(test2))
#colnames(salida_test2) <- c("s","o")
#salida_test3 <- cbind(validating_test3[,1],as.data.frame(test3))
#colnames(salida_test3) <- c("s","o")

#write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/test1_gbm_default.ttl", fileEncoding = "UTF-8", row.names=FALSE)
#write.csv(salida_test2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/test2_gbm_default.ttl", fileEncoding = "UTF-8", row.names=FALSE)
#write.csv(salida_test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/test3_gbm_default.ttl", fileEncoding = "UTF-8", row.names=FALSE)

### tunning1
#test1 <- h2o.predict(object = gbm_pruebaHojas_tunning1, newdata = valid_test1[,2:(ncol(valid_test1)-1)])[1]
#test2 <- h2o.predict(object = gbm_pruebaHojas_tunning1, newdata = valid_test2[,2:(ncol(valid_test2)-1)])[1]
#test3 <- h2o.predict(object = gbm_pruebaHojas_tunning1, newdata = valid_test3[,2:(ncol(valid_test3)-1)])[1]

#salida_test1 <- cbind(validating_test1[,1],as.data.frame(test1))
#colnames(salida_test1) <- c("s","o")
#salida_test2 <- cbind(validating_test2[,1],as.data.frame(test2))
#colnames(salida_test2) <- c("s","o")
#salida_test3 <- cbind(validating_test3[,1],as.data.frame(test3))
#colnames(salida_test3) <- c("s","o")

#write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/test1_gbm_tunning1.ttl", fileEncoding = "UTF-8", row.names=FALSE)
#write.csv(salida_test2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/test2_gbm_tunning1.ttl", fileEncoding = "UTF-8", row.names=FALSE)
#write.csv(salida_test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/test3_gbm_tunning1.ttl", fileEncoding = "UTF-8", row.names=FALSE)





##############
#RandomForest#
##############


#rf_pruebaHojas_test1 <- h2o.randomForest(
#  model_id="rf_pruebaHojas_test1",
#  training_frame=train_test1, 
#  validation_frame=valid_test1[,2:ncol(valid_test1)],
#  x=2:(ncol(train_test1)-1),
#  y=ncol(train_test1),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = 1234)
#h2o.saveModel(rf_pruebaHojas_test1, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest1")
rf_pruebaHojas_test1 <- h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest1/rf_pruebaHojas_test1")

rf_pruebaHojas_test2 <- h2o.randomForest(
  model_id="rf_pruebaHojas_test2",
  training_frame=train_test2, 
  validation_frame=valid_test2[,2:ncol(valid_test2)],
  x=2:(ncol(train_test2)-1),
  y=ncol(train_test2),
  ntrees = 200,
  max_depth = 120,
  stopping_rounds = 3,
  score_each_iteration = T,
  seed = 1234)
h2o.saveModel(rf_pruebaHojas_test2, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest2")

rf_pruebaHojas_test3 <- h2o.randomForest(
  model_id="rf_pruebaHojas_test3",
  training_frame=train_test1, 
  validation_frame=valid_test3[,2:ncol(valid_test3)],
  x=2:(ncol(train_test3)-1),
  y=ncol(train_test3),
  ntrees = 200,
  max_depth = 120,
  stopping_rounds = 3,
  score_each_iteration = T,
  seed = 1234)
h2o.saveModel(rf_pruebaHojas_test3, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest3")


test1 <- h2o.predict(object = rf_pruebaHojas_test1, newdata = valid_test1[,2:(ncol(valid_test1)-1)])[1]
test2 <- h2o.predict(object = rf_pruebaHojas_test2, newdata = valid_test2[,2:(ncol(valid_test2)-1)])[1]
test3 <- h2o.predict(object = rf_pruebaHojas_test3, newdata = valid_test3[,2:(ncol(valid_test3)-1)])[1]

salida_test1 <- cbind(validating_test1[,1],as.data.frame(test1))
colnames(salida_test1) <- c("s","o")
salida_test2 <- cbind(validating_test2[,1],as.data.frame(test2))
colnames(salida_test2) <- c("s","o")
salida_test3 <- cbind(validating_test3[,1],as.data.frame(test3))
colnames(salida_test3) <- c("s","o")

write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest1/test1_rf.ttl", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(salida_test2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest2/test2_rf.ttl", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(salida_test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest3/test3_rf.ttl", fileEncoding = "UTF-8", row.names=FALSE)




###############
#Deep Learning#
###############


dl_pruebaHojas_test1 <- h2o.deeplearning(
  model_id="dl_pruebaHojas_test1",
  training_frame=train_test1, 
  validation_frame=valid_test1[,2:ncol(valid_test1)],
  x=2:(ncol(train_test1)-1),
  y=ncol(train_test1),
  stopping_rounds = 0,
  seed = 1234)
h2o.saveModel(dl_pruebaHojas_test1, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest1")

dl_pruebaHojas_test2 <- h2o.deeplearning(
  model_id="dl_pruebaHojas_test2",
  training_frame=train_test2, 
  validation_frame=valid_test2[,2:ncol(valid_test2)],
  x=2:(ncol(train_test2)-1),
  y=ncol(train_test2),
  stopping_rounds = 0,
  seed = 1234)
h2o.saveModel(dl_pruebaHojas_test2, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest2")

dl_pruebaHojas_test3 <- h2o.deeplearning(
  model_id="dl_pruebaHojas_test3",
  training_frame=train_test3, 
  validation_frame=valid_test3[,2:ncol(valid_test3)],
  x=2:(ncol(train_test3)-1),
  y=ncol(train_test3),
  stopping_rounds = 0,
  seed = 1234)
h2o.saveModel(dl_pruebaHojas_test3, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/pruebaHojas/soloTest3")



test1 <- h2o.predict(object = dl_pruebaHojas_test1, newdata = valid_test1[,2:(ncol(valid_test1)-1)])[1]
test2 <- h2o.predict(object = dl_pruebaHojas_test2, newdata = valid_test2[,2:(ncol(valid_test2)-1)])[1]
test3 <- h2o.predict(object = dl_pruebaHojas_test3, newdata = valid_test3[,2:(ncol(valid_test3)-1)])[1]

salida_test1 <- cbind(validating_test1[,1],as.data.frame(test1))
colnames(salida_test1) <- c("s","o")
salida_test2 <- cbind(validating_test2[,1],as.data.frame(test2))
colnames(salida_test2) <- c("s","o")
salida_test3 <- cbind(validating_test3[,1],as.data.frame(test3))
colnames(salida_test3) <- c("s","o")

write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest1/test1_dl.ttl", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(salida_test2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest2/test2_dl.ttl", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(salida_test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest3/test3_dl.ttl", fileEncoding = "UTF-8", row.names=FALSE)








#h2o.shutdown(prompt=FALSE)




