#evalua_completo.R

evalua_generalAndMean <- function(pathDT_Generado, pathDT_Reservado){
  # library(sqldf)
  
  sdtypes_test_V3 <- read.csv(file=pathDT_Generado,
                              header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  sdtypes_test_V3$V4 <- NULL
  names(sdtypes_test_V3) <- c("s","p","o")
  sdtypes_test_V3 <- sdtypes_test_V3[grep('^<http://dbpedia.org/ontology/',sdtypes_test_V3$o),]
  
  tiposReservados_test_V3 <- read.csv(file=pathDT_Reservado,
                                      header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  tiposReservados_test_V3$V4 <- NULL
  colnames(tiposReservados_test_V3) <- c("s","p","o")
  tiposReservados_test_V3 <- tiposReservados_test_V3[grep('^<http://dbpedia.org/ontology/',tiposReservados_test_V3$o),]
  
  groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))
  
  tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
  resultados_test <- sdtypes_test_V3[,c(1,3)]
  
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
  
  metrica_precision_normal <- nrow(aciertos_test)/nrow(aciertos_recursos_test)*100
  metrica_recall_normal <- nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100
  metrica_Fmeasure_normal <- 2*((metrica_precision_normal*metrica_recall_normal)/(metrica_precision_normal+metrica_recall_normal))
  
  VPFP <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]
  
  groupby_Aciertos_test <- data.frame(table(aciertos_test$s))
  groupby_Aciertos_recursos_test <- data.frame(table(VPFP$s))
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
  
  metrica_precision_normal <- round(metrica_precision_normal,2)
  metrica_recall_normal <- round(metrica_recall_normal,2)
  metrica_Fmeasure_normal <- round(metrica_Fmeasure_normal,2)
  metrica_precision_mediaRecurso <- round(metrica_precision_mediaRecurso,2)
  metrica_recall_mediaRecurso <- round(metrica_recall_mediaRecurso,2)
  metrica_Fmeasure_mediaRecurso <- round(metrica_Fmeasure_mediaRecurso,2)
  
  n0 <- c("nivel0",100,100,100)
  resultados <- data.frame(t(n0))
  colnames(resultados) <- c("measurementCriteria","precision","recall","fmeasure")
  resultados$measurementCriteria <- as.character(resultados$measurementCriteria)
  resultados$precision <- as.character(resultados$precision)
  resultados$recall <- as.character(resultados$recall)
  resultados$fmeasure <-as.character(resultados$fmeasure)
  
  resultados <- rbind(resultados,c("General",
                                   metrica_precision_normal,
                                   metrica_recall_normal,
                                   metrica_Fmeasure_normal))
  resultados <- resultados[-1,]
  
  resultados <- rbind(resultados,c("Mean",
                                   metrica_precision_mediaRecurso,
                                   metrica_recall_mediaRecurso,
                                   metrica_Fmeasure_mediaRecurso))
  
  return(resultados)
}


evalua_leaves <- function(pathDT_Generado, pathDT_Reservado, pathNiveles){
  
  sdtypes_test_V3 <- read.csv(file=pathDT_Generado,
                              header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  sdtypes_test_V3$V4 <- NULL
  colnames(sdtypes_test_V3) <- c("s","p","o")
  sdtypes_test_V3 <- sdtypes_test_V3[grep('^<http://dbpedia.org/ontology/',sdtypes_test_V3$o),]
  
  tiposReservados_test_V3 <- read.csv(file=pathDT_Reservado,
                                      header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  tiposReservados_test_V3$V4 <- NULL
  colnames(tiposReservados_test_V3) <- c("s","p","o")
  tiposReservados_test_V3 <- tiposReservados_test_V3[grep('^<http://dbpedia.org/ontology/',tiposReservados_test_V3$o),]
  
  nivel1 <- read.csv(file=paste(pathNiveles,"nivel1.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel2 <- read.csv(file=paste(pathNiveles,"nivel2.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel3 <- read.csv(file=paste(pathNiveles,"nivel3.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel4 <- read.csv(file=paste(pathNiveles,"nivel4.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel5 <- read.csv(file=paste(pathNiveles,"nivel5.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel6 <- read.csv(file=paste(pathNiveles,"nivel6.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  
  
  # guardaOriginal_types <- original_types
  guardaSdtypes_test_V3 <- sdtypes_test_V3
  guardaTiposReservados_test_V3 <-tiposReservados_test_V3
  
  
  
  groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))
  
  tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
  resultados_test <- sdtypes_test_V3[,c(1,3)]
  aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]
  
  #cogiendo solo hojas
  soloNivel6 <- aciertos_recursos_test[aciertos_recursos_test$o %in% nivel6$nivel6, ]
  
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
  
  #PARA RECURSOS RESERVADOS
  soloNivel6 <- tiposReservados_test[tiposReservados_test$o %in% nivel6$nivel6, ]
  
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
  
  metrica_precision <- nrow(aciertos_test)/nrow(hojas_aciertos_recursos_test)*100
  metrica_recall <- nrow(aciertos_test)/nrow(hojas_tiposReservados_test)*100
  metrica_Fmeasure <- 2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall))
  
  metrica_precision <- round(metrica_precision,2)
  metrica_recall <- round(metrica_recall,2)
  metrica_Fmeasure <- round(metrica_Fmeasure,2)
  
  n0 <- c("nivel0",100,100,100)
  resultados <- data.frame(t(n0))
  colnames(resultados) <- c("measurementCriteria","precision","recall","fmeasure")
  resultados$measurementCriteria <- as.character(resultados$measurementCriteria)
  resultados$precision <- as.character(resultados$precision)
  resultados$recall <- as.character(resultados$recall)
  resultados$fmeasure <-as.character(resultados$fmeasure)
  
  resultados <- rbind(resultados,c("Leaves",
                                   metrica_precision,
                                   metrica_recall,
                                   metrica_Fmeasure))
  resultados <- resultados[-1,]
  
  return(resultados)
}


evalua_levels <- function(pathDT_Generado, pathDT_Reservado, pathNiveles){
  sdtypes_test_V3 <- read.csv(file=pathDT_Generado,
                              header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  sdtypes_test_V3$V4 <- NULL
  names(sdtypes_test_V3) <- c("s","p","o")
  sdtypes_test_V3 <- sdtypes_test_V3[grep('^<http://dbpedia.org/ontology/',sdtypes_test_V3$o),]
  
  tiposReservados_test_V3 <- read.csv(file=pathDT_Reservado,
                                      header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  tiposReservados_test_V3$V4 <- NULL
  colnames(tiposReservados_test_V3) <- c("s","p","o")
  tiposReservados_test_V3 <- tiposReservados_test_V3[grep('^<http://dbpedia.org/ontology/',tiposReservados_test_V3$o),]
  
  nivel1 <- read.csv(file=paste(pathNiveles,"nivel1.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel2 <- read.csv(file=paste(pathNiveles,"nivel2.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel3 <- read.csv(file=paste(pathNiveles,"nivel3.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel4 <- read.csv(file=paste(pathNiveles,"nivel4.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel5 <- read.csv(file=paste(pathNiveles,"nivel5.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel6 <- read.csv(file=paste(pathNiveles,"nivel6.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  
  guardaSdtypes_test_V3 <- sdtypes_test_V3
  guardaTiposReservados_test_V3 <-tiposReservados_test_V3
  
  n0 <- c("level0",100,100,100)
  resultados <- data.frame(t(n0))
  colnames(resultados) <- c("measurementCriteria","precision","recall","fmeasure")
  resultados$measurementCriteria <- as.character(resultados$measurementCriteria)
  resultados$precision <- as.character(resultados$precision)
  resultados$recall <- as.character(resultados$recall)
  resultados$fmeasure <-as.character(resultados$fmeasure)
  
  #########
  #NIVEL 1#
  #########
  
  #zona de preparacion de niveles
  sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel1$nivel1,]
  tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel1$nivel1,]
  
  
  ##zona de evaluacion
  groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))
  
  tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
  resultados_test <- sdtypes_test_V3[,c(1,3)]
  
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
  
  metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
  metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
  metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)
  
  resultados <- rbind(resultados,c("Level1",metrica_precision,metrica_recall,metrica_Fmeasure))
  
  #restaura datos sin sesgar por niveles
  sdtypes_test_V3 <- guardaSdtypes_test_V3
  tiposReservados_test_V3 <- guardaTiposReservados_test_V3
  
  
  #########
  #NIVEL 2#
  #########
  
  sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel2$nivel2,]
  tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel2$nivel2,]
  
  
  ##zona de evaluacion
  groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))
  
  tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
  resultados_test <- sdtypes_test_V3[,c(1,3)]
  
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
  
  metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
  metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
  metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)
  
  resultados <- rbind(resultados,c("Level2",metrica_precision,metrica_recall,metrica_Fmeasure))
  
  #restaura datos sin sesgar por niveles
  sdtypes_test_V3 <- guardaSdtypes_test_V3
  tiposReservados_test_V3 <- guardaTiposReservados_test_V3
  
  #########
  #NIVEL 3#
  #########
  
  #zona de preparacion de niveles
  sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel3$nivel3,]
  tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel3$nivel3,]
  
  
  ##zona de evaluacion
  groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))
  
  tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
  resultados_test <- sdtypes_test_V3[,c(1,3)]
  
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
  
  metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
  metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
  metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)
  
  resultados <- rbind(resultados,c("Level3",metrica_precision,metrica_recall,metrica_Fmeasure))
  
  #restaura datos sin sesgar por niveles
  sdtypes_test_V3 <- guardaSdtypes_test_V3
  tiposReservados_test_V3 <- guardaTiposReservados_test_V3
  
  
  #########
  #NIVEL 4#
  #########
  
  #zona de preparacion de niveles
  sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel4$nivel4,]
  tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel4$nivel4,]
  
  
  ##zona de evaluacion
  groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))
  
  tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
  resultados_test <- sdtypes_test_V3[,c(1,3)]
  
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
  
  #operaciones para no tener que hacerlas a mano dividiendo
  metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
  metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
  metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)
  
  resultados <- rbind(resultados,c("Level4",metrica_precision,metrica_recall,metrica_Fmeasure))
  
  #restaura datos sin sesgar por niveles
  sdtypes_test_V3 <- guardaSdtypes_test_V3
  tiposReservados_test_V3 <- guardaTiposReservados_test_V3
  
  
  #########
  #NIVEL 5#
  #########
  
  #zona de preparacion de niveles
  sdtypes_test_V3 <- sdtypes_test_V3[sdtypes_test_V3$o %in% nivel5$nivel5,]
  tiposReservados_test_V3 <- tiposReservados_test_V3[tiposReservados_test_V3$o %in% nivel5$nivel5,]
  
  
  ##zona de evaluacion
  groupby_RecursosReservados <- data.frame(table(tiposReservados_test_V3$s))
  
  tiposReservados_test <- tiposReservados_test_V3[,c(1,3)]
  resultados_test <- sdtypes_test_V3[,c(1,3)]
  
  aciertos_recursos_test <- resultados_test[resultados_test$s %in% tiposReservados_test$s,]
  aciertos_test <- merge(x = aciertos_recursos_test, y = tiposReservados_test, by = "s", all.x = TRUE)
  aciertos_test <- aciertos_test[aciertos_test$o.x == aciertos_test$o.y,]
  
  groupby_Recursos_acertados <- data.frame(table(aciertos_recursos_test$s))
  
  aciertos_test <- aciertos_test[,c(1,2)]
  names(aciertos_test) <- c("s","o")
  
  
  names(groupby_RecursosReservados) <- c("s", "Freq")
  groupby_RecursosReservados$s <- as.character(groupby_RecursosReservados$s)
  if(length(groupby_Recursos_acertados)>1){
    names(groupby_Recursos_acertados) <- c("s", "Freq")
    groupby_Recursos_acertados$s <- as.character(groupby_Recursos_acertados$s)
    
    recursos_fallados <- groupby_RecursosReservados[!(groupby_RecursosReservados$s %in% groupby_Recursos_acertados$s), ]
    
    metrica_precision <- round(nrow(aciertos_test)/nrow(aciertos_recursos_test)*100,2)
    metrica_recall <- round(nrow(aciertos_test)/nrow(tiposReservados_test_V3)*100,2)
    metrica_Fmeasure <- round(2*((metrica_precision*metrica_recall)/(metrica_precision+metrica_recall)),2)
    
    resultados <- rbind(resultados,c("Level5",metrica_precision,metrica_recall,metrica_Fmeasure))
    
    #restaura datos sin sesgar por niveles
    sdtypes_test_V3 <- guardaSdtypes_test_V3
    tiposReservados_test_V3 <- guardaTiposReservados_test_V3
    
    resultados$precision <-as.numeric(resultados$precision)
    resultados$recall <-as.numeric(resultados$recall)
    resultados$fmeasure <-as.numeric(resultados$fmeasure)
  }
  return (resultados)
}


evalua_completo <- function(pathDT_GeneradoCompleto, pathDT_ReservadoCompleto, pathNivelesCompleto, pathSalida){
  
  n0 <- c("nivel0",100,100,100)
  resultados <- data.frame(t(n0))
  colnames(resultados) <- c("measurementCriteria","precision","recall","fmeasure")
  resultados$measurementCriteria <- as.character(resultados$measurementCriteria)
  resultados$precision <- as.character(resultados$precision)
  resultados$recall <- as.character(resultados$recall)
  resultados$fmeasure <-as.character(resultados$fmeasure)
  
  resultados_generalYMedias <- evalua_generalAndMean(pathDT_Generado = pathDT_GeneradoCompleto,
                                                     pathDT_Reservado = pathDT_ReservadoCompleto)
  resultados <- rbind(resultados,resultados_generalYMedias)
  
  resultados_hojas <- evalua_leaves(pathDT_Generado = pathDT_GeneradoCompleto,
                                    pathDT_Reservado = pathDT_ReservadoCompleto,
                                    pathNiveles = pathNivelesCompleto)
  resultados <- rbind(resultados,resultados_hojas)
  
  resultados_niveles <- evalua_levels(pathDT_Generado = pathDT_GeneradoCompleto,
                                      pathDT_Reservado = pathDT_ReservadoCompleto,
                                      pathNiveles = pathNivelesCompleto)
  resultados <- rbind(resultados,resultados_niveles)
  
  
  resultados <- resultados[-1,]
  
  write.table(resultados,file = pathSalida,
              fileEncoding = "UTF-8", row.names=FALSE, quote = FALSE, sep = ",")
  
  return(resultados)
}


#funciones especiales para calcular las medias y desviaciones típicas de un conjunto de evaluaciones

calcula_media_matrices <- function(list_DT){
  large.list <- list_DT
  vec <- unlist(large.list, use.names = FALSE)
  DIM <- dim(large.list[[1]])
  n <- length(large.list)
  
  list.mean <- tapply(vec, rep(1:prod(DIM),times = n), mean)
  attr(list.mean, "dim") <- DIM
  list.mean <- as.data.frame(list.mean)
  
  return(list.mean)
}

calcula_sd_matrices <- function(list_DT){
  large.list <- list_DT
  vec <- unlist(large.list, use.names = FALSE)
  DIM <- dim(large.list[[1]])
  n <- length(large.list)
  
  list.sd <- tapply(vec, rep(1:prod(DIM),times = n), sd)
  attr(list.sd, "dim") <- DIM
  list.sd <- as.data.frame(list.sd)
  
  return(list.sd)
}



