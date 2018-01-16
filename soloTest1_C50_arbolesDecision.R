#!/usr/bin/env Rscript
#Pruebas con J48 de Weka para R (RWeka)
#De momento no lo hemos podido instalar, se prueba con C50

library(C50)



df_training <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training.csv",
                        header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(df_training) <- df_training[1,]
df_training <- df_training[-1,]
#df_training[,c(2:ncol(df_training-11))] <- lapply(df_training[,2:(ncol(df_training)-11)], function(x) as.numeric(as.character(x)))
df_training[,c(2:(ncol(df_training)-11))] <- sapply(df_training[,c(2:(ncol(df_training)-11))], as.numeric)

df_validating <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/validating_test1.csv",
                        header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(df_validating) <- df_validating[1,]
df_validating <- df_validating[-1,]
#df_validating[,c(2:ncol(df_validating-11))] <- lapply(df_validating[,2:(ncol(df_validating)-11)], function(x) as.numeric(as.character(x)))
df_validating[,c(2:(ncol(df_validating)-11))] <- sapply(df_validating[,c(2:(ncol(df_validating)-11))], as.numeric)


df_training_sinDesc_N2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training_sinDesc_N2.csv",
                                   header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(df_training_sinDesc_N2) <- df_training_sinDesc_N2[1,]
df_training_sinDesc_N2 <- df_training_sinDesc_N2[-1,]
df_training_sinDesc_N2[,c(2:(ncol(df_training_sinDesc_N2)-11))] <- sapply(df_training_sinDesc_N2[,c(2:(ncol(df_training_sinDesc_N2)-11))], as.numeric)


df_training_sinDesc_N3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training_sinDesc_N3.csv",
                                   header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(df_training_sinDesc_N3) <- df_training_sinDesc_N3[1,]
df_training_sinDesc_N3 <- df_training_sinDesc_N3[-1,]
df_training_sinDesc_N3[,c(2:(ncol(df_training_sinDesc_N3)-11))] <- sapply(df_training_sinDesc_N3[,c(2:(ncol(df_training_sinDesc_N3)-11))], as.numeric)


df_training_sinDesc_N4 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training_sinDesc_N4.csv",
                                   header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(df_training_sinDesc_N4) <- df_training_sinDesc_N4[1,]
df_training_sinDesc_N4 <- df_training_sinDesc_N4[-1,]
df_training_sinDesc_N4[,c(2:(ncol(df_training_sinDesc_N4)-11))] <- sapply(df_training_sinDesc_N4[,c(2:(ncol(df_training_sinDesc_N4)-11))], as.numeric)


df_training_sinDesc_N5 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/soloTest1/training_sinDesc_N5.csv",
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
#summary( model )

#nivel 2
c50_n2_m1 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-8] )
#c50_n2_m2 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-9] )
c50_n2_m3 <- C50::C5.0( df_training_sinDesc_N2[,c(2:(ncol(df_training_sinDesc_N2)-11))], df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-9] )
#c50_n2_m4 <- C50::C5.0( df_training_sinDesc_N2[,c(2:(ncol(df_training_sinDesc_N2)-10))], df_training_sinDesc_N2[,ncol(df_training_sinDesc_N2)-9] )

#nivel 3
c50_n3_m1 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-6] )
#c50_n3_m2 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-7] )
c50_n3_m3 <- C50::C5.0( df_training_sinDesc_N3[,c(2:(ncol(df_training_sinDesc_N3)-11))], df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-7] )
#c50_n3_m4 <- C50::C5.0( df_training_sinDesc_N3[,c(2:(ncol(df_training_sinDesc_N3)-8))], df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-7] )
#c50_n3_m4 <- C50::C5.0( df_training_sinDesc_N3[,c(2:(ncol(df_training_sinDesc_N3)-9))], df_training_sinDesc_N3[,ncol(df_training_sinDesc_N3)-7] )
#DATO MUY IMPORTATNE: en otros modelos se cogía para m4 hasta el anterior (aprende de todo lo que hay hasta el momento)
#no se tenía en cuenta que el anterior era una variable binomial (conocido/desconocido), esto no importaría si no fuese porque estos se convierten
#en una constante "conocidos" al restringir los datos siguientes, puesto que para nivel 3, si solo nos quedamos con los conocidos, en el anterior
#clase 2 binomial es una constante siempre que los caminos de los tipos de la ontología sean completos
#En otras librerías como con H2O no pasaba nada, podía manejar automáticamente estas situaciones avisando de que la variable era constante y no
#se iba a tener en cuenta.

#esta dando muchos problemas las variables multinomiales encadenadas, vamos a probar solo con los predictores normales de los predicados


#nivel 4
c50_n4_m1 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-4] )
#c50_n4_m2 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-5] )
c50_n4_m3 <- C50::C5.0( df_training_sinDesc_N4[,c(2:(ncol(df_training_sinDesc_N4)-11))], df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-5] )
#c50_n4_m4 <- C50::C5.0( df_training_sinDesc_N4[,c(2:(ncol(df_training_sinDesc_N4)-9),(ncol(df_training_sinDesc_N4)-7))], df_training_sinDesc_N4[,ncol(df_training_sinDesc_N4)-5] )

#nivel 5
c50_n5_m1 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-2] )
#c50_n5_m2 <- C50::C5.0( df_training[,c(2:(ncol(df_training)-11))], df_training[,ncol(df_training)-3] )
c50_n5_m3 <- C50::C5.0( df_training_sinDesc_N5[,c(2:(ncol(df_training_sinDesc_N5)-11))], df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-3] )
#c50_n5_m4 <- C50::C5.0( df_training_sinDesc_N5[,c(2:(ncol(df_training_sinDesc_N5)-5))], df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-3] )
#c50_n5_m4 <- C50::C5.0( df_training_sinDesc_N5[,c(2:(ncol(df_training_sinDesc_N4)-9),(ncol(df_training_sinDesc_N4)-7),(ncol(df_training_sinDesc_N5)-5))], df_training_sinDesc_N5[,ncol(df_training_sinDesc_N5)-3] )


save.image("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/c50_modeladoCompleto_soloTest1.RData")



#predicciones

#para Test1
test1_n1 <- predict(object = c50_nivel1_v3, newdata = df_validating[,2:(ncol(df_validating)-11)])
test1_n2_m1 <- predict(object = c50_n2_m1, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
test1_n2_m3 <- predict(object = c50_n2_m3, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
#test1_n2_m4 <- predict(object = c50_n2_m4, newdata = df_validating_test1[,c(2:(ncol(df_validating_test1)-10))])
test1_n3_m1 <- predict(object = c50_n3_m1, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
test1_n3_m3 <- predict(object = c50_n3_m3, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
#test1_n3_m3 <- predict(object = c50_n3_m3, newdata = df_validating_test1[,c(2:(ncol(df_validating_test1)-8))])
#test1_n3_m4 <- predict(object = c50_n3_m4, newdata = df_validating_test1[,c(2:(ncol(df_validating_test1)-9))])
test1_n4_m1 <- predict(object = c50_n4_m1, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
test1_n4_m3 <- predict(object = c50_n4_m3, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
#test1_n4_m4 <- predict(object = c50_n4_m4, newdata = df_validating_test1[,c(2:(ncol(df_validating_test1)-9),(ncol(df_validating_test1)-7))])
test1_n5_m1 <- predict(object = c50_n5_m1, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
test1_n5_m3 <- predict(object = c50_n5_m3, newdata = df_validating[,c(2:(ncol(df_validating)-11))])
#test1_n5_m4 <- predict(object = c50_n5_m4, newdata = df_validating_test1[,c(2:(ncol(df_validating_test1)-9),(ncol(df_validating_test1)-7),(ncol(df_validating_test1)-5))])


#test1_n1_vector <- as.vector(test1_n1)
#test1_n2_m1_vector <- as.vector(test1_n2_m1)
#test1_n2_m4_vector <- as.vector(test1_n2_m4)
#test1_n3_m1_vector <- as.vector(test1_n3_m1)
#test1_n3_m4_vector <- as.vector(test1_n3_m4)
#test1_n4_m1_vector <- as.vector(test1_n4_m1)
#test1_n4_m4_vector <- as.vector(test1_n4_m4)
#test1_n5_m1_vector <- as.vector(test1_n5_m1)
#test1_n5_m4_vector <- as.vector(test1_n5_m4)

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

write.csv(test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest1/test1_modoTabla_c50_cv.csv", fileEncoding = "UTF-8", row.names=FALSE)


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

salida_test1$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
salida_test1[,c(1,2,3)] <- salida_test1[,c(1,3,2)]
write.csv(salida_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest1/test1_v1_C50.ttl", fileEncoding = "UTF-8", row.names=FALSE)


