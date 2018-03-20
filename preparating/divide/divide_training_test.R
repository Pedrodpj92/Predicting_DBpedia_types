#divide_training_test.R


learning_set <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/learningSet.csv",
                              header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(learning_set) <- learning_set[1,]
learning_set <- learning_set[-1,]
learning_set[2:(ncol(learning_set)-11)] <- lapply(learning_set[,2:(ncol(learning_set)-11)], function(x) as.numeric(as.character(x)))



learning_set_ing10 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/learningSet_ingoing10.csv",
                         header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(learning_set_ing10) <- learning_set_ing10[1,]
learning_set_ing10 <- learning_set_ing10[-1,]
learning_set_ing10[2:(ncol(learning_set_ing10)-11)] <- lapply(learning_set_ing10[,2:(ncol(learning_set_ing10)-11)], function(x) as.numeric(as.character(x)))



learning_set_ing25 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/learningSet_ingoing25.csv",
                         header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(learning_set_ing25) <- learning_set_ing25[1,]
learning_set_ing25 <- learning_set_ing25[-1,]
learning_set_ing25[2:(ncol(learning_set_ing25)-11)] <- lapply(learning_set_ing25[,2:(ncol(learning_set_ing25)-11)], function(x) as.numeric(as.character(x)))


#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500

#sampling ingoing > 0
set.seed(123)#Muy importante poner siempre la misma semilla justo antes de llamadas que impliquen métodos aleatorios
reservaTest1 <- learning_set[sample(x = nrow(learning_set), size = 2500, replace = FALSE),] #replace = FALSE es valor por defecto, está a modo aclaratorio y por si en el futuro la librería cambiase
# write.csv(reservaTest1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/reservaTest1.csv", fileEncoding = "UTF-8", row.names=FALSE)

#sampling ingoing > 9
set.seed(123)
reservaTest10 <- learning_set_ing10[sample(x = nrow(learning_set_ing10), size = 2500, replace = FALSE),]
# write.csv(reservaTest10, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/reservaTest10.csv", fileEncoding = "UTF-8", row.names=FALSE)

#sampling ingoing > 24
set.seed(123)
reservaTest25 <- learning_set_ing25[sample(x = nrow(learning_set_ing25), size = 2500, replace = FALSE),]
# write.csv(reservaTest25, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/reservaTest25.csv", fileEncoding = "UTF-8", row.names=FALSE)



#reservaReal, el nivel 6 es constante, por lo que no podemos entrenar nada con ello (aunque pueda haya una cantidad suficiente). Por lo tanto, hay que eliminar del conjunto de resera
#aquellas triples de nivel 6, para ser comparable en la evaluación, porque sino tendríamos un error de base (para el recall) del 4.0% al 6.7%

#PASO DE TEST1 A TTL
test <- reservaTest1
salida_test1_n1 <- test[,c(1,ncol(test)-10)]
colnames(salida_test1_n1) <- c("s","o")
salida_test1_n2 <- test[test$Class2_Bin!="desconocido",c(1,ncol(test)-9)]
colnames(salida_test1_n2) <- c("s","o")
salida_test1_n3 <- test[test$Class3_Bin!="desconocido",c(1,ncol(test)-7)]
colnames(salida_test1_n3) <- c("s","o")
salida_test1_n4 <- test[test$Class4_Bin!="desconocido",c(1,ncol(test)-5)]
colnames(salida_test1_n4) <- c("s","o")
salida_test1_n5 <- test[test$Class5_Bin!="desconocido",c(1,ncol(test)-3)]
colnames(salida_test1_n5) <- c("s","o")
#por si en el futuro sí tuviera algo que no fuera constante y que se pudiera aprender de ello
# salida_test1_n6 <- test[test$Class6_m1!="desconocido",c(1,10)]
# colnames(salida_test1_n6) <- c("s","o")

salida_test1 <- rbind(salida_test1_n1,
                      salida_test1_n2,
                      salida_test1_n3,
                      salida_test1_n4,
                      salida_test1_n5)

# write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/reservaTest1.ttl", fileEncoding = "UTF-8", row.names=FALSE)


#PASO DE TEST10 A TTL
test <- reservaTest10
salida_test1_n1 <- test[,c(1,ncol(test)-10)]
colnames(salida_test1_n1) <- c("s","o")
salida_test1_n2 <- test[test$Class2_Bin!="desconocido",c(1,ncol(test)-9)]
colnames(salida_test1_n2) <- c("s","o")
salida_test1_n3 <- test[test$Class3_Bin!="desconocido",c(1,ncol(test)-7)]
colnames(salida_test1_n3) <- c("s","o")
salida_test1_n4 <- test[test$Class4_Bin!="desconocido",c(1,ncol(test)-5)]
colnames(salida_test1_n4) <- c("s","o")
salida_test1_n5 <- test[test$Class5_Bin!="desconocido",c(1,ncol(test)-3)]
colnames(salida_test1_n5) <- c("s","o")
#por si en el futuro sí tuviera algo que no fuera constante y que se pudiera aprender de ello
# salida_test1_n6 <- test[test$Class6_m1!="desconocido",c(1,10)]
# colnames(salida_test1_n6) <- c("s","o")

salida_test1 <- rbind(salida_test1_n1,
                      salida_test1_n2,
                      salida_test1_n3,
                      salida_test1_n4,
                      salida_test1_n5)

# write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/reservaTest10.ttl", fileEncoding = "UTF-8", row.names=FALSE)


#PASO DE TEST25 A TTL
test <- reservaTest25
salida_test1_n1 <- test[,c(1,ncol(test)-10)]
colnames(salida_test1_n1) <- c("s","o")
salida_test1_n2 <- test[test$Class2_Bin!="desconocido",c(1,ncol(test)-9)]
colnames(salida_test1_n2) <- c("s","o")
salida_test1_n3 <- test[test$Class3_Bin!="desconocido",c(1,ncol(test)-7)]
colnames(salida_test1_n3) <- c("s","o")
salida_test1_n4 <- test[test$Class4_Bin!="desconocido",c(1,ncol(test)-5)]
colnames(salida_test1_n4) <- c("s","o")
salida_test1_n5 <- test[test$Class5_Bin!="desconocido",c(1,ncol(test)-3)]
colnames(salida_test1_n5) <- c("s","o")
#por si en el futuro sí tuviera algo que no fuera constante y que se pudiera aprender de ello
# salida_test1_n6 <- test[test$Class6_m1!="desconocido",c(1,10)]
# colnames(salida_test1_n6) <- c("s","o")

salida_test1 <- rbind(salida_test1_n1,
                      salida_test1_n2,
                      salida_test1_n3,
                      salida_test1_n4,
                      salida_test1_n5)

# write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/reservaTest25.ttl", fileEncoding = "UTF-8", row.names=FALSE)



#obtención de los conjuntos de entrenamiento:

training_test1 <- learning_set[!(learning_set$s %in% reservaTest1$s),]
# write.csv(training_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/trainingTest1.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(reservaTest1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/validatingTest1.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_test10 <- learning_set[!(learning_set$s %in% reservaTest10$s),]
# write.csv(training_test10, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/trainingTest10.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(reservaTest10, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/validatingTest10.csv", fileEncoding = "UTF-8", row.names=FALSE)

training_test25 <- learning_set[!(learning_set$s %in% reservaTest25$s),]
# write.csv(training_test25, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/trainingTest25.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(reservaTest25, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/validatingTest25.csv", fileEncoding = "UTF-8", row.names=FALSE)


#TRAINING TEST1
training_test1_sinDesc_N2 <- training_test1[training_test1$Class2_Bin != 'desconocido',]
training_test1_sinDesc_N3 <- training_test1[training_test1$Class3_Bin != 'desconocido',]
training_test1_sinDesc_N4 <- training_test1[training_test1$Class4_Bin != 'desconocido',]
training_test1_sinDesc_N5 <- training_test1[training_test1$Class5_Bin != 'desconocido',]
training_test1_sinDesc_N6 <- training_test1[training_test1$Class6_Bin != 'desconocido',]
# write.csv(training_test1_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/trainingTest1_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test1_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/trainingTest1_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test1_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/trainingTest1_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test1_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/trainingTest1_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test1_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/trainingTest1_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)

#TRAINING TEST10
training_test10_sinDesc_N2 <- training_test10[training_test10$Class2_Bin != 'desconocido',]
training_test10_sinDesc_N3 <- training_test10[training_test10$Class3_Bin != 'desconocido',]
training_test10_sinDesc_N4 <- training_test10[training_test10$Class4_Bin != 'desconocido',]
training_test10_sinDesc_N5 <- training_test10[training_test10$Class5_Bin != 'desconocido',]
training_test10_sinDesc_N6 <- training_test10[training_test10$Class6_Bin != 'desconocido',]
# write.csv(training_test10_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/trainingTest10_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test10_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/trainingTest10_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test10_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/trainingTest10_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test10_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/trainingTest10_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test10_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/trainingTest10_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)

#TRAINING TEST25
training_test25_sinDesc_N2 <- training_test25[training_test25$Class2_Bin != 'desconocido',]
training_test25_sinDesc_N3 <- training_test25[training_test25$Class3_Bin != 'desconocido',]
training_test25_sinDesc_N4 <- training_test25[training_test25$Class4_Bin != 'desconocido',]
training_test25_sinDesc_N5 <- training_test25[training_test25$Class5_Bin != 'desconocido',]
training_test25_sinDesc_N6 <- training_test25[training_test25$Class6_Bin != 'desconocido',]
# write.csv(training_test25_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/trainingTest25_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test25_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/trainingTest25_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test25_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/trainingTest25_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test25_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/trainingTest25_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(training_test25_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/trainingTest25_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)



#VALIDATING TEST1
validating_test1_sinDesc_N2 <- reservaTest1[reservaTest1$Class2_Bin != 'desconocido',]
validating_test1_sinDesc_N3 <- reservaTest1[reservaTest1$Class3_Bin != 'desconocido',]
validating_test1_sinDesc_N4 <- reservaTest1[reservaTest1$Class4_Bin != 'desconocido',]
validating_test1_sinDesc_N5 <- reservaTest1[reservaTest1$Class5_Bin != 'desconocido',]
validating_test1_sinDesc_N6 <- reservaTest1[reservaTest1$Class6_Bin != 'desconocido',]
# write.csv(validating_test1_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/validatingTest1_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test1_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/validatingTest1_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test1_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/validatingTest1_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test1_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/validatingTest1_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test1_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/validatingTest1_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)

#VALIDATING TEST10
validating_test10_sinDesc_N2 <- reservaTest10[reservaTest10$Class2_Bin != 'desconocido',]
validating_test10_sinDesc_N3 <- reservaTest10[reservaTest10$Class3_Bin != 'desconocido',]
validating_test10_sinDesc_N4 <- reservaTest10[reservaTest10$Class4_Bin != 'desconocido',]
validating_test10_sinDesc_N5 <- reservaTest10[reservaTest10$Class5_Bin != 'desconocido',]
validating_test10_sinDesc_N6 <- reservaTest10[reservaTest10$Class6_Bin != 'desconocido',]
# write.csv(validating_test10_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/validatingTest10_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test10_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/validatingTest10_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test10_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/validatingTest10_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test10_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/validatingTest10_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test10_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test10/validatingTest10_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)

#VALIDATING TEST25
validating_test25_sinDesc_N2 <- reservaTest25[reservaTest25$Class2_Bin != 'desconocido',]
validating_test25_sinDesc_N3 <- reservaTest25[reservaTest25$Class3_Bin != 'desconocido',]
validating_test25_sinDesc_N4 <- reservaTest25[reservaTest25$Class4_Bin != 'desconocido',]
validating_test25_sinDesc_N5 <- reservaTest25[reservaTest25$Class5_Bin != 'desconocido',]
validating_test25_sinDesc_N6 <- reservaTest25[reservaTest25$Class6_Bin != 'desconocido',]
# write.csv(validating_test25_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/validatingTest25_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test25_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/validatingTest25_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test25_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/validatingTest25_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test25_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/validatingTest25_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
# write.csv(validating_test25_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test25/validatingTest25_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)




#para sacar conjuntos sin desconocidos sin divisiones de test1, test10 y test25
learning_set_sinDesc_N2 <- learning_set[learning_set$Class2_Bin != 'desconocido',]
learning_set_sinDesc_N3 <- learning_set[learning_set$Class3_Bin != 'desconocido',]
learning_set_sinDesc_N4 <- learning_set[learning_set$Class4_Bin != 'desconocido',]
learning_set_sinDesc_N5 <- learning_set[learning_set$Class5_Bin != 'desconocido',]
learning_set_sinDesc_N6 <- learning_set[learning_set$Class6_Bin != 'desconocido',]
write.csv(learning_set_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/learningSet_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(learning_set_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/learningSet_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(learning_set_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/learningSet_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(learning_set_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/learningSet_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)



#Para dividir por niveles y ver la distribución asociada

#test1
#nivel1 --> 2500
#nivel2 --> 2438
nrow(reservaTest1[reservaTest1$Class2_Bin != 'desconocido',])
#nivel3 --> 2120
nrow(reservaTest1[reservaTest1$Class3_Bin != 'desconocido',])
#nivel4 --> 1427
nrow(reservaTest1[reservaTest1$Class4_Bin != 'desconocido',])
#nivel5 --> 172
nrow(reservaTest1[reservaTest1$Class5_Bin != 'desconocido',])
#nivel6 --> 167
nrow(reservaTest1[reservaTest1$Class6_Bin != 'desconocido',])


#test10
#nivel1 --> 2500
#nivel2 --> 2417
nrow(reservaTest10[reservaTest10$Class2_Bin != 'desconocido',])
#nivel3 --> 2272
nrow(reservaTest10[reservaTest10$Class3_Bin != 'desconocido',])
#nivel4 --> 1980
nrow(reservaTest10[reservaTest10$Class4_Bin != 'desconocido',])
#nivel5 --> 121
nrow(reservaTest10[reservaTest10$Class5_Bin != 'desconocido',])
#nivel6 --> 119
nrow(reservaTest10[reservaTest10$Class6_Bin != 'desconocido',])


#test25
#nivel1 --> 2500
#nivel2 --> 2388
nrow(reservaTest25[reservaTest25$Class2_Bin != 'desconocido',])
#nivel3 --> 2232
nrow(reservaTest25[reservaTest25$Class3_Bin != 'desconocido',])
#nivel4 --> 1931
nrow(reservaTest25[reservaTest25$Class4_Bin != 'desconocido',])
#nivel5 --> 103
nrow(reservaTest25[reservaTest25$Class5_Bin != 'desconocido',])
#nivel6 --> 103
nrow(reservaTest25[reservaTest25$Class6_Bin != 'desconocido',])

