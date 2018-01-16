#preparaDatos_testAislados_Hojas.R

datosTraining <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/training.csv",
                            header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(datosTraining) <- datosTraining[1,]
datosTraining <- datosTraining[-1,]
datosTraining[2:(ncol(datosTraining)-1)] <- lapply(datosTraining[,2:(ncol(datosTraining)-1)], function(x) as.numeric(as.character(x)))


datosValidation <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/validating_test1_2_3.csv",
                          header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(datosValidation) <- datosValidation[1,]
datosValidation <- datosValidation[-1,]
datosValidation[2:(ncol(datosValidation)-1)] <- lapply(datosValidation[,2:(ncol(datosValidation)-1)], function(x) as.numeric(as.character(x)))


datosObjetivo <- rbind(datosTraining,datosValidation)


test1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/validating_test1.csv",
                            header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(test1) <- test1[1,]
test1 <- test1[-1,]
test1[2:(ncol(test1)-1)] <- lapply(test1[,2:(ncol(test1)-1)], function(x) as.numeric(as.character(x)))

trainingTest1 <- datosObjetivo[!(datosObjetivo$s %in% test1$s),]
validatingTest1 <- datosObjetivo[datosObjetivo$s %in% test1$s,]

write.csv(trainingTest1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest1/training.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validatingTest1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest1/validating_test1.csv", fileEncoding = "UTF-8", row.names=FALSE)



test2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/validating_test2.csv",
                            header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(test2) <- test2[1,]
test2 <- test2[-1,]
test2[2:(ncol(test2)-1)] <- lapply(test2[,2:(ncol(test2)-1)], function(x) as.numeric(as.character(x)))

trainingTest2 <- datosObjetivo[!(datosObjetivo$s %in% test2$s),]
validatingTest2 <- datosObjetivo[datosObjetivo$s %in% test2$s,]

write.csv(trainingTest2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest2/training.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validatingTest2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest2/validating_test2.csv", fileEncoding = "UTF-8", row.names=FALSE)



test3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/validating_test3.csv",
                            header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(test3) <- test3[1,]
test3 <- test3[-1,]
test3[2:(ncol(test3)-1)] <- lapply(test3[,2:(ncol(test3)-1)], function(x) as.numeric(as.character(x)))

trainingTest3 <- datosObjetivo[!(datosObjetivo$s %in% test3$s),]
validatingTest3 <- datosObjetivo[datosObjetivo$s %in% test3$s,]

write.csv(trainingTest3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest3/training.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validatingTest3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/soloTest3/validating_test3.csv", fileEncoding = "UTF-8", row.names=FALSE)




