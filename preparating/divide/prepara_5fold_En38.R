#prepara_5fold_En38.R
learning_set <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/learningSet.csv",
                         header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(learning_set) <- learning_set[1,]
learning_set <- learning_set[-1,]
learning_set[2:(ncol(learning_set)-11)] <- lapply(learning_set[,2:(ncol(learning_set)-11)], function(x) as.numeric(as.character(x)))


nrow_fold <- nrow(learning_set)/5
nrow_fold <- round(nrow_fold,digits = 0)


set.seed(123)
fold1 <- learning_set[sample(x = nrow(learning_set), size = nrow_fold, replace = FALSE),]
restante <- learning_set[!(learning_set$s %in% fold1$s),]
as.data.frame(table(as.factor(fold1$Class4_Bin)))
write.csv(fold1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/fold1.csv",
          fileEncoding = "UTF-8", row.names=FALSE)

set.seed(123)
fold2 <- restante[sample(x = nrow(restante), size = nrow_fold, replace = FALSE),]
restante <- restante[!(restante$s %in% fold2$s),]
as.data.frame(table(as.factor(fold2$Class4_Bin)))
write.csv(fold2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/fold2.csv",
          fileEncoding = "UTF-8", row.names=FALSE)

set.seed(123)
fold3 <- restante[sample(x = nrow(restante), size = nrow_fold, replace = FALSE),]
restante <- restante[!(restante$s %in% fold3$s),]
as.data.frame(table(as.factor(fold3$Class4_Bin)))
write.csv(fold3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/fold3.csv",
          fileEncoding = "UTF-8", row.names=FALSE)

set.seed(123)
fold4 <- restante[sample(x = nrow(restante), size = nrow_fold, replace = FALSE),]
restante <- restante[!(restante$s %in% fold4$s),]
write.csv(fold4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/fold4.csv",
          fileEncoding = "UTF-8", row.names=FALSE)

set.seed(123)
#ya no necesitamos nrow_fold, porque es la cantidad de datos que quede, de hecho podríamos asignarlo directamente, pero esta comprobación nos permite revisar si hay errores en las cantidades
fold5 <- restante[sample(x = nrow(restante), size = nrow(restante), replace = FALSE),]
restante <- restante[!(restante$s %in% fold5$s),]
write.csv(fold5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/fold5.csv",
          fileEncoding = "UTF-8", row.names=FALSE)



######TEST 1
training1 <- rbind(fold2,fold3,fold4,fold5)
write.csv(fold1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/validating_test.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/training.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
#para sacar el archivo que luego nos ayudará a evaluar
test <- fold1
salida_test_n1 <- test[,c(1,ncol(test)-10)]
colnames(salida_test_n1) <- c("s","o")
salida_test_n2 <- test[test$Class2_Bin!="desconocido",c(1,ncol(test)-9)]
colnames(salida_test_n2) <- c("s","o")
salida_test_n3 <- test[test$Class3_Bin!="desconocido",c(1,ncol(test)-7)]
colnames(salida_test_n3) <- c("s","o")
salida_test_n4 <- test[test$Class4_Bin!="desconocido",c(1,ncol(test)-5)]
colnames(salida_test_n4) <- c("s","o")
salida_test_n5 <- test[test$Class5_Bin!="desconocido",c(1,ncol(test)-3)]
colnames(salida_test_n5) <- c("s","o")

salida_test <- rbind(salida_test_n1,
                     salida_test_n2,
                     salida_test_n3,
                     salida_test_n4,
                     salida_test_n5)
salida_test$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test[,c(1,2,3)] <- salida_test[,c(1,3,2)]
write.csv(salida_test, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/reservatest.ttl", fileEncoding = "UTF-8", row.names=FALSE)

training <- training1
training_test_sinDesc_N2 <- training[training$Class2_Bin != 'desconocido',]
training_test_sinDesc_N3 <- training[training$Class3_Bin != 'desconocido',]
training_test_sinDesc_N4 <- training[training$Class4_Bin != 'desconocido',]
training_test_sinDesc_N5 <- training[training$Class5_Bin != 'desconocido',]
training_test_sinDesc_N6 <- training[training$Class6_Bin != 'desconocido',]
write.csv(training_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/training_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/training_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/training_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/training_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/training_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)

fold <- fold1
validating_test_sinDesc_N2 <- fold[fold$Class2_Bin != 'desconocido',]
validating_test_sinDesc_N3 <- fold[fold$Class3_Bin != 'desconocido',]
validating_test_sinDesc_N4 <- fold[fold$Class4_Bin != 'desconocido',]
validating_test_sinDesc_N5 <- fold[fold$Class5_Bin != 'desconocido',]
validating_test_sinDesc_N6 <- fold[fold$Class6_Bin != 'desconocido',]
write.csv(validating_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/validating_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/validating_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/validating_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/validating_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test1/validating_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)






######TEST 2
training2 <- rbind(fold1,fold3,fold4,fold5)
write.csv(fold2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/validating_test2.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/training.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
test <- fold2
salida_test_n1 <- test[,c(1,ncol(test)-10)]
colnames(salida_test_n1) <- c("s","o")
salida_test_n2 <- test[test$Class2_Bin!="desconocido",c(1,ncol(test)-9)]
colnames(salida_test_n2) <- c("s","o")
salida_test_n3 <- test[test$Class3_Bin!="desconocido",c(1,ncol(test)-7)]
colnames(salida_test_n3) <- c("s","o")
salida_test_n4 <- test[test$Class4_Bin!="desconocido",c(1,ncol(test)-5)]
colnames(salida_test_n4) <- c("s","o")
salida_test_n5 <- test[test$Class5_Bin!="desconocido",c(1,ncol(test)-3)]
colnames(salida_test_n5) <- c("s","o")

salida_test <- rbind(salida_test_n1,
                     salida_test_n2,
                     salida_test_n3,
                     salida_test_n4,
                     salida_test_n5)
salida_test$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test[,c(1,2,3)] <- salida_test[,c(1,3,2)]
write.csv(salida_test, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/reservatest.ttl", fileEncoding = "UTF-8", row.names=FALSE)

training <- training2
training_test_sinDesc_N2 <- training[training$Class2_Bin != 'desconocido',]
training_test_sinDesc_N3 <- training[training$Class3_Bin != 'desconocido',]
training_test_sinDesc_N4 <- training[training$Class4_Bin != 'desconocido',]
training_test_sinDesc_N5 <- training[training$Class5_Bin != 'desconocido',]
training_test_sinDesc_N6 <- training[training$Class6_Bin != 'desconocido',]
write.csv(training_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/training_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/training_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/training_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/training_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/training_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)

fold <- fold2
validating_test_sinDesc_N2 <- fold[fold$Class2_Bin != 'desconocido',]
validating_test_sinDesc_N3 <- fold[fold$Class3_Bin != 'desconocido',]
validating_test_sinDesc_N4 <- fold[fold$Class4_Bin != 'desconocido',]
validating_test_sinDesc_N5 <- fold[fold$Class5_Bin != 'desconocido',]
validating_test_sinDesc_N6 <- fold[fold$Class6_Bin != 'desconocido',]
write.csv(validating_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/validating_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/validating_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/validating_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/validating_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test2/validating_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)




######TEST 3
training3 <- rbind(fold1,fold2,fold4,fold5)
write.csv(fold3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/validating_test3.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/training.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
test <- fold3
salida_test_n1 <- test[,c(1,ncol(test)-10)]
colnames(salida_test_n1) <- c("s","o")
salida_test_n2 <- test[test$Class2_Bin!="desconocido",c(1,ncol(test)-9)]
colnames(salida_test_n2) <- c("s","o")
salida_test_n3 <- test[test$Class3_Bin!="desconocido",c(1,ncol(test)-7)]
colnames(salida_test_n3) <- c("s","o")
salida_test_n4 <- test[test$Class4_Bin!="desconocido",c(1,ncol(test)-5)]
colnames(salida_test_n4) <- c("s","o")
salida_test_n5 <- test[test$Class5_Bin!="desconocido",c(1,ncol(test)-3)]
colnames(salida_test_n5) <- c("s","o")

salida_test <- rbind(salida_test_n1,
                     salida_test_n2,
                     salida_test_n3,
                     salida_test_n4,
                     salida_test_n5)
salida_test$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test[,c(1,2,3)] <- salida_test[,c(1,3,2)]
write.csv(salida_test, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/reservatest.ttl", fileEncoding = "UTF-8", row.names=FALSE)

training <- training3
training_test_sinDesc_N2 <- training[training$Class2_Bin != 'desconocido',]
training_test_sinDesc_N3 <- training[training$Class3_Bin != 'desconocido',]
training_test_sinDesc_N4 <- training[training$Class4_Bin != 'desconocido',]
training_test_sinDesc_N5 <- training[training$Class5_Bin != 'desconocido',]
training_test_sinDesc_N6 <- training[training$Class6_Bin != 'desconocido',]
write.csv(training_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/training_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/training_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/training_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/training_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/training_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)

fold <- fold3
validating_test_sinDesc_N2 <- fold[fold$Class2_Bin != 'desconocido',]
validating_test_sinDesc_N3 <- fold[fold$Class3_Bin != 'desconocido',]
validating_test_sinDesc_N4 <- fold[fold$Class4_Bin != 'desconocido',]
validating_test_sinDesc_N5 <- fold[fold$Class5_Bin != 'desconocido',]
validating_test_sinDesc_N6 <- fold[fold$Class6_Bin != 'desconocido',]
write.csv(validating_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/validating_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/validating_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/validating_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/validating_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test3/validating_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)




######TEST 4
training4 <- rbind(fold1,fold2,fold3,fold5)
write.csv(fold4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/validating_test4.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/training.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
test <- fold4
salida_test_n1 <- test[,c(1,ncol(test)-10)]
colnames(salida_test_n1) <- c("s","o")
salida_test_n2 <- test[test$Class2_Bin!="desconocido",c(1,ncol(test)-9)]
colnames(salida_test_n2) <- c("s","o")
salida_test_n3 <- test[test$Class3_Bin!="desconocido",c(1,ncol(test)-7)]
colnames(salida_test_n3) <- c("s","o")
salida_test_n4 <- test[test$Class4_Bin!="desconocido",c(1,ncol(test)-5)]
colnames(salida_test_n4) <- c("s","o")
salida_test_n5 <- test[test$Class5_Bin!="desconocido",c(1,ncol(test)-3)]
colnames(salida_test_n5) <- c("s","o")

salida_test <- rbind(salida_test_n1,
                     salida_test_n2,
                     salida_test_n3,
                     salida_test_n4,
                     salida_test_n5)
salida_test$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test[,c(1,2,3)] <- salida_test[,c(1,3,2)]
write.csv(salida_test, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/reservatest.ttl", fileEncoding = "UTF-8", row.names=FALSE)

training <- training4
training_test_sinDesc_N2 <- training[training$Class2_Bin != 'desconocido',]
training_test_sinDesc_N3 <- training[training$Class3_Bin != 'desconocido',]
training_test_sinDesc_N4 <- training[training$Class4_Bin != 'desconocido',]
training_test_sinDesc_N5 <- training[training$Class5_Bin != 'desconocido',]
training_test_sinDesc_N6 <- training[training$Class6_Bin != 'desconocido',]
write.csv(training_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/training_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/training_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/training_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/training_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/training_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)

fold <- fold4
validating_test_sinDesc_N2 <- fold[fold$Class2_Bin != 'desconocido',]
validating_test_sinDesc_N3 <- fold[fold$Class3_Bin != 'desconocido',]
validating_test_sinDesc_N4 <- fold[fold$Class4_Bin != 'desconocido',]
validating_test_sinDesc_N5 <- fold[fold$Class5_Bin != 'desconocido',]
validating_test_sinDesc_N6 <- fold[fold$Class6_Bin != 'desconocido',]
write.csv(validating_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/validating_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/validating_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/validating_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/validating_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test4/validating_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)




######TEST 5
training5 <- rbind(fold1,fold2,fold3,fold4)
write.csv(fold5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/validating_test5.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/training.csv",
          fileEncoding = "UTF-8", row.names=FALSE)
test <- fold5
salida_test_n1 <- test[,c(1,ncol(test)-10)]
colnames(salida_test_n1) <- c("s","o")
salida_test_n2 <- test[test$Class2_Bin!="desconocido",c(1,ncol(test)-9)]
colnames(salida_test_n2) <- c("s","o")
salida_test_n3 <- test[test$Class3_Bin!="desconocido",c(1,ncol(test)-7)]
colnames(salida_test_n3) <- c("s","o")
salida_test_n4 <- test[test$Class4_Bin!="desconocido",c(1,ncol(test)-5)]
colnames(salida_test_n4) <- c("s","o")
salida_test_n5 <- test[test$Class5_Bin!="desconocido",c(1,ncol(test)-3)]
colnames(salida_test_n5) <- c("s","o")

salida_test <- rbind(salida_test_n1,
                     salida_test_n2,
                     salida_test_n3,
                     salida_test_n4,
                     salida_test_n5)
salida_test$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test[,c(1,2,3)] <- salida_test[,c(1,3,2)]
write.csv(salida_test, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/reservatest.ttl", fileEncoding = "UTF-8", row.names=FALSE)

training <- training5
training_test_sinDesc_N2 <- training[training$Class2_Bin != 'desconocido',]
training_test_sinDesc_N3 <- training[training$Class3_Bin != 'desconocido',]
training_test_sinDesc_N4 <- training[training$Class4_Bin != 'desconocido',]
training_test_sinDesc_N5 <- training[training$Class5_Bin != 'desconocido',]
training_test_sinDesc_N6 <- training[training$Class6_Bin != 'desconocido',]
write.csv(training_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/training_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/training_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/training_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/training_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(training_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/training_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)

fold <- fold5
validating_test_sinDesc_N2 <- fold[fold$Class2_Bin != 'desconocido',]
validating_test_sinDesc_N3 <- fold[fold$Class3_Bin != 'desconocido',]
validating_test_sinDesc_N4 <- fold[fold$Class4_Bin != 'desconocido',]
validating_test_sinDesc_N5 <- fold[fold$Class5_Bin != 'desconocido',]
validating_test_sinDesc_N6 <- fold[fold$Class6_Bin != 'desconocido',]
write.csv(validating_test_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/validating_knownResources_L2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/validating_knownResources_L3.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/validating_knownResources_L4.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/validating_knownResources_L5.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/validating_knownResources_L6.csv", fileEncoding = "UTF-8", row.names=FALSE)



