#a partir de instance_types_transitive y mappingbased_objects_uncleaned genera dos archivos cuyo contenido es la división de instance_types_transitive
#El primero contiene los tipos y recursos reservados para la posterior comprobación con el archivo sdtypes y el segundo de los generados
#es el archivo de instance_types_transitive al que se le han retirado los tipos reservados.
library(sqldf)

#original_types <- read.csv(file="/opt/files/proyectoHeiko_adaptado/instance_types_transitive_es.ttl",
#                           header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
#versión inglesa
#original_types <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/R_visualizacionDBPedia/inputData/instance_types_transitive_en.ttl",
#                           header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
original_types <- read.csv(file="/opt/files/proyectoHeiko_adaptado/version39/instance_types_en.ttl",
                           header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)

#prueba de búsqueda, en ese rango hay BAD URI's marcadas y hay que eliminarlas, con la otra instrucción se arreglan, mirar en la versión inglesa 3.9
#busqueda1 <- original_types[7024300:7024400,]
#pruebaLimpieza1 <- busqueda1[grep('^<http://dbpedia.org/resource/',busqueda1$V1),]
filtrado1 <- original_types[grep('^<http://dbpedia.org/resource/',original_types$V1),]
original_types <- filtrado1
original_types$V4 <- NULL
names(original_types) <- c("s","p","o")

#original_resources <- read.csv(file="/opt/files/proyectoHeiko_adaptado/mappingbased_objects_uncleaned_es.ttl",
#                               header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
#versión inglesa
#original_resources <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/R_visualizacionDBPedia/inputData/mappingbased_objects_uncleaned_en.ttl",
#                               header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
original_resources <- read.csv(file="/opt/files/proyectoHeiko_adaptado/version39/mappingbased_properties_en.ttl",
                               header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
filtrado2 <- original_resources[grep('^<http://dbpedia.org/resource/',original_resources$V1),]
filtrado2_2 <- filtrado2[grep('^<http://dbpedia.org/resource/',filtrado2$V3),]
original_resources <- filtrado2_2
original_resources$V4 <- NULL
names(original_resources) <- c("s","p","o")

todos_recursos <- data.frame(table(original_resources$o))
todos_recursos$Var1 <- as.character(todos_recursos$Var1)

#test 1, >0 // test 2, >9, // test 3, >24
total_recursos_test <- todos_recursos[todos_recursos$Freq>0,]

names(total_recursos_test) <- c("s","Freq")

todos_recursos_con_tipos <- sqldf("SELECT total_recursos_test.s FROM total_recursos_test, original_types WHERE total_recursos_test.s == original_types.s GROUP BY total_recursos_test.s")

todos_tipos_test <- sqldf("SELECT original_types.s, original_types.p, original_types.o FROM original_types, todos_recursos_con_tipos WHERE original_types.s = todos_recursos_con_tipos.s")

#todos los recursos con tipos pertenecen a es.dbpedia
#parseo_esDBpedia <- todos_recursos_con_tipos[grep('^<http://es.dbpedia.org/resource/',todos_recursos_con_tipos$s),]
parseo_enDBpedia <- todos_recursos_con_tipos[grep('^<http://dbpedia.org/resource/',todos_recursos_con_tipos$s),]

set.seed(123)
reserva_test <- todos_recursos_con_tipos[sample(x = nrow(todos_recursos_con_tipos), size = 10000, replace = FALSE),]
##NUEVO EXPERIMENTO, busqueda de proporción como en dbpedia inglesa, reservar sólo 2.540 triples, según proporción del total de datos
#reserva_test <- todos_recursos_con_tipos[ sample(x = nrow(todos_recursos_con_tipos), size = 2540 , replace = FALSE),]
reserva_test <- as.data.frame(reserva_test)
names(reserva_test) <- c("s")
reserva_test$s <- as.character(reserva_test$s)

tipos_test <- sqldf("SELECT todos_tipos_test.s, todos_tipos_test.p, todos_tipos_test.o FROM todos_tipos_test, reserva_test WHERE todos_tipos_test.s==reserva_test.s GROUP BY todos_tipos_test.s, todos_tipos_test.p, todos_tipos_test.o")

limpia_typesReservados <- tipos_test[grep('^<http://dbpedia.org/resource/',tipos_test$s),]
limpia_typesReservados <- limpia_typesReservados[grep('^<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>',limpia_typesReservados$p),]


#DEPENDIENTE DE LA VERSIÓN, FIJARSE EN EL NOBMRE DE SALIDA
#write.csv(tipos_test, file = "/opt/files/proyectoHeiko_adaptado/Reservados_types_test1_en_V4.ttl", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(tipos_test, file = "/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/reservaTipos/reserva_test1_semilla123.ttl", fileEncoding = "UTF-8", row.names=FALSE)

instance_types_test_V3 <- sqldf("SELECT * FROM original_types EXCEPT SELECT * FROM tipos_test")

#limpia_types <- instance_types_test_V3[grep('^<http://dbpedia.org/resource/',instance_types_test_V3$s),]
#errores1 <- sqldf("SELECT * FROM instance_types_test_V3 EXCEPT SELECT * FROM limpia_types")
#limpia_types <- limpia_types[grep('^<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>',limpia_types$p),]

#write.csv(instance_types_test_V3, file = "/opt/files/proyectoHeiko_adaptado/types_test1_en_V4.ttl", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(instance_types_test_V3, file = "/opt/files/proyectoHeiko_adaptado/version39/pruebasNuevas/instanceTypes_inputs/types_test1_semilla123.ttl", fileEncoding = "UTF-8", row.names=FALSE)
#save.image("backupDatos_generarTest2_en_V4.RData")

