#!/usr/bin/env Rscript
#approach2_multilevel.R



app2_C50 <- function(semilla, pathInput, pathOutput, pathOutputModel, nameOutputFile,
                     tr, vl, tr_l2, vl_l2, tr_l3, vl_l3, tr_l4, vl_l4, tr_l5, vl_l5){
  
  
  library(C50)
  
  df_training <- read.csv(file=paste(pathInput,tr,sep = ''),
                          header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(df_training) <- df_training[1,]
  df_training <- df_training[-1,]
  df_training[,c(2:(ncol(df_training)-11))] <- sapply(df_training[,c(2:(ncol(df_training)-11))], as.numeric)
  
  df_validating <- read.csv(file=paste(pathInput,vl,sep = ''),
                            header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(df_validating) <- df_validating[1,]
  df_validating <- df_validating[-1,]
  df_validating[,c(2:(ncol(df_validating)-11))] <- sapply(df_validating[,c(2:(ncol(df_validating)-11))], as.numeric)
  
  
  df_training_sinDesc_N2 <- read.csv(file=paste(pathInput,tr_l2,sep = ''),
                                     header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(df_training_sinDesc_N2) <- df_training_sinDesc_N2[1,]
  df_training_sinDesc_N2 <- df_training_sinDesc_N2[-1,]
  df_training_sinDesc_N2[,c(2:(ncol(df_training_sinDesc_N2)-11))] <- sapply(df_training_sinDesc_N2[,c(2:(ncol(df_training_sinDesc_N2)-11))], as.numeric)
  
  
  df_training_sinDesc_N3 <- read.csv(file=paste(pathInput,tr_l3,sep = ''),
                                     header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(df_training_sinDesc_N3) <- df_training_sinDesc_N3[1,]
  df_training_sinDesc_N3 <- df_training_sinDesc_N3[-1,]
  df_training_sinDesc_N3[,c(2:(ncol(df_training_sinDesc_N3)-11))] <- sapply(df_training_sinDesc_N3[,c(2:(ncol(df_training_sinDesc_N3)-11))], as.numeric)
  
  
  df_training_sinDesc_N4 <- read.csv(file=paste(pathInput,tr_l4,sep = ''),
                                     header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(df_training_sinDesc_N4) <- df_training_sinDesc_N4[1,]
  df_training_sinDesc_N4 <- df_training_sinDesc_N4[-1,]
  df_training_sinDesc_N4[,c(2:(ncol(df_training_sinDesc_N4)-11))] <- sapply(df_training_sinDesc_N4[,c(2:(ncol(df_training_sinDesc_N4)-11))], as.numeric)
  
  
  df_training_sinDesc_N5 <- read.csv(file=paste(pathInput,tr_l5,sep = ''),
                                     header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(df_training_sinDesc_N5) <- df_training_sinDesc_N5[1,]
  df_training_sinDesc_N5 <- df_training_sinDesc_N5[-1,]
  df_training_sinDesc_N5[,c(2:(ncol(df_training_sinDesc_N5)-11))] <- sapply(df_training_sinDesc_N5[,c(2:(ncol(df_training_sinDesc_N5)-11))], as.numeric)
  
  #paso a factores
  df_training[,ncol(df_training)-10] <- as.factor(df_training[,ncol(df_training)-10])
  df_training[,ncol(df_training)-9] <- as.factor(df_training[,ncol(df_training)-9])
  df_training[,ncol(df_training)-8] <- as.factor(df_training[,ncol(df_training)-8])
  df_training[,ncol(df_training)-7] <- as.factor(df_training[,ncol(df_training)-7])
  df_training[,ncol(df_training)-6] <- as.factor(df_training[,ncol(df_training)-6])
  df_training[,ncol(df_training)-5] <- as.factor(df_training[,ncol(df_training)-5])
  df_training[,ncol(df_training)-4] <- as.factor(df_training[,ncol(df_training)-4])
  df_training[,ncol(df_training)-3] <- as.factor(df_training[,ncol(df_training)-3])
  df_training[,ncol(df_training)-2] <- as.factor(df_training[,ncol(df_training)-2])
  df_training[,ncol(df_training)-1] <- as.factor(df_training[,ncol(df_training)-1])
  df_training[,ncol(df_training)] <- as.factor(df_training[,ncol(df_training)])
  
  
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-10] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-10])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-9] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-9])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-8] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-8])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-7] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-7])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-6] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-6])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-5] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-5])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-4] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-4])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-3] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-3])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-2] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-2])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-1] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-1])
  df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)] <- as.factor(df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)])
  
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-10] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-10])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-9] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-9])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-8] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-8])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-7] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-7])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-6] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-6])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-5] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-5])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-4] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-4])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-3] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-3])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-2] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-2])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-1] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-1])
  df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)] <- as.factor(df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)])
  
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-10] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-10])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-9] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-9])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-8] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-8])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-7] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-7])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-6] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-6])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-5] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-5])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-4] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-4])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-3] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-3])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-2] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-2])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-1] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-1])
  df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)] <- as.factor(df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)])
  
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-10] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-10])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-9] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-9])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-8] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-8])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-7] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-7])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-6] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-6])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-5] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-5])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-4] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-4])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-3] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-3])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-2] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-2])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-1] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-1])
  df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)] <- as.factor(df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)])
  
  c50_nivel1_v3 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-10] )
  
  #nivel 2
  c50_n2_m1 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-8] )
  c50_n2_m3 <- C50::C5.0( df_training_sinDesc_N2[,c(2:(ncol(df_training_sinDesc_N2)-11))], df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-9] )
  
  #nivel 3
  c50_n3_m1 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-6] )
  c50_n3_m3 <- C50::C5.0( df_training_sinDesc_N3[,c(2:(ncol(df_training_sinDesc_N3)-11))], df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-7] )
  
  #nivel 4
  c50_n4_m1 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-4] )
  c50_n4_m3 <- C50::C5.0( df_training_sinDesc_N4[,c(2:(ncol(df_training_sinDesc_N4)-11))], df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-5] )
  
  #nivel 5
  c50_n5_m1 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-2] )
  c50_n5_m3 <- C50::C5.0( df_training_sinDesc_N5[,c(2:(ncol(df_training_sinDesc_N5)-11))], df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-3] )
  
  
  lista_modelos <- list(c50_nivel1_v3,c50_n2_m1,c50_n2_m3,c50_n3_m1,c50_n3_m3,c50_n4_m1,c50_n4_m3,c50_n5_m1,c50_n5_m3)
  save(lista_modelos, file = paste(pathOutputModel,nameOutputFile,"_modelos_C50.RData",sep=""))
  
  #predicciones
  
  #para Test1
  test1_n1 <- predict(object = c50_nivel1_v3, newdata = df_validating[,2:(ncol(df_validating)-11)])
  test1_n2_m1 <- predict(object = c50_n2_m1, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
  test1_n2_m3 <- predict(object = c50_n2_m3, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
  test1_n3_m1 <- predict(object = c50_n3_m1, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
  test1_n3_m3 <- predict(object = c50_n3_m3, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
  test1_n4_m1 <- predict(object = c50_n4_m1, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
  test1_n4_m3 <- predict(object = c50_n4_m3, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
  test1_n5_m1 <- predict(object = c50_n5_m1, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
  test1_n5_m3 <- predict(object = c50_n5_m3, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
  
  #paso tabla unida
  test1 <- cbind(as.data.frame(df_validating[,1]),     #1
                 test1_n1,    #2
                 test1_n2_m1, #3
                 test1_n2_m3, #4
                 test1_n3_m1, #5
                 test1_n3_m3, #6
                 test1_n4_m1, #7
                 test1_n4_m3, #8
                 test1_n5_m1, #9
                 test1_n5_m3) #10
  colnames(test1) <- c("s",          #1
                       "Class1",     #2
                       "Class2_m1",  #3
                       "Class2_m3",  #4
                       "Class3_m1",  #5
                       "Class3_m3",  #6
                       "Class4_m1",  #7
                       "Class4_m3",  #8
                       "Class5_m1",  #9
                       "Class5_m3")  #10
  
  write.csv(test1, file = paste(pathOutput,nameOutputFile,"_c50.csv",sep=""), fileEncoding = "UTF-8", row.names=FALSE)
  
  salida_test1_n1 <- test1[,c(1,2)]
  colnames(salida_test1_n1) <- c("s","o")
  salida_test1_n2 <- test1[test1$Class2_m1!="desconocido",c(1,4)]
  colnames(salida_test1_n2) <- c("s","o")
  salida_test1_n3 <- test1[test1$Class3_m1!="desconocido",c(1,6)]
  colnames(salida_test1_n3) <- c("s","o")
  salida_test1_n4 <- test1[test1$Class4_m1!="desconocido",c(1,8)]
  colnames(salida_test1_n4) <- c("s","o")
  salida_test1_n5 <- test1[test1$Class5_m1!="desconocido",c(1,10)]
  colnames(salida_test1_n5) <- c("s","o")
  
  salida_test1 <- rbind(salida_test1_n1,
                        salida_test1_n2,
                        salida_test1_n3,
                        salida_test1_n4,
                        salida_test1_n5)
  
  salida_test1$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  salida_test1[,c(1,2,3)] <- salida_test1[,c(1,3,2)]
  write.table(salida_test1, file = paste(pathOutput,nameOutputFile,"_c50.ttl",sep=""),
              fileEncoding = "UTF-8", sep = " ", row.names=FALSE, col.names=FALSE)
  
  return(0)
  
}


app2_DL <- function(semilla, pathInput, pathOutput, pathOutputModel, nameOutputFile,
                    tr, vl, tr_l2, vl_l2, tr_l3, vl_l3, tr_l4, vl_l4, tr_l5, vl_l5){
  
  library(h2o)
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
  
  
  write.csv(test, file = paste(pathOutput,nameOutputFile,"_dl.csv", sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
  
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
  
  salida_test1 <- rbind(salida_test1_n1,
                        salida_test1_n2,
                        salida_test1_n3,
                        salida_test1_n4,
                        salida_test1_n5)
  
  salida_test1$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  salida_test1[,c(1,2,3)] <- salida_test1[,c(1,3,2)]
  colnames(salida_test1) <- c("s","p","o")
  salida_test1$punto <- "."
  write.table(salida_test1, file = paste(pathOutput,nameOutputFile,"_dl.ttl", sep = ''),
              fileEncoding = "UTF-8", sep = " ", row.names=FALSE, col.names=FALSE, quote = FALSE)
  
  
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
  
  
  write.csv(test_rf, file = paste(pathOutput,nameOutputFile,"_rf.csv", sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
  
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
  salida_test1_rf$punto <- "."
  write.table(salida_test1_rf, file = paste(pathOutput,nameOutputFile,"_rf.ttl", sep = ''),
            fileEncoding = "UTF-8",sep=" ", row.names=FALSE,col.names=FALSE, quote = FALSE)
  
  return(0)
}



