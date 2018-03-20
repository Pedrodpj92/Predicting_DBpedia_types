#preparaDatos_testAislados.R


#############################################
#####################TEST 3##################
#############################################

datosObjetivo <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/learingSet.csv",
                           header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(datosObjetivo) <- datosObjetivo[1,]
datosObjetivo <- datosObjetivo[-1,]
datosObjetivo[2:(ncol(datosObjetivo)-11)] <- lapply(datosObjetivo[,2:(ncol(datosObjetivo)-11)], function(x) as.numeric(as.character(x)))



datosReservados_test3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/reserva_test3_semilla123.ttl",
                                  header=TRUE, sep=",", encoding = "UTF-8")#, stringsAsFactors = FALSE)

training <- datosObjetivo[!(datosObjetivo$s %in% datosReservados_test3$s),]
validating <- datosObjetivo[datosObjetivo$s %in% datosReservados_test3$s,]

write.csv(training, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/training.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/validating_test3.csv", fileEncoding = "UTF-8", row.names=FALSE)




training_sinDesc_N2 <- training[training$Class2 != "desconocido",]
write.csv(training_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/training_sinDesc_N2.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N2 <- validating[validating$Class2 != "desconocido",]
write.csv(validating_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/validating_sinDesc_N2.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N3 <- training[training$Class3 != "desconocido",]
write.csv(training_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/training_sinDesc_N3.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N3 <- validating[validating$Class3 != "desconocido",]
write.csv(validating_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/validating_sinDesc_N3.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N4 <- training[training$Class4 != "desconocido",]
write.csv(training_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/training_sinDesc_N4.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N4 <- validating[validating$Class4 != "desconocido",]
write.csv(validating_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/validating_sinDesc_N4.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N5 <- training[training$Class5 != "desconocido",]
write.csv(training_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/training_sinDesc_N5.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N5 <- validating[validating$Class5 != "desconocido",]
write.csv(validating_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/validating_sinDesc_N5.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N6 <- training[training$Class6 != "desconocido",]
write.csv(training_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/training_sinDesc_N6.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N6 <- validating[validating$Class6 != "desconocido",]
write.csv(validating_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest3/validating_sinDesc_N6.csv", fileEncoding = "UTF-8", row.names=FALSE)




#############################################
#####################TEST 2##################
#############################################

datosObjetivo <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/learingSet.csv",
                          header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(datosObjetivo) <- datosObjetivo[1,]
datosObjetivo <- datosObjetivo[-1,]
datosObjetivo[2:(ncol(datosObjetivo)-11)] <- lapply(datosObjetivo[,2:(ncol(datosObjetivo)-11)], function(x) as.numeric(as.character(x)))



datosReservados_test2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/reserva_test2_semilla123.ttl",
                                  header=TRUE, sep=",", encoding = "UTF-8")#, stringsAsFactors = FALSE)

training <- datosObjetivo[!(datosObjetivo$s %in% datosReservados_test2$s),]
validating <- datosObjetivo[datosObjetivo$s %in% datosReservados_test2$s,]

write.csv(training, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/training.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/validating_test2.csv", fileEncoding = "UTF-8", row.names=FALSE)




training_sinDesc_N2 <- training[training$Class2 != "desconocido",]
write.csv(training_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/training_sinDesc_N2.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N2 <- validating[validating$Class2 != "desconocido",]
write.csv(validating_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/validating_sinDesc_N2.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N3 <- training[training$Class3 != "desconocido",]
write.csv(training_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/training_sinDesc_N3.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N3 <- validating[validating$Class3 != "desconocido",]
write.csv(validating_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/validating_sinDesc_N3.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N4 <- training[training$Class4 != "desconocido",]
write.csv(training_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/training_sinDesc_N4.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N4 <- validating[validating$Class4 != "desconocido",]
write.csv(validating_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/validating_sinDesc_N4.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N5 <- training[training$Class5 != "desconocido",]
write.csv(training_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/training_sinDesc_N5.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N5 <- validating[validating$Class5 != "desconocido",]
write.csv(validating_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/validating_sinDesc_N5.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N6 <- training[training$Class6 != "desconocido",]
write.csv(training_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/training_sinDesc_N6.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N6 <- validating[validating$Class6 != "desconocido",]
write.csv(validating_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest2/validating_sinDesc_N6.csv", fileEncoding = "UTF-8", row.names=FALSE)





#############################################
#####################TEST 1##################
#############################################

datosObjetivo <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/learingSet.csv",
                          header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(datosObjetivo) <- datosObjetivo[1,]
datosObjetivo <- datosObjetivo[-1,]
datosObjetivo[2:(ncol(datosObjetivo)-11)] <- lapply(datosObjetivo[,2:(ncol(datosObjetivo)-11)], function(x) as.numeric(as.character(x)))



datosReservados_test1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/reserva_test1_semilla123.ttl",
                                  header=TRUE, sep=",", encoding = "UTF-8")#, stringsAsFactors = FALSE)

training <- datosObjetivo[!(datosObjetivo$s %in% datosReservados_test1$s),]
validating <- datosObjetivo[datosObjetivo$s %in% datosReservados_test1$s,]

write.csv(training, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/validating_test1.csv", fileEncoding = "UTF-8", row.names=FALSE)




training_sinDesc_N2 <- training[training$Class2 != "desconocido",]
write.csv(training_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training_sinDesc_N2.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N2 <- validating[validating$Class2 != "desconocido",]
write.csv(validating_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/validating_sinDesc_N2.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N3 <- training[training$Class3 != "desconocido",]
write.csv(training_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training_sinDesc_N3.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N3 <- validating[validating$Class3 != "desconocido",]
write.csv(validating_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/validating_sinDesc_N3.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N4 <- training[training$Class4 != "desconocido",]
write.csv(training_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training_sinDesc_N4.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N4 <- validating[validating$Class4 != "desconocido",]
write.csv(validating_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/validating_sinDesc_N4.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N5 <- training[training$Class5 != "desconocido",]
write.csv(training_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training_sinDesc_N5.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N5 <- validating[validating$Class5 != "desconocido",]
write.csv(validating_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/validating_sinDesc_N5.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_sinDesc_N6 <- training[training$Class6 != "desconocido",]
write.csv(training_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training_sinDesc_N6.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_sinDesc_N6 <- validating[validating$Class6 != "desconocido",]
write.csv(validating_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/validating_sinDesc_N6.csv", fileEncoding = "UTF-8", row.names=FALSE)



