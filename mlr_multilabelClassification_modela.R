#version para clasificación multietiqueta con mlr
library(reshape2)
library(mlr)
library(randomForestSRC)
library(rFerns)


#prepara datos
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


conversion_Matriz_Tipos <- original_types[,c(1,3)]
conversion_Matriz_Tipos <- dcast(conversion_Matriz_Tipos, s ~ o, fun.aggregate = length, fill=0)

#EjemploConteo de tipos
#sum(conversion_Matriz_Tipos$`<http://dbpedia.org/ontology/Person>`)

write.csv(conversion_Matriz_Tipos, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/instance_types_Matrix.csv", fileEncoding = "UTF-8", row.names=FALSE)




#df_training <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training.csv",
#                        header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
#colnames(df_training) <- df_training[1,]
#df_training <- df_training[-1,]
#df_training[,c(2:(ncol(df_training)-11))] <- sapply(df_training[,c(2:(ncol(df_training)-11))], as.numeric)

#df_validating <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test1_2_3.csv",
#                          header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
#colnames(df_validating) <- df_validating[1,]
#df_validating <- df_validating[-1,]
#df_validating[,c(2:(ncol(df_validating)-11))] <- sapply(df_validating[,c(2:(ncol(df_validating)-11))], as.numeric)


df_training <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training.csv",
                        header=TRUE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
#colnames(df_training) <- df_training[1,]
#df_training <- df_training[-1,]
df_training[,c(2:(ncol(df_training)-11))] <- sapply(df_training[,c(2:(ncol(df_training)-11))], as.numeric)

df_validating <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test1_2_3.csv",
                          header=TRUE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
#colnames(df_validating) <- df_validating[1,]
#df_validating <- df_validating[-1,]
df_validating[,c(2:(ncol(df_validating)-11))] <- sapply(df_validating[,c(2:(ncol(df_validating)-11))], as.numeric)

#ya no nos interesan las categoricas como tal, sino solo transformadas como binomiales

df_training$Class1 <- NULL
df_training$Class2 <- NULL
df_training$Class2_Bin <- NULL
df_training$Class3 <- NULL
df_training$Class3_Bin <- NULL
df_training$Class4 <- NULL
df_training$Class4_Bin <- NULL
df_training$Class5 <- NULL
df_training$Class5_Bin <- NULL
df_training$Class6 <- NULL
df_training$Class6_Bin <- NULL

df_validating$Class1 <- NULL
df_validating$Class2 <- NULL
df_validating$Class2_Bin <- NULL
df_validating$Class3 <- NULL
df_validating$Class3_Bin <- NULL
df_validating$Class4 <- NULL
df_validating$Class4_Bin <- NULL
df_validating$Class5 <- NULL
df_validating$Class5_Bin <- NULL
df_validating$Class6 <- NULL
df_validating$Class6_Bin <- NULL




df_clases <- read.csv(file="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/instance_types_Matrix.csv",
                      header=TRUE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
#colnames(df_clases) <- df_clases[1,]
#df_clases <- df_clases[-1,]
df_clases[,c(2:ncol(df_clases))] <- sapply(df_clases[,c(2:ncol(df_clases))], as.numeric)
df_clases[,c(2:ncol(df_clases))] <- sapply(df_clases[,c(2:ncol(df_clases))], as.logical)



df_training_binarizado <- merge(x = df_training, y = df_clases, by = 's')
df_validating_binarizado <- merge(x = df_validating, y = df_clases, by = 's')





yeast <- rbind(df_training_binarizado, df_validating_binarizado)
#nrow(df_training) == 833,703
#nrow(df_validating) == 27,627
#nrow(yeast) == 861,330
write.csv(yeast, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaMLR/mlr_completo.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(df_training_binarizado, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaMLR/mlr_training.csv", fileEncoding = "UTF-8", row.names=FALSE)
write.csv(df_validating, file = "/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/pruebaMLR/mlr_validating.csv", fileEncoding = "UTF-8", row.names=FALSE)

#yeast = getTaskData(yeast.task)
#labels = colnames(yeast)[1:14]
labels = colnames(df_clases)[2:ncol(df_clases)]
#yeast[,ncol(yeast)-10] <- as.factor(yeast[,ncol(yeast)-10])
#yeast[,ncol(yeast)-9] <- as.factor(yeast[,ncol(yeast)-9])
#yeast[,ncol(yeast)-8] <- as.factor(yeast[,ncol(yeast)-8])
#yeast[,ncol(yeast)-7] <- as.factor(yeast[,ncol(yeast)-7])
#yeast[,ncol(yeast)-6] <- as.factor(yeast[,ncol(yeast)-6])
#yeast[,ncol(yeast)-5] <- as.factor(yeast[,ncol(yeast)-5])
#yeast[,ncol(yeast)-4] <- as.factor(yeast[,ncol(yeast)-4])
#yeast[,ncol(yeast)-3] <- as.factor(yeast[,ncol(yeast)-3])
#yeast[,ncol(yeast)-2] <- as.factor(yeast[,ncol(yeast)-2])
#yeast[,ncol(yeast)-1] <- as.factor(yeast[,ncol(yeast)-1])
#yeast[,ncol(yeast)] <- as.factor(yeast[,ncol(yeast)])
yeast.task = makeMultilabelTask(id = "multi", data = yeast[,2:ncol(yeast)], target = labels) 
yeast.task 
lrn.rfsrc = makeLearner("multilabel.randomForestSRC") 
lrn.rFerns = makeLearner("multilabel.rFerns") 
lrn.rFerns 
lrn.br = makeLearner("classif.rpart", predict.type = "prob") 
lrn.br = makeMultilabelBinaryRelevanceWrapper(lrn.br) 
lrn.br 

lrn.br2 = makeMultilabelBinaryRelevanceWrapper("classif.rpart") 
lrn.br2 
#mod = train(lrn.br, yeast.task) 
mod = train(lrn.br, yeast.task, subset = 1:833703)#, weights = rep(1/1500, 1500)) 
mod 

#mod2 = train(lrn.rfsrc, yeast.task, subset = 1:100) 
mod2 = train(lrn.rfsrc, yeast.task, subset = 1:833703) 
mod2 
#pred = predict(mod, task = yeast.task, subset = 1:10) 
pred = predict(mod, newdata = yeast[833704:861330,]) 
names(as.data.frame(pred)) 

pred2 = predict(mod2, newdata = yeast[833703:861330,]) 
names(as.data.frame(pred2)) 
performance(pred) 

performance(pred2, measures = list(multilabel.subset01, multilabel.hamloss, multilabel.acc, 
                                   multilabel.f1, timepredict)) 

listMeasures("multilabel") 
rdesc = makeResampleDesc(method = "CV", stratify = FALSE, iters = 3) 
r = resample(learner = lrn.br, task = yeast.task, resampling = rdesc, show.info = FALSE) 
#r 

r2 = resample(learner = lrn.rFerns, task = yeast.task, resampling = rdesc, show.info = FALSE) 
#r2
getMultilabelBinaryPerformances(pred, measures = list(acc, mmce, auc)) 

getMultilabelBinaryPerformances(r$pred, measures = list(acc, mmce))

