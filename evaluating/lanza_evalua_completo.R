#lanza_evalua_completo.R
#script que llama a evalua_completo.R para realizar las evaluaciones


source(file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/Genera_testHeiko/evalua_completo.R")


pathNiveles38 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/"
pathNiveles39 <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/R_visualizacionDBPedia/niveles/ramas39/"
#también valdría para la 3.9 /opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/

test1 <- "test1"
test2 <- "test2"
test3 <- "test3"
test4 <- "test4"
test5 <- "test5"
test10 <- "test10"
test25 <- "test25"

dl <- "_dl"
rf <- "_rf"
ttl <- ".ttl"
csv <- ".csv"


path38FiveFold <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/output/data/usingEn38Version/approach2/fiveFold/"
path39FiveFold <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/data/approach2/fiveFold/"
path39Normal <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/output/data/approach2/"


pathReservado1 <- "/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/reservaTipos/reserva_test1_semilla123.ttl"
pathReservado10 <- "/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/reservaTipos/reserva_test2_semilla123.ttl"
pathReservado25 <- "/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/reservaTipos/reserva_test3_semilla123.ttl"

pathReservado38FiveFold <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/data/approaches2and3/fiveFold/"
pathReservado39FiveFold <- "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/data/approaches2and3/fiveFold/"

reservado <- "reservatest.ttl"

nombreFichero <- "evaluacion"


#Version 39
#test1
evalua_completo(pathDT_GeneradoCompleto = paste(path39Normal,test1,"/",test1,dl,ttl,sep=""),
                pathDT_ReservadoCompleto = pathReservado1,
                pathNivelesCompleto = pathNiveles39,
                pathSalida = paste(path39Normal,test1,"/",nombreFichero,"_",test1,dl,csv,sep=""))

evalua_completo(pathDT_GeneradoCompleto = paste(path39Normal,test1,"/",test1,rf,ttl,sep=""),
                pathDT_ReservadoCompleto = pathReservado1,
                pathNivelesCompleto = pathNiveles39,
                pathSalida = paste(path39Normal,test1,"/",nombreFichero,"_",test1,rf,csv,sep=""))


#test10
evalua_completo(pathDT_GeneradoCompleto = paste(path39Normal,test10,"/",test10,dl,ttl,sep=""),
                pathDT_ReservadoCompleto = pathReservado10,
                pathNivelesCompleto = pathNiveles39,
                pathSalida = paste(path39Normal,test10,"/",nombreFichero,"_",test10,dl,csv,sep=""))

evalua_completo(pathDT_GeneradoCompleto = paste(path39Normal,test10,"/",test10,rf,ttl,sep=""),
                pathDT_ReservadoCompleto = pathReservado10,
                pathNivelesCompleto = pathNiveles39,
                pathSalida = paste(path39Normal,test10,"/",nombreFichero,"_",test10,rf,csv,sep=""))

#test25
evalua_completo(pathDT_GeneradoCompleto = paste(path39Normal,test25,"/",test25,dl,ttl,sep=""),
                pathDT_ReservadoCompleto = pathReservado25,
                pathNivelesCompleto = pathNiveles39,
                pathSalida = paste(path39Normal,test25,"/",nombreFichero,"_",test25,dl,csv,sep=""))

evalua_completo(pathDT_GeneradoCompleto = paste(path39Normal,test25,"/",test25,rf,ttl,sep=""),
                pathDT_ReservadoCompleto = pathReservado25,
                pathNivelesCompleto = pathNiveles39,
                pathSalida = paste(path39Normal,test25,"/",nombreFichero,"_",test25,rf,csv,sep=""))



#fiveFold 3.8
#fold1
fold1_dl_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test1,"/",test1,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test1,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test1,"/",nombreFichero,"_",test1,dl,csv,sep=""))

fold1_rf_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test1,"/",test1,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test1,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test1,"/",nombreFichero,"_",test1,rf,csv,sep=""))


#fold2
fold2_dl_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test2,"/",test2,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test2,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test2,"/",nombreFichero,"_",test2,dl,csv,sep=""))

fold2_rf_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test2,"/",test2,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test2,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test2,"/",nombreFichero,"_",test2,rf,csv,sep=""))


#fold3
fold3_dl_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test3,"/",test3,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test3,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test3,"/",nombreFichero,"_",test3,dl,csv,sep=""))

fold3_rf_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test3,"/",test3,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test3,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test3,"/",nombreFichero,"_",test3,rf,csv,sep=""))


#fold4
fold4_dl_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test4,"/",test4,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test4,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test4,"/",nombreFichero,"_",test4,dl,csv,sep=""))

fold4_rf_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test4,"/",test4,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test4,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test4,"/",nombreFichero,"_",test4,rf,csv,sep=""))


#fold5
fold5_dl_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test5,"/",test5,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test5,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test5,"/",nombreFichero,"_",test5,dl,csv,sep=""))

fold5_rf_38 <- evalua_completo(pathDT_GeneradoCompleto = paste(path38FiveFold,test5,"/",test5,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado38FiveFold,test5,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path38FiveFold,test5,"/",nombreFichero,"_",test5,rf,csv,sep=""))

fold1_dl_38[2:4] <- lapply(fold1_dl_38[,2:4], function(x) as.numeric(as.character(x)))
fold2_dl_38[2:4] <- lapply(fold2_dl_38[,2:4], function(x) as.numeric(as.character(x)))
fold3_dl_38[2:4] <- lapply(fold3_dl_38[,2:4], function(x) as.numeric(as.character(x)))
fold4_dl_38[2:4] <- lapply(fold4_dl_38[,2:4], function(x) as.numeric(as.character(x)))
fold5_dl_38[2:4] <- lapply(fold5_dl_38[,2:4], function(x) as.numeric(as.character(x)))

lista_5fold_dl_38 <- list(fold1_dl_38[2:4],fold2_dl_38[2:4],fold3_dl_38[2:4],fold4_dl_38[2:4],fold5_dl_38[2:4])

medias_dl_38 <- Reduce('+', lista_5fold_dl_38)/5
write.table(medias_dl_38,file = paste(path38FiveFold,"evaluacion_Fold_Medias_dl.csv",sep=""),
            fileEncoding = "UTF-8", row.names=FALSE, quote = FALSE, sep = ",")

fold1_rf_38[2:4] <- lapply(fold1_rf_38[,2:4], function(x) as.numeric(as.character(x)))
fold2_rf_38[2:4] <- lapply(fold2_rf_38[,2:4], function(x) as.numeric(as.character(x)))
fold3_rf_38[2:4] <- lapply(fold3_rf_38[,2:4], function(x) as.numeric(as.character(x)))
fold4_rf_38[2:4] <- lapply(fold4_rf_38[,2:4], function(x) as.numeric(as.character(x)))
fold5_rf_38[2:4] <- lapply(fold5_rf_38[,2:4], function(x) as.numeric(as.character(x)))

lista_5fold_rf_38 <- list(fold1_rf_38[2:4],fold2_rf_38[2:4],fold3_rf_38[2:4],fold4_rf_38[2:4],fold5_rf_38[2:4])

medias_rf_38 <- Reduce('+', lista_5fold_rf_38)/5
write.table(medias_rf_38,file = paste(path38FiveFold,"evaluacion_Fold_Medias_rf.csv",sep=""),
            fileEncoding = "UTF-8", row.names=FALSE, quote = FALSE, sep = ",")



#fiveFold 3.9
#fold1
fold1_dl_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test1,"/",test1,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test1,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test1,"/",nombreFichero,"_",test1,dl,csv,sep=""))

fold1_rf_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test1,"/",test1,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test1,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test1,"/",nombreFichero,"_",test1,rf,csv,sep=""))


#fold2
fold2_dl_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test2,"/",test2,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test2,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test2,"/",nombreFichero,"_",test2,dl,csv,sep=""))

fold2_rf_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test2,"/",test2,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test2,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test2,"/",nombreFichero,"_",test2,rf,csv,sep=""))


#fold3
fold3_dl_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test3,"/",test3,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test3,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test3,"/",nombreFichero,"_",test3,dl,csv,sep=""))

fold3_rf_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test3,"/",test3,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test3,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test3,"/",nombreFichero,"_",test3,rf,csv,sep=""))


#fold4
fold4_dl_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test4,"/",test4,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test4,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test4,"/",nombreFichero,"_",test4,dl,csv,sep=""))

fold4_rf_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test4,"/",test4,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test4,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test4,"/",nombreFichero,"_",test4,rf,csv,sep=""))


#fold5
fold5_dl_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test5,"/",test5,dl,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test5,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test5,"/",nombreFichero,"_",test5,dl,csv,sep=""))

fold5_rf_39 <- evalua_completo(pathDT_GeneradoCompleto = paste(path39FiveFold,test5,"/",test5,rf,ttl,sep=""),
                               pathDT_ReservadoCompleto = paste(pathReservado39FiveFold,test5,"/",reservado,sep=""),
                               pathNivelesCompleto = pathNiveles39,
                               pathSalida = paste(path39FiveFold,test5,"/",nombreFichero,"_",test5,rf,csv,sep=""))




fold1_dl_39[2:4] <- lapply(fold1_dl_39[,2:4], function(x) as.numeric(as.character(x)))
fold2_dl_39[2:4] <- lapply(fold2_dl_39[,2:4], function(x) as.numeric(as.character(x)))
fold3_dl_39[2:4] <- lapply(fold3_dl_39[,2:4], function(x) as.numeric(as.character(x)))
fold4_dl_39[2:4] <- lapply(fold4_dl_39[,2:4], function(x) as.numeric(as.character(x)))
fold5_dl_39[2:4] <- lapply(fold5_dl_39[,2:4], function(x) as.numeric(as.character(x)))

lista_5fold_dl_39 <- list(fold1_dl_39[2:4],fold2_dl_39[2:4],fold3_dl_39[2:4],fold4_dl_39[2:4],fold5_dl_39[2:4])

medias_dl_39 <- Reduce('+', lista_5fold_dl_39)/5
write.table(medias_dl_39,file = paste(path39FiveFold,"evaluacion_Fold_Medias_dl.csv",sep=""),
            fileEncoding = "UTF-8", row.names=FALSE, quote = FALSE, sep = ",")

fold1_rf_39[2:4] <- lapply(fold1_rf_39[,2:4], function(x) as.numeric(as.character(x)))
fold2_rf_39[2:4] <- lapply(fold2_rf_39[,2:4], function(x) as.numeric(as.character(x)))
fold3_rf_39[2:4] <- lapply(fold3_rf_39[,2:4], function(x) as.numeric(as.character(x)))
fold4_rf_39[2:4] <- lapply(fold4_rf_39[,2:4], function(x) as.numeric(as.character(x)))
fold5_rf_39[2:4] <- lapply(fold5_rf_39[,2:4], function(x) as.numeric(as.character(x)))

lista_5fold_rf_39 <- list(fold1_rf_39[2:4],fold2_rf_39[2:4],fold3_rf_39[2:4],fold4_rf_39[2:4],fold5_rf_39[2:4])

medias_rf_39 <- Reduce('+', lista_5fold_rf_39)/5
write.table(medias_rf_39,file = paste(path39FiveFold,"evaluacion_Fold_Medias_rf.csv",sep=""),
            fileEncoding = "UTF-8", row.names=FALSE, quote = FALSE, sep = ",")

