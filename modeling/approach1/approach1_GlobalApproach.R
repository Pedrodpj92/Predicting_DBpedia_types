#!/usr/bin/env Rscript
#approach1_GlobalApproach.R



app1_nb <- function(semilla, pathInput, pathOutput, pathOutputModel, nameOutputFile,
                    tr, vl){
  library(h2o)
  h2o.init(
    nthreads=-1            ## -1: use all available threads
    #max_mem_size = "2G"
  )
  df_training_test <- h2o.importFile(path = normalizePath(paste(pathInput,tr,sep = '')), header = TRUE)
  df_validating_test <- h2o.importFile(path = normalizePath(paste(pathInput,vl,sep = '')), header = TRUE)
  
  
  train_test <- h2o.assign(df_training_test, "train_test.hex")
  valid_test <- h2o.assign(df_validating_test, "valid_test.hex")
  
  
  validating_test <- read.csv(file=paste(pathInput,vl,sep = ''),
                              header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(validating_test) <- validating_test[1,]
  validating_test <- validating_test[-1,]
  validating_test[2:ncol(validating_test)] <- lapply(validating_test[,2:(ncol(validating_test)-1)], function(x) as.numeric(as.character(x)))
  
  
  nb_global_Approach1_test <- h2o.naiveBayes(
    model_id=paste("app1_nb_model_",nameOutputFile,sep=''),
    training_frame=train_test, 
    validation_frame=valid_test[,2:ncol(valid_test)],
    x=2:(ncol(train_test)-1),
    y=ncol(train_test),
    seed = semilla)
  h2o.saveModel(nb_global_Approach1_test, path=pathOutputModel)
  
  
  test <- h2o.predict(object = nb_global_Approach1_test, newdata = valid_test[,2:(ncol(valid_test)-1)])[1]
  
  salida_test <- cbind(validating_test[,1],as.data.frame(test))
  salida_test$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  salida_test[,c(1,2,3)] <- salida_test[,c(1,3,2)]
  colnames(salida_test) <- c("s","p","o")
  salida_test$punto <- "."
  write.table(salida_test, file = paste(pathOutput,nameOutputFile,"_nb.ttl",sep=''),
              fileEncoding = "UTF-8", sep = " ", row.names=FALSE, col.names = FALSE, quote = FALSE)
  
  return(0)
  
  
}



app1_dl <- function(semilla, pathInput, pathOutput, pathOutputModel, nameOutputFile,
                    tr, vl){
  library(h2o)
  h2o.init(
    nthreads=-1            ## -1: use all available threads
    #max_mem_size = "2G"
  )
  df_training_test <- h2o.importFile(path = normalizePath(paste(pathInput,tr,sep = '')), header = TRUE)
  df_validating_test <- h2o.importFile(path = normalizePath(paste(pathInput,vl,sep = '')), header = TRUE)
  
  
  train_test <- h2o.assign(df_training_test, "train_test.hex")
  valid_test <- h2o.assign(df_validating_test, "valid_test.hex")
  
  
  validating_test <- read.csv(file=paste(pathInput,vl,sep = ''),
                              header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(validating_test) <- validating_test[1,]
  validating_test <- validating_test[-1,]
  validating_test[2:ncol(validating_test)] <- lapply(validating_test[,2:(ncol(validating_test)-1)], function(x) as.numeric(as.character(x)))
  
  dl_global_Approach1_test <- h2o.deeplearning(
    model_id=paste("app1_dl_model_",nameOutputFile,sep=''),
    training_frame=train_test, 
    validation_frame=valid_test[,2:ncol(valid_test)],
    x=2:(ncol(train_test)-1),
    y=ncol(train_test),
    stopping_rounds = 0,
    seed = semilla)
  h2o.saveModel(dl_global_Approach1_test, path=pathOutputModel)
  
  test <- h2o.predict(object = dl_global_Approach1_test, newdata = valid_test[,2:(ncol(valid_test)-1)])[1]
  
  salida_test <- cbind(validating_test[,1],as.data.frame(test))
  salida_test$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  salida_test[,c(1,2,3)] <- salida_test[,c(1,3,2)]
  colnames(salida_test) <- c("s","p","o")
  salida_test$punto <- "."
  write.table(salida_test, file = paste(pathOutput,nameOutputFile,"_dl.ttl",sep=''),
              fileEncoding = "UTF-8", sep = " ", row.names=FALSE, col.names = FALSE, quote = FALSE)
  
  return(0)
  
}


app1_rf <- function(semilla, pathInput, pathOutput, pathOutputModel, nameOutputFile,
                    tr, vl){
  library(h2o)
  h2o.init(
    nthreads=-1            ## -1: use all available threads
    #max_mem_size = "2G"
  )
  df_training_test <- h2o.importFile(path = normalizePath(paste(pathInput,tr,sep = '')), header = TRUE)
  df_validating_test <- h2o.importFile(path = normalizePath(paste(pathInput,vl,sep = '')), header = TRUE)
  
  
  train_test <- h2o.assign(df_training_test, "train_test.hex")
  valid_test <- h2o.assign(df_validating_test, "valid_test.hex")
  
  
  validating_test <- read.csv(file=paste(pathInput,vl,sep = ''),
                              header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(validating_test) <- validating_test[1,]
  validating_test <- validating_test[-1,]
  validating_test[2:ncol(validating_test)] <- lapply(validating_test[,2:(ncol(validating_test)-1)], function(x) as.numeric(as.character(x)))
  
  rf_global_Approach1_test <- h2o.randomForest(
    model_id=paste("app1_rf_model_",nameOutputFile,sep=''),
    training_frame=train_test, 
    validation_frame=valid_test[,2:ncol(valid_test)],
    x=2:(ncol(train_test)-1),
    y=ncol(train_test),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = semilla)
  h2o.saveModel(rf_global_Approach1_test, path=pathOutputModel)
  
  test <- h2o.predict(object = rf_global_Approach1_test, newdata = valid_test[,2:(ncol(valid_test)-1)])[1]
  
  salida_test <- cbind(validating_test[,1],as.data.frame(test))
  salida_test$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  salida_test[,c(1,2,3)] <- salida_test[,c(1,3,2)]
  colnames(salida_test) <- c("s","p","o")
  salida_test$punto <- "."
  write.table(salida_test, file = paste(pathOutput,nameOutputFile,"_rf.ttl",sep=''),
              fileEncoding = "UTF-8", sep = " ", row.names=FALSE, col.names = FALSE, quote = FALSE)
  
  return(0)
  
}

