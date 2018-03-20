#evaluaaSDtypes_porNiveles

library(sqldf)

# 
# 
# original_types <- read.csv(file="/opt/files/proyectoHeiko_adaptado/version39/instance_types_en.ttl",
#                            header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# original_types$V4 <- NULL
# names(original_types) <- c("s","p","o")
# original_types$p <- NULL

#version39/pruebasNuevas/test 20171024/sdtypes_en_39_test3_semilla123.ttl
#version39/pruebasNuevas/test 20171006/sdtypes_en_39_test2_semilla123.ttl
#version39/pruebasNuevas/test 20171011/sdtypes_en_39_test1_semilla123.ttl
#version39/pruebasNuevas/reservaTipos2016en/reserva_test3_semilla123.ttl
#version39/pruebasNuevas/test 20171121/sdtypes_en_39_test1_semilla123_soloDBo.ttl
#version39/pruebasNuevas/test 20171122/sdtypes_en_39_test2_semilla123_soloDBo.ttl
#version39/pruebasNuevas/test 20171123/sdtypes_en_39_test3_semilla123_soloDBo.ttl
#Salidas de predicciones ML
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test1_v1.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test2_v1.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test3_v1.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test1_v1_C50.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test2_v1_C50.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test3_v1_C50.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test1_nb.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test2_nb.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test3_nb.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test1_rf.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test2_rf.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test3_rf.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test1_dl.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test2_dl.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test3_dl.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test1_gbm_default.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test2_gbm_default.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/ramasCompletas/test3_gbm_default.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest3/test3_v1.ttl #este es el de deep learning
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest3/test3_v1_rf.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest2/test2_v1.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest2/test2_v1_rf.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest1/test1_v1.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest1/test1_v1_rf.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest2/test2_v1_C50.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest2/test2_v1_dl.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest3/test3_rf.ttl.extended.csv"

#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach1/test_rf.csv.extended.csv
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach3/test1_rf.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/test1_dl.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/completedOutput_rf_v1.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/replicaSDTypes/sdtypes_es_201610_test1_semilla123.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/changingSeed/seed012/test_seed012_dl.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/changingSeed/seed234/test_seed234_rf.ttl

#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach2/test25_rf.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach2/test1_rf.ttl
#"/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach2/fiveFold/test5/test5_rf.ttl"
sdtypes_test_V3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/data/approach2/test25/test25_dl.ttl",
                            header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
#ojo, cuidado con las versiones de los archivos, si tiene 1 o dos columnas, etc
sdtypes_test_V3$V4 <- NULL
names(sdtypes_test_V3) <- c("s","p","o")
#names(sdtypes_test_V3) <- c("s","o")
#EXTRA solo para resultados actuales de modelado, se tienen en cuenta los tipos de la ontología de dbpedia, el resto ya se procesarán
sdtypes_test_V3 <- sdtypes_test_V3[grep('^<http://dbpedia.org/ontology/',sdtypes_test_V3$o),]


#/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/reservaTipos/reserva_test3_semilla123.ttl
#version39/pruebasNuevas/reservaTipos/reserva_test3_semilla123.ttl
#version39/pruebasNuevas/reservaTipos/reserva_test2_semilla123.ttl
#version39/pruebasNuevas/reservaTipos/reserva_test1_semilla123.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/reservaTest1.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/divisionChangingSeed/seed012/reservatest.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/divisionChangingSeed/seed234/reservatest.ttl
#"/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/data/approaches2and3/fiveFold/test5/reservatest.ttl"
tiposReservados_test_V3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/reservaTipos/reserva_test3_semilla123.ttl",
                                    header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
tiposReservados_test_V3$V4 <- NULL
colnames(tiposReservados_test_V3) <- c("s","p","o")
# names(tiposReservados_test_V3) <-tiposReservados_test_V3[1,]
# tiposReservados_test_V3 <- tiposReservados_test_V3[-1,]
#EXTRA solo para resultados actuales de modelado, se tienen en cuenta los tipos de la ontología de dbpedia, el resto ya se procesarán
tiposReservados_test_V3 <- tiposReservados_test_V3[grep('^<http://dbpedia.org/ontology/',tiposReservados_test_V3$o),]


###parte extra para separar niveles, de  momento para no llenar mucho la carga se separan las evaluaciones en una para cada ocasión

# nivel1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel1.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel2.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel3.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel4 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel4.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel5 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel5.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel6 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel6.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)

#version 3.8
# nivel1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel1.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel2.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel3.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel4 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel4.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel5 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel5.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# nivel6 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel6.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)

#version 3.9
nivel1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/R_visualizacionDBPedia/niveles/ramas39/nivel1.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/R_visualizacionDBPedia/niveles/ramas39/nivel2.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/R_visualizacionDBPedia/niveles/ramas39/nivel3.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel4 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/R_visualizacionDBPedia/niveles/ramas39/nivel4.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel5 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/R_visualizacionDBPedia/niveles/ramas39/nivel5.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel6 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/R_visualizacionDBPedia/niveles/ramas39/nivel6.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")

#version 2016-10
# nivel1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/niveles/nivel1.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8")
# nivel2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/niveles/nivel2.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8")
# nivel3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/niveles/nivel3.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8")
# nivel4 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/niveles/nivel4.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8")
# nivel5 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/niveles/nivel5.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8")
# nivel6 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/niveles/nivel6.csv",
#                    header=TRUE, sep=" ", encoding = "UTF-8")

#preparación para un nivel concreto: sustituir la parte derecha del %in% por el nivel deseado
#el siguiente paso que podría estar bien sería que se sacase diretamente lo de todos los niveles, pero 
#esto puede ser suficiente para resultados rápidos, apuntar para cada nivel y sacar afuera

guardaOriginal_types <- original_types
guardaSdtypes_test_V3 <- sdtypes_test_V3
guardaTiposReservados_test_V3 <-tiposReservados_test_V3

n0 <- c("nivel0",100,100,100)
resultados <- data.frame(t(n0))
colnames(resultados) <- c("nivel","precision","recall","fmeasure")
resultados$nivel <- as.character(resultados$nivel)
resultados$precision <- as.character(resultados$precision)
resultados$recall <- as.character(resultados$recall)
resultados$fmeasure <-as.character(resultados$fmeasure)

#guardado_extraTiposreservados_test_V3 <- tiposReservados_test_V3

#########
#NIVEL 1#
#########

#zona de preparacion de niveles
original_types <- original_types[original_types$o %in% nivel1$nivel1,]
sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel1$nivel1,]
tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel1$nivel1,]


##zona de evaluacion
groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))

tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
# tiposReservados_test <- tiposReservados_test_V3[,c(1,2)]
#cuidado, hay que cambiarlo en todos los niveles
resultados_test <- sdtypes_test_V3[,c(1,3)]
#resultados_test <- sdtypes_test_V3[,c(1,2)]

#aciertos_recursos_test <- tiposReservados_test[tiposReservados_test$s %in% resultados_test$s,]
#aciertos_test <- merge(x = aciertos_recursos_test, y = resultados_test, by = "s", all.x = TRUE)
aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]
aciertos_test <- merge(x = aciertos_recursos_test, y = tiposReservados_test, by = "s", all.x = TRUE)
aciertos_test <- aciertos_test[aciertos_test$o.x == aciertos_test$o.y,]

groupby_Recursos_acertados <- data.frame(table(aciertos_recursos_test$s))

aciertos_test <- aciertos_test[,c(1,2)]
names(aciertos_test) <- c("s","o")


names(groupby_RecursosReservados) <- c("s", "Freq")
groupby_RecursosReservados$s <- as.character(groupby_RecursosReservados$s)
names(groupby_Recursos_acertados) <- c("s", "Freq")
groupby_Recursos_acertados$s <- as.character(groupby_Recursos_acertados$s)

recursos_fallados <- groupby_RecursosReservados[!(groupby_RecursosReservados$s %in% groupby_Recursos_acertados$s), ]

tipos_RecursosFallados <- sqldf("SELECT tiposReservados_test.s, tiposReservados_test.o FROM tiposReservados_test, recursos_fallados WHERE tiposReservados_test.s == recursos_fallados.s")

#tiposExtra_fallados <- sqldf("SELECT resultados_test.s, resultados_test.o FROM resultados_test, tiposReservados_test WHERE resultados_test.s == tiposReservados_test.s GROUP BY resultados_test.s, resultados_test.o")
#tiposExtra_fallados <- sqldf("SELECT * FROM tiposExtra EXCEPT SELECT * FROM tiposReservados_test")

tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM aciertos_recursos_test EXCEPT SELECT * FROM aciertos_test")
tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM tipos_Fallados_RecursosAcertados EXCEPT SELECT * FROM tiposExtra")

#operaciones para no tener que hacerlas a mano dividiendo
metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)

resultados <- rbind(resultados,c("nivel1",metrica_precision,metrica_recall,metrica_Fmeasure))

#restaura datos sin sesgar por niveles
original_types <- guardaOriginal_types
sdtypes_test_V3 <- guardaSdtypes_test_V3
tiposReservados_test_V3 <- guardaTiposReservados_test_V3





#########
#NIVEL 2#
#########

#zona de preparacion de niveles
original_types <- original_types[original_types$o %in% nivel2$nivel2,]
sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel2$nivel2,]
tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel2$nivel2,]


##zona de evaluacion
groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))

tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
# tiposReservados_test <- tiposReservados_test_V3[,c(1,2)]
resultados_test <- sdtypes_test_V3[,c(1,3)]
#resultados_test <- sdtypes_test_V3[,c(1,2)]

#aciertos_recursos_test <- tiposReservados_test[tiposReservados_test$s %in% resultados_test$s,]
#aciertos_test <- merge(x = aciertos_recursos_test, y = resultados_test, by = "s", all.x = TRUE)
aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]
aciertos_test <- merge(x = aciertos_recursos_test, y = tiposReservados_test, by = "s", all.x = TRUE)
aciertos_test <- aciertos_test[aciertos_test$o.x == aciertos_test$o.y,]

groupby_Recursos_acertados <- data.frame(table(aciertos_recursos_test$s))

aciertos_test <- aciertos_test[,c(1,2)]
names(aciertos_test) <- c("s","o")


names(groupby_RecursosReservados) <- c("s", "Freq")
groupby_RecursosReservados$s <- as.character(groupby_RecursosReservados$s)
names(groupby_Recursos_acertados) <- c("s", "Freq")
groupby_Recursos_acertados$s <- as.character(groupby_Recursos_acertados$s)

recursos_fallados <- groupby_RecursosReservados[!(groupby_RecursosReservados$s %in% groupby_Recursos_acertados$s), ]

tipos_RecursosFallados <- sqldf("SELECT tiposReservados_test.s, tiposReservados_test.o FROM tiposReservados_test, recursos_fallados WHERE tiposReservados_test.s == recursos_fallados.s")

#tiposExtra_fallados <- sqldf("SELECT resultados_test.s, resultados_test.o FROM resultados_test, tiposReservados_test WHERE resultados_test.s == tiposReservados_test.s GROUP BY resultados_test.s, resultados_test.o")
#tiposExtra_fallados <- sqldf("SELECT * FROM tiposExtra EXCEPT SELECT * FROM tiposReservados_test")

tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM aciertos_recursos_test EXCEPT SELECT * FROM aciertos_test")
tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM tipos_Fallados_RecursosAcertados EXCEPT SELECT * FROM tiposExtra")

#operaciones para no tener que hacerlas a mano dividiendo
metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)

resultados <- rbind(resultados,c("nivel2",metrica_precision,metrica_recall,metrica_Fmeasure))

#restaura datos sin sesgar por niveles
original_types <- guardaOriginal_types
sdtypes_test_V3 <- guardaSdtypes_test_V3
tiposReservados_test_V3 <- guardaTiposReservados_test_V3






#########
#NIVEL 3#
#########

#zona de preparacion de niveles
original_types <- original_types[original_types$o %in% nivel3$nivel3,]
sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel3$nivel3,]
tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel3$nivel3,]


##zona de evaluacion
groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))

tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
# tiposReservados_test <- tiposReservados_test_V3[,c(1,2)]
resultados_test <- sdtypes_test_V3[,c(1,3)]
#resultados_test <- sdtypes_test_V3[,c(1,2)]

#aciertos_recursos_test <- tiposReservados_test[tiposReservados_test$s %in% resultados_test$s,]
#aciertos_test <- merge(x = aciertos_recursos_test, y = resultados_test, by = "s", all.x = TRUE)
aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]
aciertos_test <- merge(x = aciertos_recursos_test, y = tiposReservados_test, by = "s", all.x = TRUE)
aciertos_test <- aciertos_test[aciertos_test$o.x == aciertos_test$o.y,]

groupby_Recursos_acertados <- data.frame(table(aciertos_recursos_test$s))

aciertos_test <- aciertos_test[,c(1,2)]
names(aciertos_test) <- c("s","o")


names(groupby_RecursosReservados) <- c("s", "Freq")
groupby_RecursosReservados$s <- as.character(groupby_RecursosReservados$s)
names(groupby_Recursos_acertados) <- c("s", "Freq")
groupby_Recursos_acertados$s <- as.character(groupby_Recursos_acertados$s)

recursos_fallados <- groupby_RecursosReservados[!(groupby_RecursosReservados$s %in% groupby_Recursos_acertados$s), ]

tipos_RecursosFallados <- sqldf("SELECT tiposReservados_test.s, tiposReservados_test.o FROM tiposReservados_test, recursos_fallados WHERE tiposReservados_test.s == recursos_fallados.s")

#tiposExtra_fallados <- sqldf("SELECT resultados_test.s, resultados_test.o FROM resultados_test, tiposReservados_test WHERE resultados_test.s == tiposReservados_test.s GROUP BY resultados_test.s, resultados_test.o")
#tiposExtra_fallados <- sqldf("SELECT * FROM tiposExtra EXCEPT SELECT * FROM tiposReservados_test")

tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM aciertos_recursos_test EXCEPT SELECT * FROM aciertos_test")
tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM tipos_Fallados_RecursosAcertados EXCEPT SELECT * FROM tiposExtra")

#operaciones para no tener que hacerlas a mano dividiendo
metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)

resultados <- rbind(resultados,c("nivel3",metrica_precision,metrica_recall,metrica_Fmeasure))

#restaura datos sin sesgar por niveles
original_types <- guardaOriginal_types
sdtypes_test_V3 <- guardaSdtypes_test_V3
tiposReservados_test_V3 <- guardaTiposReservados_test_V3







#########
#NIVEL 4#
#########

#zona de preparacion de niveles
original_types <- original_types[original_types$o %in% nivel4$nivel4,]
sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel4$nivel4,]
tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel4$nivel4,]


##zona de evaluacion
groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))

tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
# tiposReservados_test <- tiposReservados_test_V3[,c(1,2)]
resultados_test <- sdtypes_test_V3[,c(1,3)]
#resultados_test <- sdtypes_test_V3[,c(1,2)]

#aciertos_recursos_test <- tiposReservados_test[tiposReservados_test$s %in% resultados_test$s,]
#aciertos_test <- merge(x = aciertos_recursos_test, y = resultados_test, by = "s", all.x = TRUE)
aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]
aciertos_test <- merge(x = aciertos_recursos_test, y = tiposReservados_test, by = "s", all.x = TRUE)
aciertos_test <- aciertos_test[aciertos_test$o.x == aciertos_test$o.y,]

groupby_Recursos_acertados <- data.frame(table(aciertos_recursos_test$s))

aciertos_test <- aciertos_test[,c(1,2)]
names(aciertos_test) <- c("s","o")


names(groupby_RecursosReservados) <- c("s", "Freq")
groupby_RecursosReservados$s <- as.character(groupby_RecursosReservados$s)
names(groupby_Recursos_acertados) <- c("s", "Freq")
groupby_Recursos_acertados$s <- as.character(groupby_Recursos_acertados$s)

recursos_fallados <- groupby_RecursosReservados[!(groupby_RecursosReservados$s %in% groupby_Recursos_acertados$s), ]

tipos_RecursosFallados <- sqldf("SELECT tiposReservados_test.s, tiposReservados_test.o FROM tiposReservados_test, recursos_fallados WHERE tiposReservados_test.s == recursos_fallados.s")

#tiposExtra_fallados <- sqldf("SELECT resultados_test.s, resultados_test.o FROM resultados_test, tiposReservados_test WHERE resultados_test.s == tiposReservados_test.s GROUP BY resultados_test.s, resultados_test.o")
#tiposExtra_fallados <- sqldf("SELECT * FROM tiposExtra EXCEPT SELECT * FROM tiposReservados_test")

tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM aciertos_recursos_test EXCEPT SELECT * FROM aciertos_test")
tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM tipos_Fallados_RecursosAcertados EXCEPT SELECT * FROM tiposExtra")

#operaciones para no tener que hacerlas a mano dividiendo
metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)

resultados <- rbind(resultados,c("nivel4",metrica_precision,metrica_recall,metrica_Fmeasure))

#restaura datos sin sesgar por niveles
original_types <- guardaOriginal_types
sdtypes_test_V3 <- guardaSdtypes_test_V3
tiposReservados_test_V3 <- guardaTiposReservados_test_V3






#########
#NIVEL 5#
#########

#zona de preparacion de niveles
original_types <- original_types[original_types$o %in% nivel5$nivel5,]
sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel5$nivel5,]
tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel5$nivel5,]


##zona de evaluacion
groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))

tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
# tiposReservados_test <- tiposReservados_test_V3[,c(1,2)]
resultados_test <- sdtypes_test_V3[,c(1,3)]
#resultados_test <- sdtypes_test_V3[,c(1,2)]

#aciertos_recursos_test <- tiposReservados_test[tiposReservados_test$s %in% resultados_test$s,]
#aciertos_test <- merge(x = aciertos_recursos_test, y = resultados_test, by = "s", all.x = TRUE)
aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]
aciertos_test <- merge(x = aciertos_recursos_test, y = tiposReservados_test, by = "s", all.x = TRUE)
aciertos_test <- aciertos_test[aciertos_test$o.x == aciertos_test$o.y,]

groupby_Recursos_acertados <- data.frame(table(aciertos_recursos_test$s))

aciertos_test <- aciertos_test[,c(1,2)]
names(aciertos_test) <- c("s","o")


names(groupby_RecursosReservados) <- c("s", "Freq")
groupby_RecursosReservados$s <- as.character(groupby_RecursosReservados$s)
names(groupby_Recursos_acertados) <- c("s", "Freq")
groupby_Recursos_acertados$s <- as.character(groupby_Recursos_acertados$s)

recursos_fallados <- groupby_RecursosReservados[!(groupby_RecursosReservados$s %in% groupby_Recursos_acertados$s), ]

tipos_RecursosFallados <- sqldf("SELECT tiposReservados_test.s, tiposReservados_test.o FROM tiposReservados_test, recursos_fallados WHERE tiposReservados_test.s == recursos_fallados.s")

#tiposExtra_fallados <- sqldf("SELECT resultados_test.s, resultados_test.o FROM resultados_test, tiposReservados_test WHERE resultados_test.s == tiposReservados_test.s GROUP BY resultados_test.s, resultados_test.o")
#tiposExtra_fallados <- sqldf("SELECT * FROM tiposExtra EXCEPT SELECT * FROM tiposReservados_test")

tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM aciertos_recursos_test EXCEPT SELECT * FROM aciertos_test")
tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM tipos_Fallados_RecursosAcertados EXCEPT SELECT * FROM tiposExtra")

#operaciones para no tener que hacerlas a mano dividiendo
metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)

resultados <- rbind(resultados,c("nivel5",metrica_precision,metrica_recall,metrica_Fmeasure))

#restaura datos sin sesgar por niveles
original_types <- guardaOriginal_types
sdtypes_test_V3 <- guardaSdtypes_test_V3
tiposReservados_test_V3 <- guardaTiposReservados_test_V3

resultados$precision <-round(as.numeric(resultados$precision),2)
resultados$recall <-round(as.numeric(resultados$recall),2)
resultados$fmeasure <-round(as.numeric(resultados$fmeasure),2)

resultados

# write.csv(resultados,file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/resultadosMetricas_niveles.csv", fileEncoding = "UTF-8", row.names=FALSE)

