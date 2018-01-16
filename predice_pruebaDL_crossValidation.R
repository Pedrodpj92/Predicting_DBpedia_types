#Valida.R

library(h2o)
h2o.init(
  nthreads=-1            ## -1: use all available threads
  #max_mem_size = "2G"
)
h2o.removeAll()




df_validating_test1 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test1.csv"), header = TRUE)
df_validating_test2 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test2.csv"), header = TRUE)
df_validating_test3 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test3.csv"), header = TRUE)


valid_test1 <- h2o.assign(df_validating_test1, "valid_test1.hex")
valid_test2 <- h2o.assign(df_validating_test2, "valid_test2.hex")
valid_test3 <- h2o.assign(df_validating_test3, "valid_test3.hex")

#deep learning
dl_nivel1_v1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/crossValidation/dl_nivel1_v2_cv")
dl_n2_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/crossValidation/dl_n2_m1_cv")
dl_n2_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/crossValidation/dl_n2_m4_cv")
dl_n3_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/crossValidation/dl_n3_m1_cv")
dl_n3_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/crossValidation/dl_n3_m4_cv")
dl_n4_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/crossValidation/dl_n4_m1_cv")
dl_n4_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/crossValidation/dl_n4_m4_cv")
dl_n5_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/crossValidation/dl_n5_m1_cv")
dl_n5_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/crossValidation/dl_n5_m4_cv")

#random forest
rf_nivel1_v1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/rf_nivel1_v1")
rf_n2_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/rf_n2_m1")
rf_n2_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/rf_n2_m4")
rf_n3_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/rf_n3_m1")
rf_n3_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/rf_n3_m4")
rf_n4_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/rf_n4_m1")
rf_n4_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/rf_n4_m4")
rf_n5_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/rf_n5_m1")
rf_n5_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/rf_n5_m4")

#para Test1
test1_n1 <- h2o.predict(object = dl_nivel1_v1, newdata = valid_test1[,2:(ncol(valid_test1)-11)])
test1_n2_m1 <- h2o.predict(object = dl_n2_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
test1_n2_m4 <- h2o.predict(object = dl_n2_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-10))])
test1_n3_m1 <- h2o.predict(object = dl_n3_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
test1_n3_m4 <- h2o.predict(object = dl_n3_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-8))])
test1_n4_m1 <- h2o.predict(object = dl_n4_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-6))])
test1_n4_m4 <- h2o.predict(object = dl_n4_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-6))])
test1_n5_m1 <- h2o.predict(object = dl_n5_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
test1_n5_m4 <- h2o.predict(object = dl_n5_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-4))])

test1_n1_rf <- h2o.predict(object = rf_nivel1_v1, newdata = valid_test1[,2:(ncol(valid_test1)-11)])
test1_n2_m1_rf <- h2o.predict(object = rf_n2_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
test1_n2_m4_rf <- h2o.predict(object = rf_n2_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-10))])
test1_n3_m1_rf <- h2o.predict(object = rf_n3_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
test1_n3_m4_rf <- h2o.predict(object = rf_n3_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-8))])
test1_n4_m1_rf <- h2o.predict(object = rf_n4_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-6))])
test1_n4_m4_rf <- h2o.predict(object = rf_n4_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-6))])
test1_n5_m1_rf <- h2o.predict(object = rf_n5_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
test1_n5_m4_rf <- h2o.predict(object = rf_n5_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-4))])

#para Test2
test2_n1 <- h2o.predict(object = dl_nivel1_v1, newdata = valid_test2[,2:(ncol(valid_test2)-11)])
test2_n2_m1 <- h2o.predict(object = dl_n2_m1, newdata = valid_test2[,c(2:(ncol(valid_test2)-11))])
test2_n2_m4 <- h2o.predict(object = dl_n2_m4, newdata = valid_test2[,c(2:(ncol(valid_test2)-10))])
test2_n3_m1 <- h2o.predict(object = dl_n3_m1, newdata = valid_test2[,c(2:(ncol(valid_test2)-11))])
test2_n3_m4 <- h2o.predict(object = dl_n3_m4, newdata = valid_test2[,c(2:(ncol(valid_test2)-8))])
test2_n4_m1 <- h2o.predict(object = dl_n4_m1, newdata = valid_test2[,c(2:(ncol(valid_test2)-6))])
test2_n4_m4 <- h2o.predict(object = dl_n4_m4, newdata = valid_test2[,c(2:(ncol(valid_test2)-6))])
test2_n5_m1 <- h2o.predict(object = dl_n5_m1, newdata = valid_test2[,c(2:(ncol(valid_test2)-11))])
test2_n5_m4 <- h2o.predict(object = dl_n5_m4, newdata = valid_test2[,c(2:(ncol(valid_test2)-4))])

test2_n1_rf <- h2o.predict(object = rf_nivel1_v1, newdata = valid_test2[,2:(ncol(valid_test2)-11)])
test2_n2_m1_rf <- h2o.predict(object = rf_n2_m1, newdata = valid_test2[,c(2:(ncol(valid_test2)-11))])
test2_n2_m4_rf <- h2o.predict(object = rf_n2_m4, newdata = valid_test2[,c(2:(ncol(valid_test2)-10))])
test2_n3_m1_rf <- h2o.predict(object = rf_n3_m1, newdata = valid_test2[,c(2:(ncol(valid_test2)-11))])
test2_n3_m4_rf <- h2o.predict(object = rf_n3_m4, newdata = valid_test2[,c(2:(ncol(valid_test2)-8))])
test2_n4_m1_rf <- h2o.predict(object = rf_n4_m1, newdata = valid_test2[,c(2:(ncol(valid_test2)-6))])
test2_n4_m4_rf <- h2o.predict(object = rf_n4_m4, newdata = valid_test2[,c(2:(ncol(valid_test2)-6))])
test2_n5_m1_rf <- h2o.predict(object = rf_n5_m1, newdata = valid_test2[,c(2:(ncol(valid_test2)-11))])
test2_n5_m4_rf <- h2o.predict(object = rf_n5_m4, newdata = valid_test2[,c(2:(ncol(valid_test2)-4))])


#para Test3
test3_n1 <- h2o.predict(object = dl_nivel1_v1, newdata = valid_test3[,2:(ncol(valid_test3)-11)])
test3_n2_m1 <- h2o.predict(object = dl_n2_m1, newdata = valid_test3[,c(2:(ncol(valid_test3)-11))])
test3_n2_m4 <- h2o.predict(object = dl_n2_m4, newdata = valid_test3[,c(2:(ncol(valid_test3)-10))])
test3_n3_m1 <- h2o.predict(object = dl_n3_m1, newdata = valid_test3[,c(2:(ncol(valid_test3)-11))])
test3_n3_m4 <- h2o.predict(object = dl_n3_m4, newdata = valid_test3[,c(2:(ncol(valid_test3)-8))])
test3_n4_m1 <- h2o.predict(object = dl_n4_m1, newdata = valid_test3[,c(2:(ncol(valid_test3)-6))])
test3_n4_m4 <- h2o.predict(object = dl_n4_m4, newdata = valid_test3[,c(2:(ncol(valid_test3)-6))])
test3_n5_m1 <- h2o.predict(object = dl_n5_m1, newdata = valid_test3[,c(2:(ncol(valid_test3)-11))])
test3_n5_m4 <- h2o.predict(object = dl_n5_m4, newdata = valid_test3[,c(2:(ncol(valid_test3)-4))])

test3_n1_rf <- h2o.predict(object = rf_nivel1_v1, newdata = valid_test3[,2:(ncol(valid_test3)-11)])
test3_n2_m1_rf <- h2o.predict(object = rf_n2_m1, newdata = valid_test3[,c(2:(ncol(valid_test3)-11))])
test3_n2_m4_rf <- h2o.predict(object = rf_n2_m4, newdata = valid_test3[,c(2:(ncol(valid_test3)-10))])
test3_n3_m1_rf <- h2o.predict(object = rf_n3_m1, newdata = valid_test3[,c(2:(ncol(valid_test3)-11))])
test3_n3_m4_rf <- h2o.predict(object = rf_n3_m4, newdata = valid_test3[,c(2:(ncol(valid_test3)-8))])
test3_n4_m1_rf <- h2o.predict(object = rf_n4_m1, newdata = valid_test3[,c(2:(ncol(valid_test3)-6))])
test3_n4_m4_rf <- h2o.predict(object = rf_n4_m4, newdata = valid_test3[,c(2:(ncol(valid_test3)-6))])
test3_n5_m1_rf <- h2o.predict(object = rf_n5_m1, newdata = valid_test3[,c(2:(ncol(valid_test3)-11))])
test3_n5_m4_rf <- h2o.predict(object = rf_n5_m4, newdata = valid_test3[,c(2:(ncol(valid_test3)-4))])

#paso tabla unida
test1 <- cbind(as.data.frame(valid_test1[,1]),     #1
               as.data.frame(test1_n1$predict),    #2
               as.data.frame(test1_n2_m1$predict), #3
               as.data.frame(test1_n2_m4$predict), #4
               as.data.frame(test1_n3_m1$predict), #5
               as.data.frame(test1_n3_m4$predict), #6
               as.data.frame(test1_n4_m1$predict), #7
               as.data.frame(test1_n4_m4$predict), #8
               as.data.frame(test1_n5_m1$predict), #9
               as.data.frame(test1_n5_m4$predict)) #10
colnames(test1) <- c("s",          #1
                     "Class1",     #2
                     "Class2_m1",  #3
                     "Class2_m4",  #4
                     "Class3_m1",  #5
                     "Class3_m4",  #6
                     "Class4_m1",  #7
                     "Class4_m4",  #8
                     "Class5_m1",  #9
                     "Class5_m4")  #10

test2 <- cbind(as.data.frame(valid_test2[,1]),
               as.data.frame(test2_n1$predict),
               as.data.frame(test2_n2_m1$predict),
               as.data.frame(test2_n2_m4$predict),
               as.data.frame(test2_n3_m1$predict),
               as.data.frame(test2_n3_m4$predict),
               as.data.frame(test2_n4_m1$predict),
               as.data.frame(test2_n4_m4$predict),
               as.data.frame(test2_n5_m1$predict),
               as.data.frame(test2_n5_m4$predict))
colnames(test2) <- c("s",          #1
                     "Class1",     #2
                     "Class2_m1",  #3
                     "Class2_m4",  #4
                     "Class3_m1",  #5
                     "Class3_m4",  #6
                     "Class4_m1",  #7
                     "Class4_m4",  #8
                     "Class5_m1",  #9
                     "Class5_m4")  #10

test3 <- cbind(as.data.frame(valid_test3[,1]),
               as.data.frame(test3_n1$predict),
               as.data.frame(test3_n2_m1$predict),
               as.data.frame(test3_n2_m4$predict),
               as.data.frame(test3_n3_m1$predict),
               as.data.frame(test3_n3_m4$predict),
               as.data.frame(test3_n4_m1$predict),
               as.data.frame(test3_n4_m4$predict),
               as.data.frame(test3_n5_m1$predict),
               as.data.frame(test3_n5_m4$predict))
colnames(test3) <- c("s",          #1
                     "Class1",     #2
                     "Class2_m1",  #3
                     "Class2_m4",  #4
                     "Class3_m1",  #5
                     "Class3_m4",  #6
                     "Class4_m1",  #7
                     "Class4_m4",  #8
                     "Class5_m1",  #9
                     "Class5_m4")  #10


#Random forest
test1_rf <- cbind(as.data.frame(valid_test1[,1]),     #1
               as.data.frame(test1_n1_rf$predict),    #2
               as.data.frame(test1_n2_m1_rf$predict), #3
               as.data.frame(test1_n2_m4_rf$predict), #4
               as.data.frame(test1_n3_m1_rf$predict), #5
               as.data.frame(test1_n3_m4_rf$predict), #6
               as.data.frame(test1_n4_m1_rf$predict), #7
               as.data.frame(test1_n4_m4_rf$predict), #8
               as.data.frame(test1_n5_m1_rf$predict), #9
               as.data.frame(test1_n5_m4_rf$predict)) #10
colnames(test1_rf) <- c("s",          #1
                     "Class1",     #2
                     "Class2_m1",  #3
                     "Class2_m4",  #4
                     "Class3_m1",  #5
                     "Class3_m4",  #6
                     "Class4_m1",  #7
                     "Class4_m4",  #8
                     "Class5_m1",  #9
                     "Class5_m4")  #10

test2_rf <- cbind(as.data.frame(valid_test2[,1]),
               as.data.frame(test2_n1_rf$predict),
               as.data.frame(test2_n2_m1_rf$predict),
               as.data.frame(test2_n2_m4_rf$predict),
               as.data.frame(test2_n3_m1_rf$predict),
               as.data.frame(test2_n3_m4_rf$predict),
               as.data.frame(test2_n4_m1_rf$predict),
               as.data.frame(test2_n4_m4_rf$predict),
               as.data.frame(test2_n5_m1_rf$predict),
               as.data.frame(test2_n5_m4_rf$predict))
colnames(test2_rf) <- c("s",          #1
                     "Class1",     #2
                     "Class2_m1",  #3
                     "Class2_m4",  #4
                     "Class3_m1",  #5
                     "Class3_m4",  #6
                     "Class4_m1",  #7
                     "Class4_m4",  #8
                     "Class5_m1",  #9
                     "Class5_m4")  #10

test3_rf <- cbind(as.data.frame(valid_test3[,1]),
               as.data.frame(test3_n1_rf$predict),
               as.data.frame(test3_n2_m1_rf$predict),
               as.data.frame(test3_n2_m4_rf$predict),
               as.data.frame(test3_n3_m1_rf$predict),
               as.data.frame(test3_n3_m4_rf$predict),
               as.data.frame(test3_n4_m1_rf$predict),
               as.data.frame(test3_n4_m4_rf$predict),
               as.data.frame(test3_n5_m1_rf$predict),
               as.data.frame(test3_n5_m4_rf$predict))
colnames(test3_rf) <- c("s",          #1
                     "Class1",     #2
                     "Class2_m1",  #3
                     "Class2_m4",  #4
                     "Class3_m1",  #5
                     "Class3_m4",  #6
                     "Class4_m1",  #7
                     "Class4_m4",  #8
                     "Class5_m1",  #9
                     "Class5_m4")  #10



write.csv(test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test1_modoTabla_dl_cv.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(test2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test2_modoTabla_dl_cv.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test3_modoTabla_dl_cv.csv", fileEncoding = "UTF-8", row.names=FALSE)

write.csv(test1_rf, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test1_modoTabla_rf.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(test2_rf, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test2_modoTabla_rf.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(test3_rf, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test3_modoTabla_rf.csv", fileEncoding = "UTF-8", row.names=FALSE)



#para generar el data frame que tenga par de columnas los tipos

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

salida_test2_n1 <- test2[,c(1,2)]
colnames(salida_test2_n1) <- c("s","o")
salida_test2_n2 <- test2[test2$Class2_m1!="desconocido",c(1,4)]
colnames(salida_test2_n2) <- c("s","o")
salida_test2_n3 <- test2[test2$Class3_m1!="desconocido",c(1,6)]
colnames(salida_test2_n3) <- c("s","o")
salida_test2_n4 <- test2[test2$Class4_m1!="desconocido",c(1,8)]
colnames(salida_test2_n4) <- c("s","o")
salida_test2_n5 <- test2[test2$Class5_m1!="desconocido",c(1,10)]
colnames(salida_test2_n5) <- c("s","o")

salida_test2 <- rbind(salida_test2_n1,
                      salida_test2_n2,
                      salida_test2_n3,
                      salida_test2_n4,
                      salida_test2_n5)

salida_test3_n1 <- test3[,c(1,2)]
colnames(salida_test3_n1) <- c("s","o")
salida_test3_n2 <- test3[test3$Class2_m1!="desconocido",c(1,4)]
colnames(salida_test3_n2) <- c("s","o")
salida_test3_n3 <- test3[test3$Class3_m1!="desconocido",c(1,6)]
colnames(salida_test3_n3) <- c("s","o")
salida_test3_n4 <- test3[test3$Class4_m1!="desconocido",c(1,8)]
colnames(salida_test3_n4) <- c("s","o")
salida_test3_n5 <- test3[test3$Class5_m1!="desconocido",c(1,10)]
colnames(salida_test3_n5) <- c("s","o")

salida_test3 <- rbind(salida_test3_n1,
                      salida_test3_n2,
                      salida_test3_n3,
                      salida_test3_n4,
                      salida_test3_n5)



#para random forest

salida_test1_n1_rf <- test1_rf[,c(1,2)]
colnames(salida_test1_n1_rf) <- c("s","o")
salida_test1_n2_rf <- test1_rf[test1_rf$Class2_m1!="desconocido",c(1,4)]
colnames(salida_test1_n2_rf) <- c("s","o")
salida_test1_n3_rf <- test1_rf[test1_rf$Class3_m1!="desconocido",c(1,6)]
colnames(salida_test1_n3_rf) <- c("s","o")
salida_test1_n4_rf <- test1_rf[test1_rf$Class4_m1!="desconocido",c(1,8)]
colnames(salida_test1_n4_rf) <- c("s","o")
salida_test1_n5_rf <- test1_rf[test1_rf$Class5_m1!="desconocido",c(1,10)]
colnames(salida_test1_n5_rf) <- c("s","o")

salida_test1_rf <- rbind(salida_test1_n1_rf,
                      salida_test1_n2_rf,
                      salida_test1_n3_rf,
                      salida_test1_n4_rf,
                      salida_test1_n5_rf)

salida_test2_n1_rf <- test2_rf[,c(1,2)]
colnames(salida_test2_n1_rf) <- c("s","o")
salida_test2_n2_rf <- test2_rf[test2_rf$Class2_m1!="desconocido",c(1,4)]
colnames(salida_test2_n2_rf) <- c("s","o")
salida_test2_n3_rf <- test2_rf[test2_rf$Class3_m1!="desconocido",c(1,6)]
colnames(salida_test2_n3_rf) <- c("s","o")
salida_test2_n4_rf <- test2_rf[test2_rf$Class4_m1!="desconocido",c(1,8)]
colnames(salida_test2_n4_rf) <- c("s","o")
salida_test2_n5_rf <- test2_rf[test2_rf$Class5_m1!="desconocido",c(1,10)]
colnames(salida_test2_n5_rf) <- c("s","o")

salida_test2_rf <- rbind(salida_test2_n1_rf,
                      salida_test2_n2_rf,
                      salida_test2_n3_rf,
                      salida_test2_n4_rf,
                      salida_test2_n5_rf)

salida_test3_n1_rf <- test3_rf[,c(1,2)]
colnames(salida_test3_n1_rf) <- c("s","o")
salida_test3_n2_rf <- test3_rf[test3_rf$Class2_m1!="desconocido",c(1,4)]
colnames(salida_test3_n2_rf) <- c("s","o")
salida_test3_n3_rf <- test3_rf[test3_rf$Class3_m1!="desconocido",c(1,6)]
colnames(salida_test3_n3_rf) <- c("s","o")
salida_test3_n4_rf <- test3_rf[test3_rf$Class4_m1!="desconocido",c(1,8)]
colnames(salida_test3_n4_rf) <- c("s","o")
salida_test3_n5_rf <- test3_rf[test3_rf$Class5_m1!="desconocido",c(1,10)]
colnames(salida_test3_n5_rf) <- c("s","o")

salida_test3_rf <- rbind(salida_test3_n1_rf,
                      salida_test3_n2_rf,
                      salida_test3_n3_rf,
                      salida_test3_n4_rf,
                      salida_test3_n5_rf)


#colnames(salida_test1) <- c("s","o")
#colnames(salida_test2) <- c("s","o")
#colnames(salida_test3) <- c("s","o")

salida_test1$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test1[,c(1,2,3)] <- salida_test1[,c(1,3,2)]
write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test1_cv_v1.ttl", fileEncoding = "UTF-8", row.names=FALSE)

salida_test2$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test2[,c(1,2,3)] <- salida_test2[,c(1,3,2)]
write.csv(salida_test2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test2_cv_v1.ttl", fileEncoding = "UTF-8", row.names=FALSE)

salida_test3$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test3[,c(1,2,3)] <- salida_test3[,c(1,3,2)]
write.csv(salida_test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test3_cv_v1.ttl", fileEncoding = "UTF-8", row.names=FALSE)

#para random forest

salida_test1_rf$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test1_rf[,c(1,2,3)] <- salida_test1_rf[,c(1,3,2)]
write.csv(salida_test1_rf, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test1_v1_rf.ttl", fileEncoding = "UTF-8", row.names=FALSE)

salida_test2_rf$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test2_rf[,c(1,2,3)] <- salida_test2_rf[,c(1,3,2)]
write.csv(salida_test2_rf, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test2_v1.ttl_rf", fileEncoding = "UTF-8", row.names=FALSE)

salida_test3_rf$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test3_rf[,c(1,2,3)] <- salida_test3_rf[,c(1,3,2)]
write.csv(salida_test3_rf, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/test3_v1.ttl_rf", fileEncoding = "UTF-8", row.names=FALSE)




####Comparación como en evaluaSDtypes, de momento solo teniendo encuenta lo que está dentro de la ontología de dbpedia

tiposReservados_test <- read.csv(file="/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/reservaTipos/reserva_test3_semilla123.ttl",
                                    header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
tiposReservados_test$V4 <- NULL
names(tiposReservados_test) <- c("s","p","o")
tiposReservados_test <- tiposReservados_test[-1,]
tiposReservados_test <- tiposReservados_test[grep('^<http://dbpedia.org/ontology/',tiposReservados_test$o),]


#groupby_RecursosReservados <- data.frame(table(tiposReservados_test$s))

tiposReservados_test <- tiposReservados_test[,c(1,3)]
resultados_test <- salida_test3[,c(1,3)]

aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]
aciertos_test <- merge(x = aciertos_recursos_test, y = tiposReservados_test, by = "s", all.x = TRUE)
aciertos_test <- aciertos_test[aciertos_test$o.x == aciertos_test$o.y,]

#groupby_Recursos_acertados <- data.frame(table(aciertos_recursos_test$s))

aciertos_test <- aciertos_test[,c(1,2)]
names(aciertos_test) <- c("s","o")

metrica_precision <- nrow(aciertos_test)/nrow(aciertos_recursos_test)*100
metrica_recall <- nrow(aciertos_test)/nrow(tiposReservados_test)*100
metrica_Fmeasure <- 2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall))


















h2o.shutdown(prompt=FALSE)
