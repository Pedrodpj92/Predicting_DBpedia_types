#!/usr/bin/env Rscript
#predice_approach2_RF_DL.R

library(h2o)
h2o.init(
  nthreads=-1            ## -1: use all available threads
  #max_mem_size = "2G"
)

# learning_set <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/learningSet.csv",
#                          header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
# colnames(learning_set) <- learning_set[1,]
# learning_set <- learning_set[-1,]
# learning_set[2:(ncol(learning_set)-11)] <- lapply(learning_set[,2:(ncol(learning_set)-11)], function(x) as.numeric(as.character(x)))
# 
# 
# 
# objects_properties_Matrix <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/objects_properties_Matrix.csv",
#                          header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
# colnames(objects_properties_Matrix) <- objects_properties_Matrix[1,]
# objects_properties_Matrix <- objects_properties_Matrix[-1,]
# objects_properties_Matrix[2:(ncol(objects_properties_Matrix))] <- lapply(objects_properties_Matrix[,2:(ncol(objects_properties_Matrix))], function(x) as.numeric(as.character(x)))
# 
# 
# objetos_sinTipo <- objects_properties_Matrix[!(objects_properties_Matrix$o %in% learning_set$s),]  
# 
# write.csv(objetos_sinTipo, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/object_properties_withoutTypes_Matrix.csv", fileEncoding = "UTF-8", row.names=FALSE)

df_validating_test1 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/object_properties_withoutTypes_Matrix.csv"), header = TRUE)
valid_test1 <- h2o.assign(df_validating_test1, "valid_test1.hex")
valid <- valid_test1

#deep learning
dl_n1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/dl_n1")
dl_n2_m1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/dl_n2_m1")
dl_n2_m4 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/dl_n2_m4")
dl_n3_m1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/dl_n3_m1")
dl_n3_m4 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/dl_n3_m4")
dl_n4_m1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/dl_n4_m1")
dl_n4_m4 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/dl_n4_m4")
dl_n5_m1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/dl_n5_m1")
dl_n5_m4 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/dl_n5_m4")

#random forest
rf_n1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/rf_n1")
rf_n2_m1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/rf_n2_m1")
rf_n2_m4 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/rf_n2_m4")
rf_n3_m1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/rf_n3_m1")
rf_n3_m4 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/rf_n3_m4")
rf_n4_m1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/rf_n4_m1")
rf_n4_m4 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/rf_n4_m4")
rf_n5_m1 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/rf_n5_m1")
rf_n5_m4 = h2o.loadModel(path = "./output/models/usingEsDBpedia201610/approach2/modelosFinales/rf_n5_m4")


validation_dl <- valid[,1:(ncol(valid))]

test_n1 <- h2o.predict(object = dl_n1, newdata = validation_dl[,2:(ncol(validation_dl))])
test_n2_m4 <- h2o.predict(object = dl_n2_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
test_n2_m1 <- h2o.predict(object = dl_n2_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
test_n3_m4 <- h2o.predict(object = dl_n3_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
test_n3_m1 <- h2o.predict(object = dl_n3_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
test_n4_m4 <- h2o.predict(object = dl_n4_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
test_n4_m1 <- h2o.predict(object = dl_n4_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
test_n5_m4 <- h2o.predict(object = dl_n5_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
test_n5_m1 <- h2o.predict(object = dl_n5_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# test_n6_m4 <- h2o.predict(object = dl_n6_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
# test_n6_m1 <- h2o.predict(object = dl_n6_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)))])

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


write.csv(test, file = "./output/data/usingEsDBpedia201610/approach2/newTypes_dl_v1.csv", fileEncoding = "UTF-8", row.names=FALSE)


validation_rf <- valid[,1:(ncol(valid))]

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


write.csv(test_rf, file = "./output/data/usingEsDBpedia201610/approach2/newTypes_rf_v1.csv", fileEncoding = "UTF-8", row.names=FALSE)


#para deep learning generar ttl
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


#para random forest generar ttl
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
# salida_test1_n6_rf <- test_rf[test_rf$Class6_m1!="desconocido",c(1,10)]
# colnames(salida_test1_n6_rf) <- c("s","o")

salida_test1_rf <- rbind(salida_test1_n1_rf,
                         salida_test1_n2_rf,
                         salida_test1_n3_rf,
                         salida_test1_n4_rf,
                         salida_test1_n5_rf)


salida_test1$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test1[,c(1,2,3)] <- salida_test1[,c(1,3,2)]
write.csv(salida_test1, file = "./output/data/usingEsDBpedia201610/approach2/newTypes_dl_v1.ttl", fileEncoding = "UTF-8", row.names=FALSE)

#para random forest

salida_test1_rf$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test1_rf[,c(1,2,3)] <- salida_test1_rf[,c(1,3,2)]
write.csv(salida_test1_rf, file = "./output/data/usingEsDBpedia201610/approach2/newTypes_rf_v1.ttl", fileEncoding = "UTF-8", row.names=FALSE)




h2o.shutdown(prompt=FALSE)




