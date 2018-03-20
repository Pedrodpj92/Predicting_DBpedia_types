#evaluaSDtypes_hojas.R


library(sqldf)


# 
# original_types <- read.csv(file="/opt/files/proyectoHeiko_adaptado/version39/instance_types_en.ttl",
#                            header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# original_types$V4 <- NULL
# names(original_types) <- c("s","p","o")
# original_types$p <- NULL

#version39/pruebasNuevas/test 20171011/sdtypes_en_39_test1_semilla123.ttl
#version39/pruebasNuevas/test 20171006/sdtypes_en_39_test2_semilla123.ttl
#version39/pruebasNuevas/test 20171024/sdtypes_en_39_test3_semilla123.ttl
#version39/pruebasNuevas/test 20171121/sdtypes_en_39_test1_semilla123_soloDBo.ttl
#version39/pruebasNuevas/test 20171122/sdtypes_en_39_test2_semilla123_soloDBo.ttl
#version39/pruebasNuevas/test 20171123/sdtypes_en_39_test3_semilla123_soloDBo.ttl
#Salidas de predicciones ML
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test1_v1.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test2_v1.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test3_v1.tt1
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test1_v1_C50.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test2_v1_C50.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/test3_v1_C50.tt1
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
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest3/test3_rf.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest2/test2_v1_C50.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach1/test25_rf.csv.extended.csv
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach3/test1_rf.ttl
#pruebas sobre EsDBpedia 2016-10
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/test1_rf.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/completedOutput_dl_v1.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/replicaSDTypes/sdtypes_es_201610_test1_semilla123.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/changingSeed/seed012/test_seed012_dl.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/changingSeed/seed234/test_seed234_rf.ttl

#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach2/test25_dl.ttl
#"/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach2/fiveFold/test1/test1_dl.ttl"
sdtypes_test_V3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/comparativa_GoldStandards/GS2/resultados_GS2_rf_Beta.ttl",
                            header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
sdtypes_test_V3$V4 <- NULL
colnames(sdtypes_test_V3) <- c("s","p","o")
#names(sdtypes_test_V3) <- c("s","o")
#EXTRA solo para resultados actuales de modelado, se tienen en cuenta los tipos de la ontología de dbpedia, el resto ya se procesarán
sdtypes_test_V3 <- sdtypes_test_V3[grep('^<http://dbpedia.org/ontology/',sdtypes_test_V3$o),]

#/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/reservaTipos/reserva_test3_semilla123.ttl
#reservaTipos/reserva_test1_semilla123.ttl
#reservaTipos/reserva_test2_semilla123.ttl
#reservaTipos/reserva_test3_semilla123.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/reservaTest1.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/divisionChangingSeed/seed012/reservatest.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/divisionChangingSeed/seed234/reservatest.tt
#"/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/data/approaches2and3/fiveFold/test1/reservatest.ttl"
tiposReservados_test_V3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/comparativa_GoldStandards/GS2/gs2-toDBpedia3.9.nt.extended.csv",
                                    header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
tiposReservados_test_V3$V4 <- NULL
colnames(tiposReservados_test_V3) <- c("s","p","o")
# colnames(tiposReservados_test_V3) <- c("s","o")
# names(tiposReservados_test_V3) <-tiposReservados_test_V3[1,]
# tiposReservados_test_V3 <- tiposReservados_test_V3[-1,]
#EXTRA solo para resultados actuales de modelado, se tienen en cuenta los tipos de la ontología de dbpedia, el resto ya se procesarán
tiposReservados_test_V3 <- tiposReservados_test_V3[grep('^<http://dbpedia.org/ontology/',tiposReservados_test_V3$o),]

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


guardaOriginal_types <- original_types
guardaSdtypes_test_V3 <- sdtypes_test_V3
guardaTiposReservados_test_V3 <-tiposReservados_test_V3



groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))

# tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
tiposReservados_test <- tiposReservados_test_V3[,c(1,2)]
resultados_test <- sdtypes_test_V3[,c(1,3)]
#resultados_test <- sdtypes_test_V3[,c(1,2)]

#aciertos_recursos_test <- tiposReservados_test[tiposReservados_test$s %in% resultados_test$s,]
aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]

#cogiendo solo hojas
#PARA ACIERTOS DE RECURSOS
soloNivel6 <- aciertos_recursos_test[aciertos_recursos_test$o %in% nivel6$nivel6, ] #con los datos actuales debería dar vacío

soloNivel5 <- aciertos_recursos_test[aciertos_recursos_test$o %in% nivel5$nivel5, ]
soloNivel5 <- soloNivel5[!(soloNivel5$s %in% soloNivel6$s), ]

soloNivel4 <- aciertos_recursos_test[aciertos_recursos_test$o %in% nivel4$nivel4, ]
soloNivel4 <- soloNivel4[!(soloNivel4$s %in% soloNivel5$s), ]
soloNivel4 <- soloNivel4[!(soloNivel4$s %in% soloNivel6$s), ]


soloNivel3 <- aciertos_recursos_test[aciertos_recursos_test$o %in% nivel3$nivel3, ]
soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel4$s), ]
soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel5$s), ]
soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel6$s), ]


soloNivel2 <- aciertos_recursos_test[aciertos_recursos_test$o %in% nivel2$nivel2, ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel3$s), ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel4$s), ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel5$s), ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel6$s), ]

soloNivel1 <- aciertos_recursos_test[aciertos_recursos_test$o %in% nivel1$nivel1, ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel2$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel3$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel4$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel5$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel6$s), ]

hojas_aciertos_recursos_test <- rbind(soloNivel1, soloNivel2, soloNivel3, soloNivel4, soloNivel5, soloNivel6)

#restantesHojas <- aciertos_recursos_test[!(aciertos_recursos_test$s %in% pruebaHojas$s),] 

#PARA RECURSOS RESERVADOS
soloNivel6 <- tiposReservados_test[tiposReservados_test$o %in% nivel6$nivel6, ] #con los datos actuales debería dar vacío

soloNivel5 <- tiposReservados_test[tiposReservados_test$o %in% nivel5$nivel5, ]
soloNivel5 <- soloNivel5[!(soloNivel5$s %in% soloNivel6$s), ]

soloNivel4 <- tiposReservados_test[tiposReservados_test$o %in% nivel4$nivel4, ]
soloNivel4 <- soloNivel4[!(soloNivel4$s %in% soloNivel5$s), ]
soloNivel4 <- soloNivel4[!(soloNivel4$s %in% soloNivel6$s), ]


soloNivel3 <- tiposReservados_test[tiposReservados_test$o %in% nivel3$nivel3, ]
soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel4$s), ]
soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel5$s), ]
soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel6$s), ]


soloNivel2 <- tiposReservados_test[tiposReservados_test$o %in% nivel2$nivel2, ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel3$s), ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel4$s), ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel5$s), ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel6$s), ]

soloNivel1 <- tiposReservados_test[tiposReservados_test$o %in% nivel1$nivel1, ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel2$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel3$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel4$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel5$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel6$s), ]

hojas_tiposReservados_test <- rbind(soloNivel1, soloNivel2, soloNivel3, soloNivel4, soloNivel5, soloNivel6)

#restantesHojas <- hojas_tiposReservados_test[!(hojas_tiposReservados_test$s %in% tiposReservados_test$s),]

#aciertos_test <- merge(x = aciertos_recursos_test, y = resultados_test, by = "s", all.x = TRUE)
#aciertos_test <- aciertos_test[aciertos_test$o.x == aciertos_test$o.y,]
aciertos_test <- merge(x = hojas_aciertos_recursos_test, y = hojas_tiposReservados_test, by = "s", all.x = TRUE)
aciertos_test <- aciertos_test[aciertos_test$o.x == aciertos_test$o.y,]
groupby_Recursos_acertados <- data.frame(table(hojas_aciertos_recursos_test$s))

aciertos_test <- aciertos_test[,c(1,2)]
names(aciertos_test) <- c("s","o")


names(groupby_RecursosReservados) <- c("s", "Freq")
groupby_RecursosReservados$s <- as.character(groupby_RecursosReservados$s)
names(groupby_Recursos_acertados) <- c("s", "Freq")
groupby_Recursos_acertados$s <- as.character(groupby_Recursos_acertados$s)

recursos_fallados <- groupby_RecursosReservados[!(groupby_RecursosReservados$s %in% groupby_Recursos_acertados$s), ]

tipos_RecursosFallados <- sqldf("SELECT tiposReservados_test.s, tiposReservados_test.o FROM tiposReservados_test, recursos_fallados WHERE tiposReservados_test.s == recursos_fallados.s")

tiposExtra <- sqldf("SELECT resultados_test.s, resultados_test.o FROM resultados_test, tiposReservados_test WHERE resultados_test.s == tiposReservados_test.s GROUP BY resultados_test.s, resultados_test.o")
tiposExtra <- sqldf("SELECT * FROM tiposExtra EXCEPT SELECT * FROM tiposReservados_test")

tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM aciertos_recursos_test EXCEPT SELECT * FROM aciertos_test")
tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM tipos_Fallados_RecursosAcertados EXCEPT SELECT * FROM tiposExtra")

#operaciones para no tener que hacerlas a mano dividiendo
metrica_precision <- nrow(aciertos_test)/nrow(hojas_aciertos_recursos_test)*100
metrica_recall <- nrow(aciertos_test)/nrow(hojas_tiposReservados_test)*100
metrica_Fmeasure <- 2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall))

round(metrica_precision,2)
round(metrica_recall,2)
round(metrica_Fmeasure,2)

#restaura datos sin sesgar por niveles
original_types <- guardaOriginal_types
sdtypes_test_V3 <- guardaSdtypes_test_V3
tiposReservados_test_V3 <- guardaTiposReservados_test_V3

