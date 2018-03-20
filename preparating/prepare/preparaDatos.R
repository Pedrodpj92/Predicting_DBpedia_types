#preparaDatos.R

#NOTA: traducir todo a inglés, o al menos los comentarios


library(reshape2)



original_resources <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/mappingbased_properties_en.ttl",
                               header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE, quote = "")

#en una iteración más limpia, deberiamos eliminar todo recurso que no pertenezca a la dbpedia,
#pero de momento, es suficiente así para comparar con los resultados anteriores
#original_resources <- original_resources[grep('^<http://dbpedia.org/resource/',original_resources$V1),]
#lo suyo sería no tener en cuenta cualquier predicado que estuviera fuera de la ontología de la dbpedia, pero de momento solo vamos a mirar recursos de la dbpedia
#original_resources <- original_resources[grep('^<http://dbpedia.org/ontology/',original_resources$V2),]
original_resources <- original_resources[grep('^<http://dbpedia.org/resource/',original_resources$V3),]
original_resources$V4 <- NULL
names(original_resources) <- c("s","p","o")
#guarda_original_resources <- original_resources
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
guarda_original_types <- original_types
original_types$s <- as.factor(original_types$s)
original_types$p <- as.factor(original_types$p)
original_types$o <- as.factor(original_types$o)



#Carga de tipos por niveles, cuidado si estamos en la 3.9 o en otra versión
nivel1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel1.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel2.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel3.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel4 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel4.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel5 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel5.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel6 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel6.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)



conversion_Matriz <- original_resources[,c(3,2)]
#tiempo estimado, 20 minutos a media hora (en barajas)
conversion_Matriz <- dcast(conversion_Matriz, o ~ p, fill=0)#ojo, puede tardar bastante
write.csv(conversion_Matriz, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/v2/objects_properties_Matrix.csv", fileEncoding = "UTF-8", row.names=FALSE)
#se almacenan los archivos intermedios cuya obtención pueda suponer más tiempo que la carga

# conversion_Matriz <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/objects_properties_Matrix.csv",
#                                header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
# colnames(conversion_Matriz) <- conversion_Matriz[1,]
# conversion_Matriz <- conversion_Matriz[-1,]
# conversion_Matriz[2:ncol(conversion_Matriz)] <- lapply(conversion_Matriz[,2:ncol(conversion_Matriz)], function(x) as.numeric(as.character(x)))

#cuidado, seguramente si son de tipo factor esto no funcione bien, comprobar
# checking_brithPlace <- conversion_Matriz[(conversion_Matriz$`<http://dbpedia.org/ontology/birthPlace>`) > 0,c(1, grep('<http://dbpedia.org/ontology/birthPlace>', colnames(conversion_Matriz)))]


#elimina recursos objeto sin tipo para poder empezar a formar el conujunto de entrenamiento
recursos_conTipo <- conversion_Matriz[conversion_Matriz$o %in% original_types$s,]
#En la 3.9: unos 1.204.464 recursos objeto, de ellos 864.631 tienen al menos 1 tipo (aparecen en el conjunto de tipos también)
# write.csv(recursos_conTipo, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/objects_properties_typesConditioned_Matrix.csv", fileEncoding = "UTF-8", row.names=FALSE)
#los recursos que no tengan tipo se pueden usar para evaluación manual, o para aprendizaje no supervisado


tipos_todos <- original_types[,c(1,3)]

#Separación de tipos en niveles
tipos_nivel1 <- tipos_todos[tipos_todos$o %in% nivel1$nivel1,]
# write.csv(conversion_Matriz, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/tipos_nivel1.csv", fileEncoding = "UTF-8", row.names=FALSE)
tipos_nivel2 <- tipos_todos[tipos_todos$o %in% nivel2$nivel2,]
# write.csv(conversion_Matriz, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/tipos_nivel2.csv", fileEncoding = "UTF-8", row.names=FALSE)
tipos_nivel3 <- tipos_todos[tipos_todos$o %in% nivel3$nivel3,]
# write.csv(conversion_Matriz, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/tipos_nivel3.csv", fileEncoding = "UTF-8", row.names=FALSE)
tipos_nivel4 <- tipos_todos[tipos_todos$o %in% nivel4$nivel4,]
# write.csv(conversion_Matriz, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/tipos_nivel4.csv", fileEncoding = "UTF-8", row.names=FALSE)
#por pocos datos en principio sólo llegaremos hasta el nivel 4
tipos_nivel5 <- tipos_todos[tipos_todos$o %in% nivel5$nivel5,]
# write.csv(conversion_Matriz, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/tipos_nivel5.csv", fileEncoding = "UTF-8", row.names=FALSE)
tipos_nivel6 <- tipos_todos[tipos_todos$o %in% nivel6$nivel6,]
# write.csv(conversion_Matriz, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/tipos_nivel6.csv", fileEncoding = "UTF-8", row.names=FALSE)

#aquí seguramente haya más de un recurso repetido, tratar con cuidado al usar como clase, una posibilidad es crear niveles artificiales
tipos_resto <- tipos_todos[!(tipos_todos$o %in% nivel1$nivel1),]
tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel2$nivel2),]
tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel3$nivel3),]
tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel4$nivel4),]
tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel5$nivel5),]
tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel6$nivel6),]

colnames(recursos_conTipo)[1] <- "s"

#primer merge inner join para supeditarlo a nivel 1, el resto de niveles añadir desconocidos al hacer right joins
datosObjetivo <- merge(x = recursos_conTipo, y = tipos_nivel1, by = 's')
colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class1"
datosObjetivo$Class1 <- as.character(datosObjetivo$Class1)
datosObjetivo[is.na(datosObjetivo$Class),]$Class1 <- 'desconocido' #para este caso que se ha hecho un inner join no debería haber NA
datosObjetivo$Class1 <- as.factor(datosObjetivo$Class1)

datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel2, by = 's', all.x =  TRUE )
colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class2"
datosObjetivo$Class2 <- as.character(datosObjetivo$Class2)
datosObjetivo[is.na(datosObjetivo$Class2),]$Class2 <- 'desconocido'
datosObjetivo$Class2_Bin <- rep(datosObjetivo$Class2)
datosObjetivo[datosObjetivo$Class2_Bin!="desconocido",]$Class2_Bin <- 'conocido'
datosObjetivo$Class2 <- as.factor(datosObjetivo$Class2)
datosObjetivo$Class2_Bin <- as.factor(datosObjetivo$Class2_Bin)

datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel3, by = 's', all.x =  TRUE )
colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class3"
datosObjetivo$Class3 <- as.character(datosObjetivo$Class3)
datosObjetivo[is.na(datosObjetivo$Class3),]$Class3 <- 'desconocido'
datosObjetivo$Class3_Bin <- rep(datosObjetivo$Class3)
datosObjetivo[datosObjetivo$Class3_Bin!="desconocido",]$Class3_Bin <- 'conocido'
datosObjetivo$Class3 <- as.factor(datosObjetivo$Class3)
datosObjetivo$Class3_Bin <- as.factor(datosObjetivo$Class3_Bin)

datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel4, by = 's', all.x =  TRUE )
colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class4"
datosObjetivo$Class4 <- as.character(datosObjetivo$Class4)
datosObjetivo[is.na(datosObjetivo$Class4),]$Class4 <- 'desconocido'
datosObjetivo$Class4_Bin <- rep(datosObjetivo$Class4)
datosObjetivo[datosObjetivo$Class4_Bin!="desconocido",]$Class4_Bin <- 'conocido'
datosObjetivo$Class4 <- as.factor(datosObjetivo$Class4)
datosObjetivo$Class4_Bin <- as.factor(datosObjetivo$Class4_Bin)

datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel5, by = 's', all.x =  TRUE )
colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class5"
datosObjetivo$Class5 <- as.character(datosObjetivo$Class5)
datosObjetivo[is.na(datosObjetivo$Class5),]$Class5 <- 'desconocido'
datosObjetivo$Class5_Bin <- rep(datosObjetivo$Class5)
datosObjetivo[datosObjetivo$Class5_Bin!="desconocido",]$Class5_Bin <- 'conocido'
datosObjetivo$Class5 <- as.factor(datosObjetivo$Class5)
datosObjetivo$Class5_Bin <- as.factor(datosObjetivo$Class5_Bin)

datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel6, by = 's', all.x =  TRUE )
colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class6"
datosObjetivo$Class6 <- as.character(datosObjetivo$Class6)
datosObjetivo[is.na(datosObjetivo$Class6),]$Class6 <- 'desconocido'
datosObjetivo$Class6_Bin <- rep(datosObjetivo$Class6)
datosObjetivo[datosObjetivo$Class6_Bin!="desconocido",]$Class6_Bin <- 'conocido'
datosObjetivo$Class6 <- as.factor(datosObjetivo$Class6)
datosObjetivo$Class6_Bin <- as.factor(datosObjetivo$Class6_Bin)

write.csv(datosObjetivo, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/v2/learningSet.csv", fileEncoding = "UTF-8", row.names=FALSE)

#siempe, cuidado a la hora de manejar índices
datosObjetivo$auxCountIngoing <- rowSums(datosObjetivo[,2:(ncol(datosObjetivo)-11)])

countingIngoing <- datosObjetivo[,c(1,ncol(datosObjetivo))]
datosObjetivo$auxCountIngoing <- NULL

write.csv(countingIngoing, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/v2/countingIngoings.csv", fileEncoding = "UTF-8", row.names=FALSE)

#REPASAR
#####Cargar conjuntos de validación como de sdtypes y retirarlos para sacar el entrenamiento
# datosReservados_test1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/reserva_test1_semilla123.ttl",
#                                   header=TRUE, sep=",", encoding = "UTF-8")#, stringsAsFactors = FALSE)
# 
# datosReservados_test2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/reserva_test2_semilla123.ttl",
#                                   header=TRUE, sep=",", encoding = "UTF-8")#, stringsAsFactors = FALSE)
# 
# datosReservados_test3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/reserva_test3_semilla123.ttl",
#                                   header=TRUE, sep=",", encoding = "UTF-8")#, stringsAsFactors = FALSE)
# 
# training <- datosObjetivo[!(datosObjetivo$s %in% datosReservados_test1$s),]
# training <- training[!(training$s %in% datosReservados_test2$s),]
# training <- training[!(training$s %in% datosReservados_test3$s),]
# 
# #como hemos quitado 10.000 seguro de >24, deberían quedar unos 10.000 también aquí cuando >24 ya que el conjunto total de >24 es unos 20.000 aprox
# #training$auxCountIngoing <- rowSums(training[,2:(ncol(training)-10)])
# #y funciona bien
# #nrow(training[training$auxCountIngoing > 24,])
# #[1] 10222
# #nrow(training[training$auxCountIngoing > 9,])
# #[1] 38518
# #nrow(training[training$auxCountIngoing > 0,])
# #[1] 851332
# #training$auxCountIngoing <- NULL
# 
# write.csv(training, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# validating_test1 <- datosObjetivo[datosObjetivo$s %in% datosReservados_test1$s,]
# write.csv(validating_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test1.csv", fileEncoding = "UTF-8", row.names=FALSE)
# validating_test2 <- datosObjetivo[datosObjetivo$s %in% datosReservados_test2$s,]
# write.csv(validating_test2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test2.csv", fileEncoding = "UTF-8", row.names=FALSE)
# validating_test3 <- datosObjetivo[datosObjetivo$s %in% datosReservados_test3$s,]
# write.csv(validating_test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# #juntos
# validating <- datosObjetivo[!(datosObjetivo$s %in% training$s),]
# write.csv(validating, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test1_2_3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# 
# 
# 
# 
# ####Eliminando desconocidos de nivel 2
# training_sinDesc_N2 <- training[training$Class2 != "desconocido",]
# write.csv(training_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N2.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# validating_sinDesc_N2 <- validating[validating$Class2 != "desconocido",]
# write.csv(validating_sinDesc_N2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N2.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# training_sinDesc_N3 <- training[training$Class3 != "desconocido",]
# write.csv(training_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# validating_sinDesc_N3 <- validating[validating$Class3 != "desconocido",]
# write.csv(validating_sinDesc_N3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N3.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# training_sinDesc_N4 <- training[training$Class4 != "desconocido",]
# write.csv(training_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N4.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# validating_sinDesc_N4 <- validating[validating$Class4 != "desconocido",]
# write.csv(validating_sinDesc_N4, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N4.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# training_sinDesc_N5 <- training[training$Class5 != "desconocido",]
# write.csv(training_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N5.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# validating_sinDesc_N5 <- validating[validating$Class5 != "desconocido",]
# write.csv(validating_sinDesc_N5, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N5.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# training_sinDesc_N6 <- training[training$Class6 != "desconocido",]
# write.csv(training_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N6.csv", fileEncoding = "UTF-8", row.names=FALSE)
# 
# validating_sinDesc_N6 <- validating[validating$Class6 != "desconocido",]
# write.csv(validating_sinDesc_N6, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N6.csv", fileEncoding = "UTF-8", row.names=FALSE)



