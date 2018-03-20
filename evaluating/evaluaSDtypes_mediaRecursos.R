#evaluaSDtypes_mediaRecursos.R



library(sqldf)

#R_proyectos/R_visualizacionDBPedia/inputData/instance_types_transitive_en.ttl
#version39/instance_types_en.ttl
# original_types <- read.csv(file="/opt/files/proyectoHeiko_adaptado/version39/instance_types_en.ttl",
#                            header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
# original_types$V4 <- NULL
# names(original_types) <- c("s","p","o")
# original_types$p <- NULL


#R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/sdtypes_en_H2.ttl
#version39/pruebasNuevas/test 20171024/sdtypes_en_201610_test3_semilla123_ejec2.ttl
#version39/pruebasNuevas/test 20171024/sdtypes_en_39_test3_semilla123.ttl
#version39/pruebasNuevas/test 20171006/sdtypes_en_39_test2_semilla123.ttl
#version39/pruebasNuevas/test 20171011/sdtypes_en_39_test1_semilla123.ttl
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
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest3/test3_v1_rf.ttl
#R_proyectos/amelioratingTypes_ESWC2018/outputData/pruebaHojas/soloTest3/test3_rf.ttl.extended.csv
#R_proyectos/amelioratingTypes_ESWC2018/outputData/soloTest2/test2_v1_C50.ttl

#pruebas para los revisores del ESWC2018
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/.
#./output/data/approach1/test_nb.csv.extended.csv
#./output/data/approach1/test10_nb.csv.extended.csv
#./output/data/approach1/test25_nb.csv.extended.csv
#./output/data/approach1/test_dl.csv.extended.csv
#./output/data/approach1/test10_dl.csv.extended.csv
#./output/data/approach1/test25_dl.csv.extended.csv
#./output/data/approach1/test_rf.csv.extended.csv
#./output/data/approach1/test10_rf.csv.extended.csv
#./output/data/approach1/test25_rf.csv.extended.csv
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach1/test25_rf.csv.extended.csv
#ojo, cuidado con los formatos, algunos tienen coma como separadores y solo dos columnas, los otros espacios por separadores y 4 columnas
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/test1_dl.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/completedOutput_rf_v1.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/replicaSDTypes/sdtypes_es_201610_test1_semilla123.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/changingSeed/seed012/
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/changingSeed/seed234/test_seed234_rf.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEsDBpedia201610/approach2/chaningAlgorithmSeed/variacionesSobreTest1/seed1234
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach2/
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/approach2/fiveFold/test1/test1_rf.ttl

#/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/data/approach2/test1/test1_rf.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/data/approach2/fiveFold/test1/test1_rf.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEn38Version/approach2/fiveFold/test1/test1_rf.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/comparativa_GoldStandards/GS2/resultados_GS2_rf_Beta.ttl
sdtypes_test_V3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/data/approach2/fiveFold/test2/test2_rf.ttl",
                            header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
#                             header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
sdtypes_test_V3$V4 <- NULL
names(sdtypes_test_V3) <- c("s","p","o")
# names(sdtypes_test_V3) <- c("s","o")
#EXTRA solo para resultados actuales de modelado, se tienen en cuenta los tipos de la ontología de dbpedia, el resto ya se procesarán
sdtypes_test_V3 <- sdtypes_test_V3[grep('^<http://dbpedia.org/ontology/',sdtypes_test_V3$o),]


#version39/pruebasNuevas/reservaTipos2016en/reserva_test3_semilla123.ttl
#version39/pruebasNuevas/reservaTipos/reserva_test3_semilla123.ttl
#version39/pruebasNuevas/reservaTipos/reserva_test2_semilla123.ttl
#/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/reservaTipos/reserva_test1_semilla123.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/reservaTest1.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/divisionChangingSeed/...
#seed012/reservatest.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/divisionChangingSeed/seed234/reservatest.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEs201610Version/division2500/test1/reservaTest1.ttl

#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/test5/reservatest.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/data/approaches2and3/fiveFold/test1/reservatest.ttl
#/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/comparativa_GoldStandards/GS2/gs2-toDBpedia3.9.nt.extended.csv
tiposReservados_test_V3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/data/approaches2and3/fiveFold/test2/reservatest.ttl",
                                    header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
# tiposReservados_test_V3$V4 <- NULL
colnames(tiposReservados_test_V3) <- c("s","p","o")
# colnames(tiposReservados_test_V3) <- c("s","o")
#DEPENDE DE CÓMO SEAN LOS DATOS DE ENTRADA, OJO
# names(tiposReservados_test_V3) <-tiposReservados_test_V3[1,]
# tiposReservados_test_V3 <- tiposReservados_test_V3[-1,]
#EXTRA solo para resultados actuales de modelado, se tienen en cuenta los tipos de la ontología de dbpedia, el resto ya se procesarán
tiposReservados_test_V3 <- tiposReservados_test_V3[grep('^<http://dbpedia.org/ontology/',tiposReservados_test_V3$o),]

groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))

tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
# tiposReservados_test <- tiposReservados_test_V3[,c(1,2)]
#siguiente línea depende del formato, si es s,p,o ó s,o
resultados_test <- sdtypes_test_V3[,c(1,3)]
#resultados_test <- sdtypes_test_V3[,c(1,2)]

#aciertos_recursos_test <- tiposReservados_test[tiposReservados_test$s %in% resultados_test$s,]
aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]

#aciertos_test <- merge(x = aciertos_recursos_test, y = resultados_test, by = "s", all.x = TRUE)
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

tiposExtra <- sqldf("SELECT resultados_test.s, resultados_test.o FROM resultados_test, tiposReservados_test WHERE resultados_test.s == tiposReservados_test.s GROUP BY resultados_test.s, resultados_test.o")
tiposExtra <- sqldf("SELECT * FROM tiposExtra EXCEPT SELECT * FROM tiposReservados_test")

tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM aciertos_recursos_test EXCEPT SELECT * FROM aciertos_test")
tipos_Fallados_RecursosAcertados <- sqldf("SELECT * FROM tipos_Fallados_RecursosAcertados EXCEPT SELECT * FROM tiposExtra")

metrica_precision_normal <- nrow(aciertos_test)/nrow(aciertos_recursos_test)*100
metrica_recall_normal <- nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100
metrica_Fmeasure_normal <- 2*((metrica_precision_normal*metrica_recall_normal)/(metrica_precision_normal+metrica_recall_normal))

#metrica_precision <- nrow(aciertos_test)/nrow(aciertos_recursos_test)*100
#metrica_recall <- nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100
#metrica_Fmeasure <- 2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall))

#VPFP <- tiposReservados_test[tiposReservados_test$s %in% resultados_test$s,]
VPFP <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]

groupby_Aciertos_test <- data.frame(table(aciertos_test$s))
groupby_Aciertos_recursos_test <- data.frame(table(VPFP$s))
#agrupamos los aciertos de tipos para cada recurso y los dividimos entre todas las predicciones de cada recurso (VPFP)
metricas_medias_recurso <- merge(x = groupby_Aciertos_test, y = groupby_Aciertos_recursos_test, by = "Var1")
names(metricas_medias_recurso) <- c("Var1","Freq.groupby_Aciertos_test","Freq.groupby_Aciertos_recursos_test")

metricas_medias_recurso$precisionMedia <- metricas_medias_recurso$Freq.groupby_Aciertos_test / metricas_medias_recurso$Freq.groupby_Aciertos_recursos_test
metrica_precision_mediaRecurso <- (sum(metricas_medias_recurso$precisionMedia)/length(metricas_medias_recurso$precisionMedia))*100


auxGroupby_RecursosReservados <- groupby_RecursosReservados
names(auxGroupby_RecursosReservados) <- c("Var1", "Freq")
metricas_medias_recurso_recall <- merge(x = groupby_Aciertos_test, y = auxGroupby_RecursosReservados, by = "Var1", all.y = TRUE)
names(metricas_medias_recurso_recall) <- c("Var1","Freq.groupby_Aciertos_test", "Freq.Groupby_RecursosReservados")
metricas_medias_recurso_recall[is.na(metricas_medias_recurso_recall$Freq.groupby_Aciertos_test),]$Freq.groupby_Aciertos_test <- 0

metricas_medias_recurso_recall$recallMedia <- metricas_medias_recurso_recall$Freq.groupby_Aciertos_test / metricas_medias_recurso_recall$Freq.Groupby_RecursosReservados


metrica_recall_mediaRecurso <- (sum(metricas_medias_recurso_recall$recallMedia)/length(metricas_medias_recurso_recall$recallMedia))*100

metrica_Fmeasure_mediaRecurso <- 2*((metrica_precision_mediaRecurso*metrica_recall_mediaRecurso)/(metrica_precision_mediaRecurso+metrica_recall_mediaRecurso))

round(metrica_precision_normal,2)
round(metrica_recall_normal,2)
round(metrica_Fmeasure_normal,2)
round(metrica_precision_mediaRecurso,2)
round(metrica_recall_mediaRecurso,2)
round(metrica_Fmeasure_mediaRecurso,2)

#prueba <- groupby_RecursosReservados[!(groupby_RecursosReservados$s %in% groupby_Aciertos_test$Var1), ]
#prueba <- original_types[original_types$s %in% prueba$s,]
