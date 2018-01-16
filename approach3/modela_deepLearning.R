#modela.R


library(h2o)
#library(reshape2)
#library(randomForest)
#library(caret)
h2o.init(
  nthreads=-1            ## -1: use all available threads
  #max_mem_size = "2G"
)
h2o.removeAll()


#carga datos escritos desde preparaDatos.R
df_training <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training.csv"), header = TRUE)
df_validating <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test1_2_3.csv"), header = TRUE)

#carga de conjuntos por niveles para contar o no desconocidos
df_training_sinDesc_N2 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N2.csv"), header = TRUE)
df_validating_sinDesc_N2 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N2.csv"), header = TRUE)
df_training_sinDesc_N3 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N3.csv"), header = TRUE)
df_validating_sinDesc_N3 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N3.csv"), header = TRUE)
df_training_sinDesc_N4 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N4.csv"), header = TRUE)
df_validating_sinDesc_N4 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N4.csv"), header = TRUE)
df_training_sinDesc_N5 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N5.csv"), header = TRUE)
df_validating_sinDesc_N5 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N5.csv"), header = TRUE)
df_training_sinDesc_N6 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/training_sinDesc_N6.csv"), header = TRUE)
df_validating_sinDesc_N6 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_sinDesc_N6.csv"), header = TRUE)


#estos quizas se añadan solo para validacion
#df_validating_test1 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test1.csv"), header = TRUE)
#df_validating_test2 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test2.csv"), header = TRUE)
#df_validating_test3 <- h2o.importFile(path = normalizePath("/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/inputData/divisionSDtypes/validating_test3.csv"), header = TRUE)


#asignaciones
train <- h2o.assign(df_training, "train.hex") 
valid <- h2o.assign(df_validating, "valid.hex")

train_sinDesc_N2 <- h2o.assign(df_training_sinDesc_N2, "train_sinDesc_N2.hex") 
valid_sinDesc_N2 <- h2o.assign(df_validating_sinDesc_N2, "valid_sinDesc_N2.hex")
train_sinDesc_N3 <- h2o.assign(df_training_sinDesc_N3, "train_sinDesc_N3.hex") 
valid_sinDesc_N3 <- h2o.assign(df_validating_sinDesc_N3, "valid_sinDesc_N3.hex")
train_sinDesc_N4 <- h2o.assign(df_training_sinDesc_N4, "train_sinDesc_N4.hex") 
valid_sinDesc_N4 <- h2o.assign(df_validating_sinDesc_N4, "valid_sinDesc_N4.hex")
train_sinDesc_N5 <- h2o.assign(df_training_sinDesc_N5, "train_sinDesc_N5.hex") 
valid_sinDesc_N5 <- h2o.assign(df_validating_sinDesc_N5, "valid_sinDesc_N5.hex")
train_sinDesc_N6 <- h2o.assign(df_training_sinDesc_N6, "train_sinDesc_N6.hex") 
valid_sinDesc_N6 <- h2o.assign(df_validating_sinDesc_N6, "valid_sinDesc_N6.hex")


#valid_test1 <- h2o.assign(df_validating_test1, "valid_test1.hex")
#valid_test2 <- h2o.assign(df_validating_test2, "valid_test2.hex")
#valid_test3 <- h2o.assign(df_validating_test3, "valid_test3.hex")


#rf_nivel1 <- h2o.randomForest(
#  training_frame = train,
#  validation_frame = valid,
#  x=3:(ncol(train)-1), #es necesario probar si tenemos en cuenta los propios recursos o no, 
#  #puesto que se podrían considerar identificadores, y por lo tanto, no válidos para aprender
#  y=ncol(train),
#  model_id = "rf_nivel1_V1",
#  ntrees = 200,
#  max_depth = 40,
#  stopping_rounds = 2,
#  balance_classes = FALSE,
#  score_each_iteration = T,
#  seed = 1234)

#dl_nivel1_v3 <- h2o.deeplearning(
dl_nivel1_v2 <- h2o.deeplearning(
  #model_id="dl_nivel1_v3_cv",#cambiar más adelante por dl_n1_m1
  model_id="dl_nivel1_v2",#cambiar más adelante por dl_n1_m1
  training_frame=train, 
  validation_frame=valid[,2:(ncol(valid)-10)],   ## validation dataset: used for scoring and early stopping
  #nfolds = 10,
  x=2:(ncol(train)-11), #MUY MUY importante, fijarse en los índices, que esten las columnas correctas
  y=(ncol(train)-10),
  #activation="Rectifier",  ## default
  #hidden=c(200,200),       ## default: 2 hidden layers with 200 neurons each
  #epochs=10,
  #variable_importances=T,    ## not enabled by default
  #reproducible = TRUE,
  stopping_rounds = 0,
  seed = 1234)

#solo para exploracion manual, cambiar y usar en cada modelo que se quiera explorar
#summary(dl_nivel1_v1)
#valMet_dl_nivel1_v1 <- dl_nivel1_v1@model$validation_metrics
#valMet_dl_nivel1_dt_v1 <- data.frame(valMet_dl_nivel1_v1@metrics$cm$table)
#entMet_dl_nivel1_v1 <- dl_nivel1_v1@model$training_metrics
#entMet_dl_nivel1_dt_v1 <- data.frame(valMet_dl_nivel1_v1@metrics$cm$table)
#dl_nivel1_v1_confusionMatrix <- h2o.confusionMatrix(dl_nivel1_v1)

h2o.saveModel(dl_nivel1_v2, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1")


#estructura de modelado de cada nivel
#1ro) modelado binario, solo distingue si un recurso debería tener o no tipo a dicho nivel.
#    #se debería entrenar con el conjunto entero
#2do) modelado multinomial incluyendo desconocidos e independiente, sin añadir niveles anteriores como predictores
#    #se selecciona con el conjunto entero (filas) y solo ingoings para predictores (columnas)
#3ro) modelado multinomial sin incluir desconocidos e independiente, sin añadir los niveles anteriores como predictores
#    #se debería coger el conjunto de entrenamiento propio conseguido de su nivel en preparaDatos.R
#4to) modelado multinomial sin incluir desconocidos y encadenando niveles de clase anteriores
#    #se debería coger el conjunto de entrenamiento propio conseguido de su nivel en preparaDatos.R
#5to EXTRA) modelado multinomial incluyendo desconocidos y encadenando niveles de clase anteriores (sin implementar aún)
#    #se debería entrenar con el conjunto entero. Este se deja para más adelante

#según diseño si los resultados son los esperados, se utilizarán el 1ro y el 4to para las predicciones
#el primer modelo de un nivel decidirá si un recurso deberá tener o no tipo 
#el cuarto modelo de un nivel asigna tipo aprendiendo de ingoings y sus niveles superiores

#podría ser muy interesante los casos en los que frente a desconocidos originales genere un tipo
#ver cómo varían desde modelos entrenados con desconocidos y en los que no.
#esta parte cuando se haya realizado lo demás
#cuando se tenga la tabla entera de esto, repetir con random forest


###Nivel 2

#modelo 1: diferenciación binaria sobre si debería o no tener asignado un tipo
dl_n2_m1 <- h2o.deeplearning(
  model_id="dl_n2_m1", 
  training_frame=train, 
  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-8))],
  x=2:(ncol(train)-11),
  y=(ncol(train)-8),
  stopping_rounds = 0,
  seed = 1234)
#summary(dl_n2_m1)
h2o.saveModel(dl_n2_m1, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1")

#modelo 2: diferenciación de tipos incluyendo desconocidos e independiente a niveles anteriores
#dl_n2_m2 <- h2o.deeplearning(
#  model_id="dl_n2_m2", 
#  training_frame=train, 
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-9))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-9),
#  stopping_rounds = 0,
#  seed = 1234)
#summary(dl_n2_m2)

#modelo 3: difereniación de tipos entrenando sin desconocidos e independiente a niveles anteriores
#dl_n2_m3 <- h2o.deeplearning(
#  model_id="dl_n2_m3", 
#  training_frame=train_sinDesc_N2, 
#  validation_frame=valid_sinDesc_N2[,c(2:(ncol(valid_sinDesc_N2)-11),(ncol(valid_sinDesc_N2)-9))],
#  x=2:(ncol(train_sinDesc_N2)-11),
#  y=(ncol(train_sinDesc_N2)-9),
#  stopping_rounds = 0,
#  seed = 1234)
#summary(dl_n2_m3)


#modelo 4: diferenciación de tipos entrenando sin desconocidos y encadenando niveles anteriores
dl_n2_m4 <- h2o.deeplearning(
  model_id="dl_n2_m4", 
  training_frame=train_sinDesc_N2, 
  validation_frame=valid_sinDesc_N2[,c(2:(ncol(valid_sinDesc_N2)-10),(ncol(valid_sinDesc_N2)-9))],
  x=2:(ncol(train_sinDesc_N2)-10),
  y=(ncol(train_sinDesc_N2)-9),
  stopping_rounds = 0,
  seed = 1234)
#summary(dl_n2_m4)
h2o.saveModel(dl_n2_m4, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1")


###Nivel 3

#modelo 1: diferenciación binaria sobre si debería o no tener asignado un tipo
dl_n3_m1 <- h2o.deeplearning(
  model_id="dl_n3_m1", 
  training_frame=train, 
  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-6))],
  x=2:(ncol(train)-11),
  y=(ncol(train)-6),
  stopping_rounds = 0,
  seed = 1234)
#summary(dl_n3_m1)
h2o.saveModel(dl_n3_m1, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1")

#modelo 2: diferenciación de tipos incluyendo desconocidos e independiente a niveles anteriores
#dl_n3_m2 <- h2o.deeplearning(
#  model_id="dl_n3_m2", 
#  training_frame=train, 
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-7))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-7),
#  stopping_rounds = 0,
#  seed = 1234)
#summary(dl_n3_m2)

#modelo 3: difereniación de tipos entrenando sin desconocidos e independiente a niveles anteriores
#dl_n3_m3 <- h2o.deeplearning(
#  model_id="dl_n3_m3", 
#  training_frame=train_sinDesc_N3, 
#  validation_frame=valid_sinDesc_N3[,c(2:(ncol(valid_sinDesc_N3)-11),(ncol(valid_sinDesc_N3)-7))],
#  x=2:(ncol(train_sinDesc_N3)-11),
#  y=(ncol(train_sinDesc_N3)-7),
#  stopping_rounds = 0,
#  seed = 1234)
#summary(dl_n3_m3)


#modelo 4: diferenciación de tipos entrenando sin desconocidos y encadenando niveles anteriores
dl_n3_m4 <- h2o.deeplearning(
  model_id="dl_n3_m4", 
  training_frame=train_sinDesc_N3, 
  validation_frame=valid_sinDesc_N3[,c(2:(ncol(valid_sinDesc_N3)-8),(ncol(valid_sinDesc_N3)-7))],
  x=2:(ncol(train_sinDesc_N3)-8),
  y=(ncol(train_sinDesc_N3)-7),
  stopping_rounds = 0,
  seed = 1234)
#summary(dl_n3_m4)
h2o.saveModel(dl_n3_m4, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1")



###Nivel 4

#modelo 1: diferenciación binaria sobre si debería o no tener asignado un tipo
dl_n4_m1 <- h2o.deeplearning(
  model_id="dl_n4_m1", 
  training_frame=train, 
  validation_frame=valid[,c(2:(ncol(valid)-6),(ncol(valid)-4))],
  x=2:(ncol(train)-6),
  y=(ncol(train)-4),
  stopping_rounds = 0,
  seed = 1234)
#summary(dl_n4_m1)
h2o.saveModel(dl_n4_m1, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1")

#modelo 2: diferenciación de tipos incluyendo desconocidos e independiente a niveles anteriores
#dl_n4_m2 <- h2o.deeplearning(
#  model_id="dl_n4_m2", 
#  training_frame=train, 
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-5))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-5),
#  stopping_rounds = 0,
#  seed = 1234)
#summary(dl_n4_m2)

#modelo 3: difereniación de tipos entrenando sin desconocidos e independiente a niveles anteriores
#dl_n4_m3 <- h2o.deeplearning(
#  model_id="dl_n4_m3", 
#  training_frame=train_sinDesc_N4, 
#  validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-11),(ncol(valid_sinDesc_N4)-5))],
#  x=2:(ncol(train_sinDesc_N4)-11),
#  y=(ncol(train_sinDesc_N4)-5),
#  stopping_rounds = 0,
#  seed = 1234)
#summary(dl_n4_m3)


#modelo 4: diferenciación de tipos entrenando sin desconocidos y encadenando niveles anteriores
dl_n4_m4 <- h2o.deeplearning(
  model_id="dl_n4_m4", 
  training_frame=train_sinDesc_N4, 
  #validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-9),(ncol(valid_sinDesc_N4)-7),(ncol(valid_sinDesc_N4)-5))],
  validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-6),(ncol(valid_sinDesc_N4)-5))],
  x=2:(ncol(train_sinDesc_N4)-6),
  y=(ncol(train_sinDesc_N4)-5),
  stopping_rounds = 0,
  seed = 1234)
#summary(dl_n4_m4)
h2o.saveModel(dl_n4_m4, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1")



###Nivel 5

#modelo 1: diferenciación binaria sobre si debería o no tener asignado un tipo
dl_n5_m1 <- h2o.deeplearning(
  model_id="dl_n5_m1", 
  training_frame=train, 
  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-2))],
  x=2:(ncol(train)-11),
  y=(ncol(train)-2),
  stopping_rounds = 0,
  seed = 1234)
#summary(dl_n5_m1)
h2o.saveModel(dl_n5_m1, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1")

#modelo 2: diferenciación de tipos incluyendo desconocidos e independiente a niveles anteriores
#dl_n5_m2 <- h2o.deeplearning(
#  model_id="dl_n5_m2", 
#  training_frame=train, 
#  validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-3))],
#  x=2:(ncol(train)-11),
#  y=(ncol(train)-3),
#  stopping_rounds = 0,
#  seed = 1234)
#summary(dl_n5_m2)

#modelo 3: difereniación de tipos entrenando sin desconocidos e independiente a niveles anteriores
#dl_n5_m3 <- h2o.deeplearning(
#  model_id="dl_n5_m3", 
#  training_frame=train_sinDesc_N5, 
#  validation_frame=valid_sinDesc_N5[,c(2:(ncol(valid_sinDesc_N5)-11),(ncol(valid_sinDesc_N5)-3))],
#  x=2:(ncol(train_sinDesc_N5)-11),
#  y=(ncol(train_sinDesc_N5)-3),
#  stopping_rounds = 0,
#  seed = 1234)
#summary(dl_n5_m3)


#modelo 4: diferenciación de tipos entrenando sin desconocidos y encadenando niveles anteriores
dl_n5_m4 <- h2o.deeplearning(
  model_id="dl_n5_m4", 
  training_frame=train_sinDesc_N5, 
  #validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-9),(ncol(valid_sinDesc_N4)-7),(ncol(valid_sinDesc_N4)-5))],
  validation_frame=valid_sinDesc_N5[,c(2:(ncol(valid_sinDesc_N5)-4),(ncol(valid_sinDesc_N5)-3))],
  x=2:(ncol(train_sinDesc_N5)-3),
  y=(ncol(train_sinDesc_N5)-3),
  stopping_rounds = 0,
  seed = 1234)
#summary(dl_n5_m4)
h2o.saveModel(dl_n5_m4, path="/opt/files/proyectoHeiko_adaptado/R_proyectos/amelioratingTypes_ESWC2018/models/soloTest1")






h2o.shutdown(prompt=FALSE)

