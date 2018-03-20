#preparaDatos_En38.R


library(reshape2)

original_resources <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/originals/mappingbased_properties_en.ttl",
                               header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE, quote = "")
original_resources <- original_resources[grep('^<http://dbpedia.org/resource/',original_resources$V3),]
original_resources$V4 <- NULL
names(original_resources) <- c("s","p","o")
original_resources$s <- as.factor(original_resources$s)
original_resources$p <- as.factor(original_resources$p)
original_resources$o <- as.factor(original_resources$o)

original_types <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/originals/instance_types_en.ttl",
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

nivel1 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel1.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel2 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel2.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel3 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel3.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel4 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel4.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel5 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel5.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
nivel6 <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/codeToESWC2018_reviewers/usingEn38Version/niveles/nivel6.csv",
                   header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)



conversion_Matriz <- original_resources[,c(3,2)]
conversion_Matriz <- dcast(conversion_Matriz, o ~ p, fill=0)#ojo, puede tardar bastante
write.csv(conversion_Matriz, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/usingEn38Version/objects_properties_Matrix.csv", fileEncoding = "UTF-8", row.names=FALSE)

recursos_conTipo <- conversion_Matriz[conversion_Matriz$o %in% original_types$s,]
tipos_todos <- original_types[,c(1,3)]

#Separación de tipos en niveles
tipos_nivel1 <- tipos_todos[tipos_todos$o %in% nivel1$nivel1,]
tipos_nivel2 <- tipos_todos[tipos_todos$o %in% nivel2$nivel2,]
tipos_nivel3 <- tipos_todos[tipos_todos$o %in% nivel3$nivel3,]
tipos_nivel4 <- tipos_todos[tipos_todos$o %in% nivel4$nivel4,]
tipos_nivel5 <- tipos_todos[tipos_todos$o %in% nivel5$nivel5,]
tipos_nivel6 <- tipos_todos[tipos_todos$o %in% nivel6$nivel6,]


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

write.csv(datosObjetivo, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/usingEn38Version/learningSet.csv", fileEncoding = "UTF-8", row.names=FALSE)

#siempe, cuidado a la hora de manejar índices
datosObjetivo$auxCountIngoing <- rowSums(datosObjetivo[,2:(ncol(datosObjetivo)-11)])

countingIngoing <- datosObjetivo[,c(1,ncol(datosObjetivo))]
datosObjetivo$auxCountIngoing <- NULL

write.csv(countingIngoing, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/ISWC2018/usingEn38Version/countingIngoings.csv", fileEncoding = "UTF-8", row.names=FALSE)



