#!/usr/bin/env Rscript
#approach2_multilevel_RFandDL_adapted.R


library(h2o)
# h2o.init(
#   nthreads=-1            ## -1: use all available threads
#   #max_mem_size = "2G"
# )

#Variables a parametrizar
#semilla
#path de datos de entrenamiento
#nombres de ficheros de entrada?
#path de datos de salida
#nombre de ficheros de salida?
#path de modelos de salida

app2_DL <- function(semilla, pathInput, pathOutput, pathOutputModel, nameOutputFile,
                    tr, vl, tr_l2, vl_l2, tr_l3, vl_l3, tr_l4, vl_l4, tr_l5, vl_l5){
  
  h2o.init(
    nthreads=-1            ## -1: use all available threads
    #max_mem_size = "2G"
  )
  df_training <- h2o.importFile(path = normalizePath(paste(pathInput,tr,sep = '')), header = TRUE)
  df_validating <- h2o.importFile(path = normalizePath(paste(pathInput,vl,sep = '')), header = TRUE)
  
  df_training_sinDesc_N2 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l2,sep = '')), header = TRUE)
  df_validating_sinDesc_N2 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l2,sep = '')), header = TRUE)
  df_training_sinDesc_N3 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l3,sep = '')), header = TRUE)
  df_validating_sinDesc_N3 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l3,sep = '')), header = TRUE)
  df_training_sinDesc_N4 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l4,sep = '')), header = TRUE)
  df_validating_sinDesc_N4 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l4,sep = '')), header = TRUE)
  df_training_sinDesc_N5 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l5,sep = '')), header = TRUE)
  df_validating_sinDesc_N5 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l5,sep = '')), header = TRUE)
  
  train <- h2o.assign(df_training, "train.hex") 
  valid <- h2o.assign(df_validating, "valid.hex")
  
  train_sinDesc_N2 <- h2o.assign(df_training_sinDesc_N2, "train_sinDesc_N2.hex") 
  valid_sinDesc_N2 <- h2o.assign(df_validating_sinDesc_N2, "valid_sinDesc_N2.hex")
  train_sinDesc_N3 <- h2o.assign(df_training_sinDesc_N3, "train_sinDesc_N3.hex") 
  valid_sinDesc_N3 <- h2o.assign(df_validating_sinDesc_N3, "valid_sinDesc_N3.hex")
  train_sinDesc_N4 <- h2o.assign(df_training_sinDesc_N4, "train_sinDesc_N4.hex") 
  valid_sinDesc_N4 <- h2o.assign(df_validating_sinDesc_N4, "valid_sinDesc_N4.hex")
  train_sinDesc_N5 <- h2o.assign(df_training_sinDesc_N5, "train_sinDesc_N5.hex") 
  valid_sinDesc_N5 <- h2o.assign(df_validating_sinDesc_N5, "valid_sinDesc_N5.hex")
  
  
  #####modelado
  ###nivel1
  dl_n1 <- h2o.deeplearning(
    model_id="dl_n1",
    training_frame=train,
    validation_frame=valid[,2:(ncol(valid)-10)],
    x=2:(ncol(train)-11),
    y=(ncol(train)-10),
    stopping_rounds = 0,
    seed = semilla)
  h2o.saveModel(dl_n1, path=pathOutputModel)
  
  
  ###Nivel 2
  dl_n2_m1 <- h2o.deeplearning(
    model_id="dl_n2_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-8))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-8),
    stopping_rounds = 0,
    seed = semilla)
  #summary(dl_n2_m1)
  h2o.saveModel(dl_n2_m1, path=pathOutputModel)
  
  dl_n2_m4 <- h2o.deeplearning(
    model_id="dl_n2_m4",
    training_frame=train_sinDesc_N2,
    validation_frame=valid_sinDesc_N2[,c(2:(ncol(valid_sinDesc_N2)-11),(ncol(valid_sinDesc_N2)-9))],
    x=2:(ncol(train_sinDesc_N2)-11),
    y=(ncol(train_sinDesc_N2)-9),
    stopping_rounds = 0,
    seed = semilla)
  #summary(dl_n2_m4)
  h2o.saveModel(dl_n2_m4, path=pathOutputModel)
  
  
  ###Nivel 3
  dl_n3_m1 <- h2o.deeplearning(
    model_id="dl_n3_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-6))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-6),
    stopping_rounds = 0,
    seed = semilla)
  #summary(dl_n3_m1)
  h2o.saveModel(dl_n3_m1, path=pathOutputModel)
  
  dl_n3_m4 <- h2o.deeplearning(
    model_id="dl_n3_m4",
    training_frame=train_sinDesc_N3,
    validation_frame=valid_sinDesc_N3[,c(2:(ncol(valid_sinDesc_N3)-11),(ncol(valid_sinDesc_N3)-7))],
    x=2:(ncol(train_sinDesc_N3)-11),
    y=(ncol(train_sinDesc_N3)-7),
    stopping_rounds = 0,
    seed = semilla)
  #summary(dl_n3_m4)
  h2o.saveModel(dl_n3_m4, path=pathOutputModel)
  
  
  ###Nivel 4
  dl_n4_m1 <- h2o.deeplearning(
    model_id="dl_n4_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-4))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-4),
    stopping_rounds = 0,
    seed = semilla)
  #summary(dl_n4_m1)
  h2o.saveModel(dl_n4_m1, path=pathOutputModel)
  
  dl_n4_m4 <- h2o.deeplearning(
    model_id="dl_n4_m4",
    training_frame=train_sinDesc_N4,
    validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-11),(ncol(valid_sinDesc_N4)-5))],
    x=2:(ncol(train_sinDesc_N4)-11),
    y=(ncol(train_sinDesc_N4)-5),
    stopping_rounds = 0,
    seed = semilla)
  #summary(dl_n4_m4)
  h2o.saveModel(dl_n4_m4, path=pathOutputModel)
  
  
  ###Nivel 5
  dl_n5_m1 <- h2o.deeplearning(
    model_id="dl_n5_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-2))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-2),
    stopping_rounds = 0,
    seed = semilla)
  #summary(dl_n5_m1)
  h2o.saveModel(dl_n5_m1, path=pathOutputModel)
  
  dl_n5_m4 <- h2o.deeplearning(
    model_id="dl_n5_m4",
    training_frame=train_sinDesc_N5,
    validation_frame=valid_sinDesc_N5[,c(2:(ncol(valid_sinDesc_N5)-11),(ncol(valid_sinDesc_N5)-3))],
    x=2:(ncol(train_sinDesc_N5)-11),
    y=(ncol(train_sinDesc_N5)-3),
    stopping_rounds = 0,
    seed = semilla)
  #summary(dl_n5_m4)
  h2o.saveModel(dl_n5_m4, path=pathOutputModel)
  
  
  validation_dl <- valid[,1:(ncol(valid)-11)]
  
  test_n1 <- h2o.predict(object = dl_n1, newdata = validation_dl[,2:(ncol(validation_dl))])
  test_n2_m4 <- h2o.predict(object = dl_n2_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  test_n2_m1 <- h2o.predict(object = dl_n2_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  test_n3_m4 <- h2o.predict(object = dl_n3_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  test_n3_m1 <- h2o.predict(object = dl_n3_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  test_n4_m4 <- h2o.predict(object = dl_n4_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  test_n4_m1 <- h2o.predict(object = dl_n4_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  test_n5_m4 <- h2o.predict(object = dl_n5_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  test_n5_m1 <- h2o.predict(object = dl_n5_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  
  
  #transform into table
  test <- cbind(as.data.frame(valid[,1]),     #1
                as.data.frame(test_n1$predict),    #2
                as.data.frame(test_n2_m1$predict), #3
                as.data.frame(test_n2_m4$predict), #4
                as.data.frame(test_n3_m1$predict), #5
                as.data.frame(test_n3_m4$predict), #6
                as.data.frame(test_n4_m1$predict), #7
                as.data.frame(test_n4_m4$predict), #8
                as.data.frame(test_n5_m1$predict), #9
                as.data.frame(test_n5_m4$predict)) #10
  colnames(test) <- c("s",          #1
                      "Class1",     #2
                      "Class2_m1",  #3
                      "Class2_m4",  #4
                      "Class3_m1",  #5
                      "Class3_m4",  #6
                      "Class4_m1",  #7
                      "Class4_m4",  #8
                      "Class5_m1",  #9
                      "Class5_m4")  #10
  
  
  # write.csv(test, file = paste(pathOutput,nameOutputFile,"_dl.csv", sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
  
  salida_test1_n1 <- test[,c(1,2)]
  colnames(salida_test1_n1) <- c("s","o")
  salida_test1_n2 <- test[test$Class2_m1!="desconocido",c(1,4)]
  colnames(salida_test1_n2) <- c("s","o")
  salida_test1_n3 <- test[test$Class3_m1!="desconocido",c(1,6)]
  colnames(salida_test1_n3) <- c("s","o")
  salida_test1_n4 <- test[test$Class4_m1!="desconocido",c(1,8)]
  colnames(salida_test1_n4) <- c("s","o")
  salida_test1_n5 <- test[test$Class5_m1!="desconocido",c(1,10)]
  colnames(salida_test1_n5) <- c("s","o")
  # salida_test1_n6 <- test[test$Class6_m1!="desconocido",c(1,10)]
  # colnames(salida_test1_n6) <- c("s","o")
  
  salida_test1 <- rbind(salida_test1_n1,
                        salida_test1_n2,
                        salida_test1_n3,
                        salida_test1_n4,
                        salida_test1_n5)
  
  salida_test1$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  salida_test1[,c(1,2,3)] <- salida_test1[,c(1,3,2)]
  # write.csv(salida_test1, file = paste(pathOutput,nameOutputFile,"_dl.ttl", sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
  
  
  return(0)
}


app2_RF <- function(semilla, pathInput, pathOutput, pathOutputModel,  nameOutputFile,
                    tr, vl, tr_l2, vl_l2, tr_l3, vl_l3, tr_l4, vl_l4, tr_l5, vl_l5){
  
  h2o.init(
    nthreads=-1            ## -1: use all available threads
    #max_mem_size = "2G"
  )
  
  df_training <- h2o.importFile(path = normalizePath(paste(pathInput,tr,sep = '')), header = TRUE)
  df_validating <- h2o.importFile(path = normalizePath(paste(pathInput,vl,sep = '')), header = TRUE)
  
  df_training_sinDesc_N2 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l2,sep = '')), header = TRUE)
  df_validating_sinDesc_N2 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l2,sep = '')), header = TRUE)
  df_training_sinDesc_N3 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l3,sep = '')), header = TRUE)
  df_validating_sinDesc_N3 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l3,sep = '')), header = TRUE)
  df_training_sinDesc_N4 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l4,sep = '')), header = TRUE)
  df_validating_sinDesc_N4 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l4,sep = '')), header = TRUE)
  df_training_sinDesc_N5 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l5,sep = '')), header = TRUE)
  df_validating_sinDesc_N5 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l5,sep = '')), header = TRUE)
  
  train <- h2o.assign(df_training, "train.hex") 
  valid <- h2o.assign(df_validating, "valid.hex")
  
  train_sinDesc_N2 <- h2o.assign(df_training_sinDesc_N2, "train_sinDesc_N2.hex") 
  valid_sinDesc_N2 <- h2o.assign(df_validating_sinDesc_N2, "valid_sinDesc_N2.hex")
  train_sinDesc_N3 <- h2o.assign(df_training_sinDesc_N3, "train_sinDesc_N3.hex") 
  valid_sinDesc_N3 <- h2o.assign(df_validating_sinDesc_N3, "valid_sinDesc_N3.hex")
  train_sinDesc_N4 <- h2o.assign(df_training_sinDesc_N4, "train_sinDesc_N4.hex") 
  valid_sinDesc_N4 <- h2o.assign(df_validating_sinDesc_N4, "valid_sinDesc_N4.hex")
  train_sinDesc_N5 <- h2o.assign(df_training_sinDesc_N5, "train_sinDesc_N5.hex") 
  valid_sinDesc_N5 <- h2o.assign(df_validating_sinDesc_N5, "valid_sinDesc_N5.hex")
  
  #####modelado
  ###Nivel1
  rf_n1 <- h2o.randomForest(
    model_id="rf_n1",
    training_frame=train,
    validation_frame=valid[,2:(ncol(valid)-10)],
    x=2:(ncol(train)-11),
    y=(ncol(train)-10),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  h2o.saveModel(rf_n1, path=pathOutputModel)
  
  
  ###Nivel 2
  rf_n2_m1 <- h2o.randomForest(
    model_id="rf_n2_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-8))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-8),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  #summary(rf_n2_m1)
  h2o.saveModel(rf_n2_m1, path=pathOutputModel)
  
  rf_n2_m4 <- h2o.randomForest(
    model_id="rf_n2_m4",
    training_frame=train_sinDesc_N2,
    validation_frame=valid_sinDesc_N2[,c(2:(ncol(valid_sinDesc_N2)-11),(ncol(valid_sinDesc_N2)-9))],
    x=2:(ncol(train_sinDesc_N2)-11),
    y=(ncol(train_sinDesc_N2)-9),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  #summary(rf_n2_m4)
  h2o.saveModel(rf_n2_m4, path=pathOutputModel)
  
  
  ###Nivel 3
  rf_n3_m1 <- h2o.randomForest(
    model_id="rf_n3_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-6))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-6),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  #summary(rf_n3_m1)
  h2o.saveModel(rf_n3_m1, path=pathOutputModel)
  
  rf_n3_m4 <- h2o.randomForest(
    model_id="rf_n3_m4",
    training_frame=train_sinDesc_N3,
    validation_frame=valid_sinDesc_N3[,c(2:(ncol(valid_sinDesc_N3)-11),(ncol(valid_sinDesc_N3)-7))],
    x=2:(ncol(train_sinDesc_N3)-11),
    y=(ncol(train_sinDesc_N3)-7),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  #summary(rf_n3_m4)
  h2o.saveModel(rf_n3_m4, path=pathOutputModel)
  
  
  ###Nivel 4
  rf_n4_m1 <- h2o.randomForest(
    model_id="rf_n4_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-4))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-4),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  #summary(rf_n4_m1)
  h2o.saveModel(rf_n4_m1, path=pathOutputModel)
  
  rf_n4_m4 <- h2o.randomForest(
    model_id="rf_n4_m4",
    training_frame=train_sinDesc_N4,
    validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-11),(ncol(valid_sinDesc_N4)-5))],
    x=2:(ncol(train_sinDesc_N4)-11),
    y=(ncol(train_sinDesc_N4)-5),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  #summary(rf_n4_m4)
  h2o.saveModel(rf_n4_m4, path=pathOutputModel)
  
  
  
  ###Nivel 5
  rf_n5_m1 <- h2o.randomForest(
    model_id="rf_n5_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-2))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-2),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  #summary(rf_n5_m1)
  h2o.saveModel(rf_n5_m1, path=pathOutputModel)
  
  rf_n5_m4 <- h2o.randomForest(
    model_id="rf_n5_m4",
    training_frame=train_sinDesc_N5,
    validation_frame=valid_sinDesc_N5[,c(2:(ncol(valid_sinDesc_N5)-11),(ncol(valid_sinDesc_N5)-3))],
    x=2:(ncol(train_sinDesc_N5)-11),
    y=(ncol(train_sinDesc_N5)-3),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  #summary(rf_n5_m4)
  h2o.saveModel(rf_n5_m4, path=pathOutputModel)
  
  
  
  validation_rf <- valid[,1:(ncol(valid)-11)]
  
  test_n1_rf <- h2o.predict(object = rf_n1, newdata = validation_rf[,2:(ncol(validation_rf))])
  test_n2_m4_rf <- h2o.predict(object = rf_n2_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  test_n2_m1_rf <- h2o.predict(object = rf_n2_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  test_n3_m4_rf <- h2o.predict(object = rf_n3_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  test_n3_m1_rf <- h2o.predict(object = rf_n3_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  test_n4_m4_rf <- h2o.predict(object = rf_n4_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  test_n4_m1_rf <- h2o.predict(object = rf_n4_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  test_n5_m4_rf <- h2o.predict(object = rf_n5_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  test_n5_m1_rf <- h2o.predict(object = rf_n5_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  
  #transform into table
  test_rf <- cbind(as.data.frame(valid[,1]),     #1
                   as.data.frame(test_n1_rf$predict),    #2
                   as.data.frame(test_n2_m1_rf$predict), #3
                   as.data.frame(test_n2_m4_rf$predict), #4
                   as.data.frame(test_n3_m1_rf$predict), #5
                   as.data.frame(test_n3_m4_rf$predict), #6
                   as.data.frame(test_n4_m1_rf$predict), #7
                   as.data.frame(test_n4_m4_rf$predict), #8
                   as.data.frame(test_n5_m1_rf$predict), #9
                   as.data.frame(test_n5_m4_rf$predict)) #10
  colnames(test_rf) <- c("s",          #1
                         "Class1",     #2
                         "Class2_m1",  #3
                         "Class2_m4",  #4
                         "Class3_m1",  #5
                         "Class3_m4",  #6
                         "Class4_m1",  #7
                         "Class4_m4",  #8
                         "Class5_m1",  #9
                         "Class5_m4")  #10
  
  
  # write.csv(test_rf, file = paste(pathOutput,nameOutputFile,"_rf.csv", sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
  
  salida_test1_n1_rf <- test_rf[,c(1,2)]
  colnames(salida_test1_n1_rf) <- c("s","o")
  salida_test1_n2_rf <- test_rf[test_rf$Class2_m1!="desconocido",c(1,4)]
  colnames(salida_test1_n2_rf) <- c("s","o")
  salida_test1_n3_rf <- test_rf[test_rf$Class3_m1!="desconocido",c(1,6)]
  colnames(salida_test1_n3_rf) <- c("s","o")
  salida_test1_n4_rf <- test_rf[test_rf$Class4_m1!="desconocido",c(1,8)]
  colnames(salida_test1_n4_rf) <- c("s","o")
  salida_test1_n5_rf <- test_rf[test_rf$Class5_m1!="desconocido",c(1,10)]
  colnames(salida_test1_n5_rf) <- c("s","o")
  
  salida_test1_rf <- rbind(salida_test1_n1_rf,
                           salida_test1_n2_rf,
                           salida_test1_n3_rf,
                           salida_test1_n4_rf,
                           salida_test1_n5_rf)
  
  salida_test1_rf$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  salida_test1_rf[,c(1,2,3)] <- salida_test1_rf[,c(1,3,2)]
  # write.csv(salida_test1_rf, file = paste(pathOutput,nameOutputFile,"_rf.ttl", sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
  
  
  
  return(0)
}

# spath1234 <- "seed1234/"
# spath2345 <- "seed2345/"
# spath3456 <- "seed3456/"
# spath4567 <- "seed4567/"
# spath5678 <- "seed5678/"
# spath6789 <- "seed6789/"
# spath7890 <- "seed7890/"
# spath1111 <- "seed1111/"
# spath3333 <- "seed3333/"
# spath5555 <- "seed5555/"

# test1 <- "test1/"
# test10 <- "test10/"
# test25 <- "test25/"

test1 <- "test1/"
test2 <- "test2/"
test3 <- "test3/"
test4 <- "test4/"
test5 <- "test5/"
# 
# # pathIn1 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/data/approaches2and3/"
# # pathOut1 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach2/changing_AlgSeed/"
# # pathOutM1 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/models/approach2/changing_AlgSeed/"
# 
# pathIn2 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/data/approaches2and3/fiveFold/"
# pathOut2 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach2/fiveFold/"
# pathOutM2 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/models/approach2/fiveFold/"
# 

pathIn1 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/data/approaches2and3/"
pathOut1 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/data/approach2/"
pathOutM1 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/models/approach2/"


pathIn2 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/data/approaches2and3/fiveFold/"
pathOut2 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/data/approach2/fiveFold/"
pathOutM2 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/models/approach2/fiveFold/"

tr1 <- "training.csv"
# vl1 <- "validating_test1.csv"
vl1 <- "validating_test.csv"
vl10 <- "validating_test10.csv"
vl25 <- "validating_test25.csv"
tr_l2_1 <- "training_knownResources_L2.csv"
vl_l2_1 <- "validating_knownResources_L2.csv"
tr_l3_1 <- "training_knownResources_L3.csv"
vl_l3_1 <- "validating_knownResources_L3.csv"
tr_l4_1 <- "training_knownResources_L4.csv"
vl_l4_1 <- "validating_knownResources_L4.csv"
tr_l5_1 <- "training_knownResources_L5.csv"
vl_l5_1 <- "validating_knownResources_L5.csv"


#GoldStandard GS2
pathInCompleto = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/v2/"
pathOutGS2 = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/comparativa_GoldStandards/GS2/"
fileOutput = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/comparativa_GoldStandards/GS2/modelosCompletosEn39/"


app2_DL(semilla =  1234,
        pathInput = pathInCompleto,
        pathOutput = pathOutGS2,
        pathOutputModel = paste(pathOutGS2,"modelosCompletosEn39/",sep = ''),
        nameOutputFile = "test_GS2",
        tr = tr1, vl = tr1,
        tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
        tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
        tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
        tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)

app2_RF(semilla =  1234,
        pathInput = pathInCompleto,
        pathOutput = pathOutGS2,
        pathOutputModel = paste(pathOutGS2,"modelosCompletosEn39/",sep = ''),
        nameOutputFile = "test_GS2",
        tr = tr1, vl = tr1,
        tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
        tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
        tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
        tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)


# semillasTodas <- c(1234,2345,3456,4567,5678,6789,7890,1111,3333,5555)
# semillasPath <- c("seed1234","seed2345","seed3456","seed4567","seed5678","seed6789","seed7890","seed1111","seed3333","seed5555")
# 
# promptHora <- " Momento acutal: "

#TEST1
# app2_DL(semilla =  1234,
#         pathInput = paste(pathIn1,test1,sep = ''),
#         pathOutput = paste(pathOut1,test1,sep = ''),
#         pathOutputModel = paste(pathOutM1,test1,sep = ''),
#         nameOutputFile = "test1",
#         tr = tr1, vl = vl1,
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# app2_RF(semilla =  1234,
#         pathInput = paste(pathIn1,test1,sep = ''),
#         pathOutput = paste(pathOut1,test1,sep = ''),
#         pathOutputModel = paste(pathOutM1,test1,sep = ''),
#         nameOutputFile = "test1",
#         tr = tr1, vl = vl1,
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)

# promptFinTest1 <- "Finalizado Test 1"
# promptFinTest1
# promptHora
# Sys.time()

#TEST10
# app2_DL(semilla =  1234,
#         pathInput = paste(pathIn1,test10,sep = ''),
#         pathOutput = paste(pathOut1,test10,sep = ''),
#         pathOutputModel = paste(pathOutM1,test10,sep = ''),
#         nameOutputFile = "test10",
#         tr = tr1, vl = vl10,
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)
# 
# 
# app2_RF(semilla =  1234,
#         pathInput = paste(pathIn1,test10,sep = ''),
#         pathOutput = paste(pathOut1,test10,sep = ''),
#         pathOutputModel = paste(pathOutM1,test10,sep = ''),
#         nameOutputFile = "test10",
#         tr = tr1, vl = vl10,
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)
# 
# promptFinTest10 <- "Finalizado Test 10"
# promptFinTest10
# promptHora
# Sys.time()

#TEST25
# app2_DL(semilla =  1234,
#         pathInput = paste(pathIn1,test25,sep = ''),
#         pathOutput = paste(pathOut1,test25,sep = ''),
#         pathOutputModel = paste(pathOutM1,test25,sep = ''),
#         nameOutputFile = "test25",
#         tr = tr1, vl = vl25,
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)
# 
# 
# app2_RF(semilla =  1234,
#         pathInput = paste(pathIn1,test25,sep = ''),
#         pathOutput = paste(pathOut1,test25,sep = ''),
#         pathOutputModel = paste(pathOutM1,test25
#                                 ,sep = ''),
#         nameOutputFile = "test25",
#         tr = tr1, vl = vl25,
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)
# 
# promptFinTest25 <- "Finalizado Test 25"
# promptFinTest25
# promptHora
# Sys.time()



# 
# test1 <- "test1/"
# test2 <- "test2/"
# test3 <- "test3/"
# test4 <- "test4/"
# test5 <- "test5/"
# 
# pathIn2 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/"
# pathOut2 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEn38Version/approach2/fiveFold/"
# pathOutM2 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/models/usingEn38Version/approach2/fiveFold/"
# 
# tr1 <- "training.csv"
# vl1 <- "validating_test.csv"
# tr_l2_1 <- "training_knownResources_L2.csv"
# vl_l2_1 <- "validating_knownResources_L2.csv"
# tr_l3_1 <- "training_knownResources_L3.csv"
# vl_l3_1 <- "validating_knownResources_L3.csv"
# tr_l4_1 <- "training_knownResources_L4.csv"
# vl_l4_1 <- "validating_knownResources_L4.csv"
# tr_l5_1 <- "training_knownResources_L5.csv"
# vl_l5_1 <- "validating_knownResources_L5.csv"


# CROSS VALIDATION
# Fold1
# app2_DL(semilla =  1234,
#         pathInput = paste(pathIn2,test1,sep = ''),
#         pathOutput = paste(pathOut2,test1,sep = ''),
#         pathOutputModel = paste(pathOutM2,test1,sep = ''),
#         nameOutputFile = "test1",
#         tr = tr1, vl = vl1,
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# app2_RF(semilla =  1234,
#         pathInput = paste(pathIn2,test1,sep = ''),
#         pathOutput = paste(pathOut2,test1,sep = ''),
#         pathOutputModel = paste(pathOutM2,test1,sep = ''),
#         nameOutputFile = "test1",
#         tr = tr1, vl = vl1,
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# Fold2
# app2_DL(semilla =  1234,
#         pathInput = paste(pathIn2,test2,sep = ''),
#         pathOutput = paste(pathOut2,test2,sep = ''),
#         pathOutputModel = paste(pathOutM2,test2,sep = ''),
#         nameOutputFile = "test2",
#         tr = tr1, vl = "validating_test2.csv",
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# app2_RF(semilla =  1234,
#         pathInput = paste(pathIn2,test2,sep = ''),
#         pathOutput = paste(pathOut2,test2,sep = ''),
#         pathOutputModel = paste(pathOutM2,test2,sep = ''),
#         nameOutputFile = "test2",
#         tr = tr1, vl = "validating_test2.csv",
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# Fold3
# app2_DL(semilla =  1234,
#         pathInput = paste(pathIn2,test3,sep = ''),
#         pathOutput = paste(pathOut2,test3,sep = ''),
#         pathOutputModel = paste(pathOutM2,test3,sep = ''),
#         nameOutputFile = "test3",
#         tr = tr1, vl = "validating_test3.csv",
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# app2_RF(semilla =  1234,
#         pathInput = paste(pathIn2,test3,sep = ''),
#         pathOutput = paste(pathOut2,test3,sep = ''),
#         pathOutputModel = paste(pathOutM2,test3,sep = ''),
#         nameOutputFile = "test3",
#         tr = tr1, vl = "validating_test3.csv",
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# Fold4
# app2_DL(semilla =  1234,
#         pathInput = paste(pathIn2,test4,sep = ''),
#         pathOutput = paste(pathOut2,test4,sep = ''),
#         pathOutputModel = paste(pathOutM2,test4,sep = ''),
#         nameOutputFile = "test4",
#         tr = tr1, vl = "validating_test4.csv",
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# app2_RF(semilla =  1234,
#         pathInput = paste(pathIn2,test4,sep = ''),
#         pathOutput = paste(pathOut2,test4,sep = ''),
#         pathOutputModel = paste(pathOutM2,test4,sep = ''),
#         nameOutputFile = "test4",
#         tr = tr1, vl = "validating_test4.csv",
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# Fold5
# app2_DL(semilla =  1234,
#         pathInput = paste(pathIn2,test5,sep = ''),
#         pathOutput = paste(pathOut2,test5,sep = ''),
#         pathOutputModel = paste(pathOutM2,test5,sep = ''),
#         nameOutputFile = "test5",
#         tr = tr1, vl = "validating_test5.csv",
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


# app2_RF(semilla =  1234,
#         pathInput = paste(pathIn2,test5,sep = ''),
#         pathOutput = paste(pathOut2,test5,sep = ''),
#         pathOutputModel = paste(pathOutM2,test5,sep = ''),
#         nameOutputFile = "test5",
#         tr = tr1, vl = "validating_test5.csv",
#         tr_l2 = tr_l2_1, vl_l2 = vl_l2_1,
#         tr_l3 = tr_l3_1, vl_l3 = vl_l3_1,
#         tr_l4 = tr_l4_1, vl_l4 = vl_l4_1,
#         tr_l5 = tr_l5_1, vl_l5 = vl_l5_1)


###CODIGO ANTIGUO

# df_training <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/trainingTest25.csv"), header = TRUE)
# df_validating <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/validatingTest25.csv"), header = TRUE)
# 
# df_training_sinDesc_N2 <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/trainingTest25_knownResources_L2.csv"), header = TRUE)
# df_validating_sinDesc_N2 <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/validatingTest25_knownResources_L2.csv"), header = TRUE)
# df_training_sinDesc_N3 <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/trainingTest25_knownResources_L3.csv"), header = TRUE)
# df_validating_sinDesc_N3 <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/validatingTest25_knownResources_L3.csv"), header = TRUE)
# df_training_sinDesc_N4 <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/trainingTest25_knownResources_L4.csv"), header = TRUE)
# df_validating_sinDesc_N4 <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/validatingTest25_knownResources_L4.csv"), header = TRUE)
# df_training_sinDesc_N5 <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/trainingTest25_knownResources_L5.csv"), header = TRUE)
# df_validating_sinDesc_N5 <- h2o.importFile(path = normalizePath("./usingEs201610Version/division2500/test25/validatingTest25_knownResources_L5.csv"), header = TRUE)
# 
# train <- h2o.assign(df_training, "train.hex") 
# valid <- h2o.assign(df_validating, "valid.hex")
# 
# train_sinDesc_N2 <- h2o.assign(df_training_sinDesc_N2, "train_sinDesc_N2.hex") 
# valid_sinDesc_N2 <- h2o.assign(df_validating_sinDesc_N2, "valid_sinDesc_N2.hex")
# train_sinDesc_N3 <- h2o.assign(df_training_sinDesc_N3, "train_sinDesc_N3.hex") 
# valid_sinDesc_N3 <- h2o.assign(df_validating_sinDesc_N3, "valid_sinDesc_N3.hex")
# train_sinDesc_N4 <- h2o.assign(df_training_sinDesc_N4, "train_sinDesc_N4.hex") 
# valid_sinDesc_N4 <- h2o.assign(df_validating_sinDesc_N4, "valid_sinDesc_N4.hex")
# train_sinDesc_N5 <- h2o.assign(df_training_sinDesc_N5, "train_sinDesc_N5.hex") 
# valid_sinDesc_N5 <- h2o.assign(df_validating_sinDesc_N5, "valid_sinDesc_N5.hex")

###############
#Deep Learning#
###############
# #####modelado
# ###nivel1
# dl_n1 <- h2o.deeplearning(
#   model_id="dl_n1",
#   training_frame=train,
#   validation_frame=valid[,2:(ncol(valid)-10)],
#   x=2:(ncol(train)-11),
#   y=(ncol(train)-10),
#   stopping_rounds = 0,
#   seed = semilla)
# h2o.saveModel(dl_n1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# ###Nivel 2
# dl_n2_m1 <- h2o.deeplearning(
#   model_id="dl_n2_m1",
#   training_frame=train,
#   validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-8))],
#   x=2:(ncol(train)-11),
#   y=(ncol(train)-8),
#   stopping_rounds = 0,
#   seed = semilla)
# #summary(dl_n2_m1)
# h2o.saveModel(dl_n2_m1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# dl_n2_m4 <- h2o.deeplearning(
#   model_id="dl_n2_m4",
#   training_frame=train_sinDesc_N2,
#   validation_frame=valid_sinDesc_N2[,c(2:(ncol(valid_sinDesc_N2)-11),(ncol(valid_sinDesc_N2)-9))],
#   x=2:(ncol(train_sinDesc_N2)-11),
#   y=(ncol(train_sinDesc_N2)-9),
#   stopping_rounds = 0,
#   seed = semilla)
# #summary(dl_n2_m4)
# h2o.saveModel(dl_n2_m4, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# ###Nivel 3
# dl_n3_m1 <- h2o.deeplearning(
#   model_id="dl_n3_m1",
#   training_frame=train,
#   validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-6))],
#   x=2:(ncol(train)-11),
#   y=(ncol(train)-6),
#   stopping_rounds = 0,
#   seed = semilla)
# #summary(dl_n3_m1)
# h2o.saveModel(dl_n3_m1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# dl_n3_m4 <- h2o.deeplearning(
#   model_id="dl_n3_m4",
#   training_frame=train_sinDesc_N3,
#   validation_frame=valid_sinDesc_N3[,c(2:(ncol(valid_sinDesc_N3)-11),(ncol(valid_sinDesc_N3)-7))],
#   x=2:(ncol(train_sinDesc_N3)-11),
#   y=(ncol(train_sinDesc_N3)-7),
#   stopping_rounds = 0,
#   seed = semilla)
# #summary(dl_n3_m4)
# h2o.saveModel(dl_n3_m4, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# ###Nivel 4
# dl_n4_m1 <- h2o.deeplearning(
#  model_id="dl_n4_m1",
#  training_frame=train,
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-4))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-4),
#  stopping_rounds = 0,
#  seed = semilla)
# #summary(dl_n4_m1)
# h2o.saveModel(dl_n4_m1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# dl_n4_m4 <- h2o.deeplearning(
#  model_id="dl_n4_m4",
#  training_frame=train_sinDesc_N4,
#  validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-11),(ncol(valid_sinDesc_N4)-5))],
#  x=2:(ncol(train_sinDesc_N4)-11),
#  y=(ncol(train_sinDesc_N4)-5),
#  stopping_rounds = 0,
#  seed = semilla)
# #summary(dl_n4_m4)
# h2o.saveModel(dl_n4_m4, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# ###Nivel 5
# dl_n5_m1 <- h2o.deeplearning(
#  model_id="dl_n5_m1",
#  training_frame=train,
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-2))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-2),
#  stopping_rounds = 0,
#  seed = semilla)
# #summary(dl_n5_m1)
# h2o.saveModel(dl_n5_m1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# dl_n5_m4 <- h2o.deeplearning(
#  model_id="dl_n5_m4",
#  training_frame=train_sinDesc_N5,
#  validation_frame=valid_sinDesc_N5[,c(2:(ncol(valid_sinDesc_N5)-11),(ncol(valid_sinDesc_N5)-3))],
#  x=2:(ncol(train_sinDesc_N5)-11),
#  y=(ncol(train_sinDesc_N5)-3),
#  stopping_rounds = 0,
#  seed = semilla)
# #summary(dl_n5_m4)
# h2o.saveModel(dl_n5_m4, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# validation_dl <- valid[,1:(ncol(valid)-11)]
# 
# test_n1 <- h2o.predict(object = dl_n1, newdata = validation_dl[,2:(ncol(validation_dl))])
# test_n2_m4 <- h2o.predict(object = dl_n2_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# test_n2_m1 <- h2o.predict(object = dl_n2_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# test_n3_m4 <- h2o.predict(object = dl_n3_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# test_n3_m1 <- h2o.predict(object = dl_n3_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# test_n4_m4 <- h2o.predict(object = dl_n4_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# test_n4_m1 <- h2o.predict(object = dl_n4_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# test_n5_m4 <- h2o.predict(object = dl_n5_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# test_n5_m1 <- h2o.predict(object = dl_n5_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# 
# 
# #transform into table
# test <- cbind(as.data.frame(valid[,1]),     #1
#                as.data.frame(test_n1$predict),    #2
#                as.data.frame(test_n2_m1$predict), #3
#                as.data.frame(test_n2_m4$predict), #4
#                as.data.frame(test_n3_m1$predict), #5
#                as.data.frame(test_n3_m4$predict), #6
#                as.data.frame(test_n4_m1$predict), #7
#                as.data.frame(test_n4_m4$predict), #8
#                as.data.frame(test_n5_m1$predict), #9
#                as.data.frame(test_n5_m4$predict)) #10
# colnames(test) <- c("s",          #1
#                      "Class1",     #2
#                      "Class2_m1",  #3
#                      "Class2_m4",  #4
#                      "Class3_m1",  #5
#                      "Class3_m4",  #6
#                      "Class4_m1",  #7
#                      "Class4_m4",  #8
#                      "Class5_m1",  #9
#                      "Class5_m4")  #10
# 
# 
# write.csv(test, file = "./output/data/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/test_seed5555_dl.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 

##############
#RandomForest#
##############

# #####modelado
# ###Nivel1
# rf_n1 <- h2o.randomForest(
#  model_id="rf_n1",
#  training_frame=train,
#  validation_frame=valid[,2:(ncol(valid)-10)],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-10),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = semilla)
# h2o.saveModel(rf_n1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# ###Nivel 2
# rf_n2_m1 <- h2o.randomForest(
#  model_id="rf_n2_m1",
#  training_frame=train,
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-8))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-8),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = semilla)
# #summary(rf_n2_m1)
# h2o.saveModel(rf_n2_m1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# rf_n2_m4 <- h2o.randomForest(
#  model_id="rf_n2_m4",
#  training_frame=train_sinDesc_N2,
#  validation_frame=valid_sinDesc_N2[,c(2:(ncol(valid_sinDesc_N2)-11),(ncol(valid_sinDesc_N2)-9))],
#  x=2:(ncol(train_sinDesc_N2)-11),
#  y=(ncol(train_sinDesc_N2)-9),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = semilla)
# #summary(rf_n2_m4)
# h2o.saveModel(rf_n2_m4, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# ###Nivel 3
# rf_n3_m1 <- h2o.randomForest(
#  model_id="rf_n3_m1",
#  training_frame=train,
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-6))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-6),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = semilla)
# #summary(rf_n3_m1)
# h2o.saveModel(rf_n3_m1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# rf_n3_m4 <- h2o.randomForest(
#  model_id="rf_n3_m4",
#  training_frame=train_sinDesc_N3,
#  validation_frame=valid_sinDesc_N3[,c(2:(ncol(valid_sinDesc_N3)-11),(ncol(valid_sinDesc_N3)-7))],
#  x=2:(ncol(train_sinDesc_N3)-11),
#  y=(ncol(train_sinDesc_N3)-7),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = semilla)
# #summary(rf_n3_m4)
# h2o.saveModel(rf_n3_m4, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# ###Nivel 4
# rf_n4_m1 <- h2o.randomForest(
#  model_id="rf_n4_m1",
#  training_frame=train,
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-4))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-4),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = semilla)
# #summary(rf_n4_m1)
# h2o.saveModel(rf_n4_m1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# rf_n4_m4 <- h2o.randomForest(
#  model_id="rf_n4_m4",
#  training_frame=train_sinDesc_N4,
#  validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-11),(ncol(valid_sinDesc_N4)-5))],
#  x=2:(ncol(train_sinDesc_N4)-11),
#  y=(ncol(train_sinDesc_N4)-5),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = semilla)
# #summary(rf_n4_m4)
# h2o.saveModel(rf_n4_m4, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# 
# ###Nivel 5
# rf_n5_m1 <- h2o.randomForest(
#  model_id="rf_n5_m1",
#  training_frame=train,
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-2))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-2),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = semilla)
# #summary(rf_n5_m1)
# h2o.saveModel(rf_n5_m1, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# rf_n5_m4 <- h2o.randomForest(
#  model_id="rf_n5_m4",
#  training_frame=train_sinDesc_N5,
#  validation_frame=valid_sinDesc_N5[,c(2:(ncol(valid_sinDesc_N5)-11),(ncol(valid_sinDesc_N5)-3))],
#  x=2:(ncol(train_sinDesc_N5)-11),
#  y=(ncol(train_sinDesc_N5)-3),
#  ntrees = 200,
#  max_depth = 120,
#  stopping_rounds = 3,
#  score_each_iteration = T,
#  seed = semilla)
# #summary(rf_n5_m4)
# h2o.saveModel(rf_n5_m4, path="./output/models/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/")
# 
# 
# 
# validation_rf <- valid[,1:(ncol(valid)-11)]
# 
# test_n1_rf <- h2o.predict(object = rf_n1, newdata = validation_rf[,2:(ncol(validation_rf))])
# test_n2_m4_rf <- h2o.predict(object = rf_n2_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
# test_n2_m1_rf <- h2o.predict(object = rf_n2_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
# test_n3_m4_rf <- h2o.predict(object = rf_n3_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
# test_n3_m1_rf <- h2o.predict(object = rf_n3_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
# test_n4_m4_rf <- h2o.predict(object = rf_n4_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
# test_n4_m1_rf <- h2o.predict(object = rf_n4_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
# test_n5_m4_rf <- h2o.predict(object = rf_n5_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
# test_n5_m1_rf <- h2o.predict(object = rf_n5_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
# 
# #transform into table
# test_rf <- cbind(as.data.frame(valid[,1]),     #1
#                   as.data.frame(test_n1_rf$predict),    #2
#                   as.data.frame(test_n2_m1_rf$predict), #3
#                   as.data.frame(test_n2_m4_rf$predict), #4
#                   as.data.frame(test_n3_m1_rf$predict), #5
#                   as.data.frame(test_n3_m4_rf$predict), #6
#                   as.data.frame(test_n4_m1_rf$predict), #7
#                   as.data.frame(test_n4_m4_rf$predict), #8
#                   as.data.frame(test_n5_m1_rf$predict), #9
#                   as.data.frame(test_n5_m4_rf$predict)) #10
# colnames(test_rf) <- c("s",          #1
#                         "Class1",     #2
#                         "Class2_m1",  #3
#                         "Class2_m4",  #4
#                         "Class3_m1",  #5
#                         "Class3_m4",  #6
#                         "Class4_m1",  #7
#                         "Class4_m4",  #8
#                         "Class5_m1",  #9
#                         "Class5_m4")  #10
# 
# 
# write.csv(test_rf, file = "./output/data/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/test_seed5555_rf.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 

# salida_test1_n1 <- test[,c(1,2)]
# colnames(salida_test1_n1) <- c("s","o")
# salida_test1_n2 <- test[test$Class2_m1!="desconocido",c(1,4)]
# colnames(salida_test1_n2) <- c("s","o")
# salida_test1_n3 <- test[test$Class3_m1!="desconocido",c(1,6)]
# colnames(salida_test1_n3) <- c("s","o")
# salida_test1_n4 <- test[test$Class4_m1!="desconocido",c(1,8)]
# colnames(salida_test1_n4) <- c("s","o")
# salida_test1_n5 <- test[test$Class5_m1!="desconocido",c(1,10)]
# colnames(salida_test1_n5) <- c("s","o")
# # salida_test1_n6 <- test[test$Class6_m1!="desconocido",c(1,10)]
# # colnames(salida_test1_n6) <- c("s","o")
# 
# salida_test1 <- rbind(salida_test1_n1,
#                       salida_test1_n2,
#                       salida_test1_n3,
#                       salida_test1_n4,
#                       salida_test1_n5)


#para random forest

# salida_test1_n1_rf <- test_rf[,c(1,2)]
# colnames(salida_test1_n1_rf) <- c("s","o")
# salida_test1_n2_rf <- test_rf[test_rf$Class2_m1!="desconocido",c(1,4)]
# colnames(salida_test1_n2_rf) <- c("s","o")
# salida_test1_n3_rf <- test_rf[test_rf$Class3_m1!="desconocido",c(1,6)]
# colnames(salida_test1_n3_rf) <- c("s","o")
# salida_test1_n4_rf <- test_rf[test_rf$Class4_m1!="desconocido",c(1,8)]
# colnames(salida_test1_n4_rf) <- c("s","o")
# salida_test1_n5_rf <- test_rf[test_rf$Class5_m1!="desconocido",c(1,10)]
# colnames(salida_test1_n5_rf) <- c("s","o")
# 
# salida_test1_rf <- rbind(salida_test1_n1_rf,
#                          salida_test1_n2_rf,
#                          salida_test1_n3_rf,
#                          salida_test1_n4_rf,
#                          salida_test1_n5_rf)


# salida_test1$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
# salida_test1[,c(1,2,3)] <- salida_test1[,c(1,3,2)]
# write.csv(salida_test1, file = "./output/data/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/test_seed5555_dl.ttl", fileEncoding = "UTF-8", row.names=FALSE)

#para random forest

# salida_test1_rf$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
# salida_test1_rf[,c(1,2,3)] <- salida_test1_rf[,c(1,3,2)]
# write.csv(salida_test1_rf, file = "./output/data/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/test_seed5555_rf.ttl", fileEncoding = "UTF-8", row.names=FALSE)
 



# h2o.shutdown(prompt=FALSE)

