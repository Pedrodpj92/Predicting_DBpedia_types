#preparaDatos_SoloHojas.R



conversion_Matriz <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/objects_properties_typesConditioned_Matrix.csv",
                              header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
colnames(conversion_Matriz) <- conversion_Matriz[1,]
conversion_Matriz <- conversion_Matriz[-1,]
conversion_Matriz[2:ncol(conversion_Matriz)] <- lapply(conversion_Matriz[,2:ncol(conversion_Matriz)], function(x) as.numeric(as.character(x)))


original_types <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/instance_types_en.ttl",
                           header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
original_types$V4 <- NULL
names(original_types) <- c("s","p","o")
original_types$p <- NULL

original_test1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/reserva_test1_semilla123.ttl",
                           header=TRUE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
original_test1$p <- NULL

original_test2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/reserva_test2_semilla123.ttl",
                           header=TRUE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
original_test2$p <- NULL

original_test3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/originals_en39/reserva_test3_semilla123.ttl",
                           header=TRUE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
original_test3$p <- NULL


nivel1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel1.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel2.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel3.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel4 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel4.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel5 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel5.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")
nivel6 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/niveles/nivel6.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8")




soloNivel6 <- original_types[original_types$o %in% nivel6$nivel6, ] #con los datos actuales debería dar vacío o casi vacío

soloNivel5 <- original_types[original_types$o %in% nivel5$nivel5, ]
soloNivel5 <- soloNivel5[!(soloNivel5$s %in% soloNivel6$s), ]

soloNivel4 <- original_types[original_types$o %in% nivel4$nivel4, ]
soloNivel4 <- soloNivel4[!(soloNivel4$s %in% soloNivel5$s), ]
soloNivel4 <- soloNivel4[!(soloNivel4$s %in% soloNivel6$s), ]

soloNivel3 <- original_types[original_types$o %in% nivel3$nivel3, ]
soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel4$s), ]
soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel5$s), ]
soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel6$s), ]

soloNivel2 <- original_types[original_types$o %in% nivel2$nivel2, ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel3$s), ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel4$s), ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel5$s), ]
soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel6$s), ]

soloNivel1 <- original_types[original_types$o %in% nivel1$nivel1, ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel2$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel3$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel4$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel5$s), ]
soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel6$s), ]

hojas_recursosTypes <- rbind(soloNivel1, soloNivel2, soloNivel3, soloNivel4, soloNivel5, soloNivel6)

write.csv(hojas_recursosTypes, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/soloHojas_instanceTypes.ttl", fileEncoding = "UTF-8", row.names=FALSE)

#cambiamos la o de object por la s de subject para facilitar el merge en la función posterior
colnames(conversion_Matriz)[1] <- 's'
learning_Hojas <- merge(x = conversion_Matriz, y = hojas_recursosTypes, by = 's')

colnames(learning_Hojas)[ncol(learning_Hojas)] <- 'Class'
write.csv(learning_Hojas, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/learning_hojas.csv", fileEncoding = "UTF-8", row.names=FALSE)

training <- learning_Hojas[!(learning_Hojas$s %in% original_test1$s),]
training <- training[!(training$s %in% original_test2$s),]
training <- training[!(training$s %in% original_test3$s),]

write.csv(training, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/training.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating_test1 <- learning_Hojas[learning_Hojas$s %in% original_test1$s,]
validating_test2 <- learning_Hojas[learning_Hojas$s %in% original_test2$s,]
validating_test3 <- learning_Hojas[learning_Hojas$s %in% original_test3$s,]

write.csv(validating_test1, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/validating_test1.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test2, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/validating_test2.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(validating_test3, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/validating_test3.csv", fileEncoding = "UTF-8", row.names=FALSE)

validating <- learning_Hojas[!(learning_Hojas$s %in% training$s),]
write.csv(validating, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaHojas/validating_test1_2_3.csv", fileEncoding = "UTF-8", row.names=FALSE)
