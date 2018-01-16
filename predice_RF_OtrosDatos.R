#Valida.R

library(h2o)
h2o.init(
  nthreads=-1            ## -1: use all available threads
  #max_mem_size = "2G"
)

original_resources <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/mappingbased_properties_en.ttl",
                               header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
original_resources <- original_resources[grep('^<http://dbpedia.org/resource/',original_resources$V3),]
original_resources$V4 <- NULL
names(original_resources) <- c("s","p","o")
original_resources$s <- as.factor(original_resources$s)
original_resources$p <- as.factor(original_resources$p)
original_resources$o <- as.factor(original_resources$o)


original_types <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/instance_types_en.ttl",
                           header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
original_types <- original_types[grep('^<http://dbpedia.org/resource/',original_types$V1),]
original_types <- original_types[grep('^<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>',original_types$V2),]
original_types <- original_types[grep('^<http://dbpedia.org/ontology/',original_types$V3),]
original_types$V4 <- NULL
names(original_types) <- c("s","p","o")
original_types$s <- as.factor(original_types$s)
original_types$p <- as.factor(original_types$p)
original_types$o <- as.factor(original_types$o)

matriz_recursos <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/objects_properties_Matrix.csv",
                            header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(matriz_recursos) <- matriz_recursos[1,]
matriz_recursos <- matriz_recursos[-1,]
matriz_recursos[,c(2:(ncol(matriz_recursos)))] <- sapply(matriz_recursos[,c(2:(ncol(matriz_recursos)))], as.numeric)


matriz_recursos_conTipo <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/objects_properties_typesConditioned_Matrix.csv",
                                    header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(matriz_recursos_conTipo) <- matriz_recursos_conTipo[1,]
matriz_recursos_conTipo <- matriz_recursos_conTipo[-1,]
matriz_recursos_conTipo[,c(2:(ncol(matriz_recursos_conTipo)))] <- sapply(matriz_recursos_conTipo[,c(2:(ncol(matriz_recursos_conTipo)-11))], as.numeric)


objectWithTypes <- original_types[original_types$s %in% matriz_recursos_conTipo$o,]




df_validating_test1 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/objects_properties_typesConditioned_Matrix.csv"), header = TRUE)
valid_test1 <- h2o.assign(df_validating_test1, "valid_test1.hex")

#random forest
rf_nivel1_v1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1/rf_nivel1_v1")
rf_n2_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1/rf_n2_m1")
rf_n2_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1/rf_n2_m4")
rf_n3_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1/rf_n3_m1")
rf_n3_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1/rf_n3_m4")
rf_n4_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1/rf_n4_m1")
rf_n4_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1/rf_n4_m4")
rf_n5_m1 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1/rf_n5_m1")
rf_n5_m4 = h2o.loadModel(path = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1/rf_n5_m4")

#para Test1
#test1_n1 <- h2o.predict(object = dl_nivel1_v1, newdata = valid_test1[,2:(ncol(valid_test1)-11)])
##test1_n2_m1 <- h2o.predict(object = dl_n2_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
#test1_n2_m4 <- h2o.predict(object = dl_n2_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-10))])
#test1_n3_m1 <- h2o.predict(object = dl_n3_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
#test1_n3_m4 <- h2o.predict(object = dl_n3_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-8))])
#test1_n4_m1 <- h2o.predict(object = dl_n4_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-6))])
#test1_n4_m4 <- h2o.predict(object = dl_n4_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-6))])
#test1_n5_m1 <- h2o.predict(object = dl_n5_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
#test1_n5_m4 <- h2o.predict(object = dl_n5_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-4))])

#test1_n1_rf <- h2o.predict(object = rf_nivel1_v1, newdata = valid_test1[,2:(ncol(valid_test1)-11)])
#test1_n2_m1_rf <- h2o.predict(object = rf_n2_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
#test1_n2_m4_rf <- h2o.predict(object = rf_n2_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-10))])
#test1_n3_m1_rf <- h2o.predict(object = rf_n3_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
#test1_n3_m4_rf <- h2o.predict(object = rf_n3_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-8))])
#test1_n4_m1_rf <- h2o.predict(object = rf_n4_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-6))])
#test1_n4_m4_rf <- h2o.predict(object = rf_n4_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-6))])
#test1_n5_m1_rf <- h2o.predict(object = rf_n5_m1, newdata = valid_test1[,c(2:(ncol(valid_test1)-11))])
#test1_n5_m4_rf <- h2o.predict(object = rf_n5_m4, newdata = valid_test1[,c(2:(ncol(valid_test1)-4))])

validation_rf <- valid_test1[,1:(ncol(valid_test1))]

test1_n1_rf <- h2o.predict(object = rf_nivel1_v1, newdata = validation_rf[,2:(ncol(validation_rf))])
validation_rf <- h2o.cbind(validation_rf,test1_n1_rf$predict)
colnames(validation_rf)[ncol(validation_rf)] <- "Class1"

test1_n2_m4_rf <- h2o.predict(object = rf_n2_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
validation_rf <- h2o.cbind(validation_rf,test1_n2_m4_rf$predict)
colnames(validation_rf)[ncol(validation_rf)] <- "Class2"

test1_n2_m1_rf <- h2o.predict(object = rf_n2_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)-2))])
validation_rf <- h2o.cbind(validation_rf,test1_n2_m1_rf$predict)
colnames(validation_rf)[ncol(validation_rf)] <- "Class2_Bin"

test1_n3_m4_rf <- h2o.predict(object = rf_n3_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
validation_rf <- h2o.cbind(validation_rf,test1_n3_m4_rf$predict)
colnames(validation_rf)[ncol(validation_rf)] <- "Class3"

test1_n3_m1_rf <- h2o.predict(object = rf_n3_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)-4))])
validation_rf <- h2o.cbind(validation_rf,test1_n3_m1_rf$predict)
colnames(validation_rf)[ncol(validation_rf)] <- "Class3_Bin"

test1_n4_m4_rf <- h2o.predict(object = rf_n4_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
validation_rf <- h2o.cbind(validation_rf,test1_n4_m4_rf$predict)
colnames(validation_rf)[ncol(validation_rf)] <- "Class4"

test1_n4_m1_rf <- h2o.predict(object = rf_n4_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)-1))])
validation_rf <- h2o.cbind(validation_rf,test1_n4_m1_rf$predict)
colnames(validation_rf)[ncol(validation_rf)] <- "Class4_Bin"

test1_n5_m4_rf <- h2o.predict(object = rf_n5_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
validation_rf <- h2o.cbind(validation_rf,test1_n1_rf$predict)
colnames(validation_rf)[ncol(validation_rf)] <- "Class5"

test1_n5_m1_rf <- h2o.predict(object = rf_n5_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)-8))])
validation_rf <- h2o.cbind(validation_rf,test1_n5_m1_rf$predict)
colnames(validation_rf)[ncol(validation_rf)] <- "Class5_Bin"


#paso tabla unida

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

write.csv(test1_rf, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/output_OutgoingsWithOldTypes_rf_v1.csv", fileEncoding = "UTF-8", row.names=FALSE)


#para generar el data frame que tenga par de columnas los tipos
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


#para random forest

salida_test1_rf$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test1_rf[,c(1,2,3)] <- salida_test1_rf[,c(1,3,2)]
write.csv(salida_test1_rf, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/output_OutgoingsWithOldTypes_rf_v1.ttl", fileEncoding = "UTF-8", row.names=FALSE)








h2o.shutdown(prompt=FALSE)
