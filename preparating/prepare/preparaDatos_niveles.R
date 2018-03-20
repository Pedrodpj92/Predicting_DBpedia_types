#preparaDatos_niveles.R



archivos_entradaModelo <- function(pathEntrada, pathSalida, tieneTipos, esTraining){
  learning_set <- read.csv(file=pathEntrada,
                           header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(learning_set) <- learning_set[1,]
  learning_set <- learning_set[-1,]
  if(tieneTipos)
    learning_set[2:(ncol(learning_set)-11)] <- lapply(learning_set[,2:(ncol(learning_set)-11)], function(x) as.numeric(as.character(x)))
  else
    learning_set[2:(ncol(learning_set))] <- lapply(learning_set[,2:(ncol(learning_set))], function(x) as.numeric(as.character(x)))
  
  if(esTraining){
    write.csv(learning_set, file = paste(pathSalida,"training.csv",sep = ''),
              fileEncoding = "UTF-8", row.names=FALSE)
  }
  else{
    write.csv(learning_set, file = paste(pathSalida,"validating_test.csv",sep = ''),
              fileEncoding = "UTF-8", row.names=FALSE)
  }

  training <- learning_set
  training_test_sinDesc_N2 <- training[training$Class2_Bin != 'desconocido',]
  training_test_sinDesc_N3 <- training[training$Class3_Bin != 'desconocido',]
  training_test_sinDesc_N4 <- training[training$Class4_Bin != 'desconocido',]
  training_test_sinDesc_N5 <- training[training$Class5_Bin != 'desconocido',]
  training_test_sinDesc_N6 <- training[training$Class6_Bin != 'desconocido',]
  
  if(esTraining){
    write.csv(training_test_sinDesc_N2, file = paste(pathSalida, "training_knownResources_L2.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
    write.csv(training_test_sinDesc_N3, file = paste(pathSalida, "training_knownResources_L3.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
    write.csv(training_test_sinDesc_N4, file = paste(pathSalida, "training_knownResources_L4.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
    write.csv(training_test_sinDesc_N5, file = paste(pathSalida, "training_knownResources_L5.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
    write.csv(training_test_sinDesc_N6, file = paste(pathSalida, "training_knownResources_L6.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
  }
  else{
    write.csv(training_test_sinDesc_N2, file = paste(pathSalida, "validating_knownResources_L2.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
    write.csv(training_test_sinDesc_N3, file = paste(pathSalida, "validating_knownResources_L3.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
    write.csv(training_test_sinDesc_N4, file = paste(pathSalida, "validating_knownResources_L4.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
    write.csv(training_test_sinDesc_N5, file = paste(pathSalida, "validating_knownResources_L5.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
    write.csv(training_test_sinDesc_N6, file = paste(pathSalida, "validating_knownResources_L6.csv",sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
    
  }
  
}


pathIn1 = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/v2/learningSet.csv"
pathIn2 ="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/comparativa_GoldStandards/GS2/gs2_properties_matrix.csv"

pathOut1 = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/v2/"
pathOut2 = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/comparativa_GoldStandards/GS2/"

archivos_entradaModelo(pathEntrada = pathIn1, pathSalida = pathOut1, tieneTipos = TRUE, esTraining = TRUE)
archivos_entradaModelo(pathEntrada = pathIn2, pathSalida = pathOut2, tieneTipos = FALSE, esTraining = FALSE)


