#!/usr/bin/env Rscript
#main_predicting_DBpedia_types.R

# args <- commandArgs(trailingOnly=FALSE)
# print(args)

library("optparse")
source(paste(getwd(),"/modeling/approach1/approach1_globalApproach.R",sep=""), local = TRUE)
source(paste(getwd(),"/modeling/approach2/approach2_multilevel.R",sep=""))
source(paste(getwd(),"/modeling/approach3/approach3_multilevel_onCascade.R",sep=""))
source(paste(getwd(),"/evaluating/evaluate_complete.R",sep=""))
#falta poner los .csv con los tipos divididos por niveles, en principio esos csv serán hardcodeados para cada versión según la ontología


option_list <- list(
  make_option(c("-a", "--approach"), type="character", default=NULL, 
              help="approach selected. <global_ap1 | multilevel_ap2 | cascade_ap3>
              global_ap1 - First approach, it learns from most specific type from each resource
              multilevel_ap2 - Second approach, Local Classifiers per Level with binary decisions per level aimed to solve partial depth issue
              cascade_ap3 - Third approach, Local Classifiers per Level with binary decisions per level and cascade process aimed to solve partial depth issue and reduce hierarchy inconcistencies",
              metavar="character"),
  make_option(c("-l", "--algorithm"), type="character", default = NULL,
              help="algorithm used for the approach selected. <NB | C5.0 | DL | RF>.
              NB - Naïve Bayes. Only in global approach
              C5.0 - Only in multilevel approach
              DL - Deep Learning
              RF - Random Forest",
              metavar="character"),
  make_option(c("-t", "--test"), type="character", default = NULL,
              help="dataset selected. <test1 | test10 | test25 | fiveFold>
              test1  - test with retained resources with at least 1 ingoing property
              test10 - test with retained resources with at least 10 ingoing properties
              test25 - test with retained resources with at least 25 ingoing properties 
              fiveFold - test with cross validation wtih 5 fold. Only in multilevel approach",
              metavar="character"),
  make_option(c("-i", "--pathIn"), type="character", default = NULL,
              help="path to input files. Directory should exist previously. Check out http://es-ta.linkeddata.es/#inputs to download experiments",
              metavar="character"),
  make_option(c("-o", "--pathOut"), type="character", default = NULL,
              help="path to output files. Directory should exist previously",
              metavar="character"),
  make_option(c("-f", "--fileOut"), type="character", default = "output",
              help="files' output identifier or name to track files about same experiment [default= %default]",
              metavar="character"),
  make_option(c("-s","--seed"), type="integer", default = 1234,
              help="random number generator seed for algorithms that are dependent on randomization [default= %default]")
)

opt_parser <- OptionParser(usage = "Usage: %prog <options>",
                           description = "Description:
                           this software provides the possibility of reproduce experiments showed in paper \"Inferring new types on large datasets applying ontology class hierarchy classifiers: the DBpedia case\"
                           (currently under review at ISWC2018)",
                           epilogue = "Examples:
                             -> using multilevel approach (2) with Random Forest algorithm and fiveFold test. Check out input folder is the first path showed with -i flag and generated files will be located at second path, as -o flag shows. Look for files with 'output_ap2_5f_execution1' to find related outputs with your experiment.
                           %prog -a multilevel_ap2 -l RF -t fiveFold -i /home/myExperiments/aboutDBpedia_hierarchyClasssifiers/approach2/crossValidation/ -o /home/myExperiments/aboutDBpedia_hierarchyClasssifiers/approach2/crossValidation/output/ -f output_ap2_5f_execution1
                             -> using cascade approach (3) with Deep Learning algorithm and test 25 (resources with at least 25 ingoing properties). Watch out in this example where related paths are used instance of absolute paths. 
                           %prog -a cascade_ap3 -l DL -t test25 -i ./data/ap3/t25/ -o ./output/ap3_t25/ -f out_ap3_t25_execution7",
                           option_list=option_list)


opt <- parse_args(opt_parser)

#options restrictions
if(is.null(opt$approach) || !(opt$approach %in% c("global_ap1","multilevel_ap2","cascade_ap3"))){
  print_help(opt_parser)
  stop("Please, select one approach: <global_ap1 | multilevel_ap2 | cascade_ap3>.", call.=FALSE)
}
if(is.null(opt$algorithm) || !(opt$algorithm %in% c("NB","C5.0","DL","RF"))){
  print_help(opt_parser)
  stop("Please, select one algorithm: <NB | C5.0 | DL | RF>", call.=FALSE)
}
if(is.null(opt$test) || !(opt$test %in% c("test1","test10","test25","fiveFold"))){
  print_help(opt_parser)
  stop("Please, select one test: <test1 | test10 | test25 | fiveFold>", call.=FALSE)
}
if(is.null(opt$pathIn)){
  print_help(opt_parser)
  stop("pathIn argument must be supplied (files input's path)", call.=FALSE)
}
if(is.null(opt$pathOut)){
  print_help(opt_parser)
  stop("pathOut argument must be supplied (files output's path)", call.=FALSE)
}


if(opt$approach %in% c("global_ap1") && !(opt$algorithm %in% c("NB","DL","RF"))){
  print_help(opt_parser)
  stop("global approach (approach1) can just be executed with Naive Bayes, Deep Learning or Random Forest.", call.=FALSE)
}
if(opt$approach %in% c("multilevel_ap2") && !(opt$algorithm %in% c("C5.0","DL","RF"))){
  print_help(opt_parser)
  stop("multilevel approach (approach2) can just be executed with C5.0, Deep Learning or Random Forest.", call.=FALSE)
}
if(!(opt$approach %in% c("multilevel_ap2")) && opt$test %in% c("fiveFold")){
  print_help(opt_parser)
  stop("fiveFold test can just be executed with multilevel approach (approach2).", call.=FALSE)
}
if(opt$approach %in% c("cascade_ap3") && !(opt$algorithm %in% c("DL","RF"))){
  print_help(opt_parser)
  stop("cascade approach (approach3) can just be executed with Deep Learning or Random Forest.", call.=FALSE)
}

vl_seleccionado <- "sin seleccionar"
if(opt$test %in% c("test1")){
  vl_seleccionado <- "validating_test1.csv"
}else if(opt$test %in% c("test10")){
  vl_seleccionado <- "validating_test10.csv"
}else if(opt$test %in% c("test25")){
  vl_seleccionado <- "validating_test25.csv"
}else if(opt$test %in% c("fiveFold")){
  vl_seleccionado <- "fiveFoldDummyvariable"
}else{
  print_help(opt_parser)
  stop("Please, select one test: <test1 | test10 | test25 | fiveFold>", call.=FALSE)
}

tr1 <- "training.csv"
tr_l2_1 <- "training_knownResources_L2.csv"
vl_l2_1 <- "validating_knownResources_L2.csv"
tr_l3_1 <- "training_knownResources_L3.csv"
vl_l3_1 <- "validating_knownResources_L3.csv"
tr_l4_1 <- "training_knownResources_L4.csv"
vl_l4_1 <- "validating_knownResources_L4.csv"
tr_l5_1 <- "training_knownResources_L5.csv"
vl_l5_1 <- "validating_knownResources_L5.csv"


if(!(opt$test %in% c("fiveFold"))){
  if(opt$approach %in% c("global_ap1")){
    if(opt$algorithm %in% c("NB")){
      app1_nb(semilla = opt$seed,
              pathInput = opt$pathIn,
              pathOutputModel = opt$pathOut,
              pathOutput = opt$pathOut,
              nameOutputFile = opt$fileOut,
              tr = tr1,
              vl = vl_seleccionado)
      system(command = paste("java -jar ",getwd(),"/levels_ontology/dbotypes.jar ",getwd(),"/levels_ontology/dbpedia_3.9.owl ",paste(opt$pathOut,
                                                                                                                                     opt$fileOut,"_nb.ttl",sep = ""),sep=""))
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,
                                                      opt$fileOut,"_nb.ttl.extended.csv",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,
                                                       vl_seleccionado,sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }else if(opt$algorithm %in% c("DL")){
      app1_dl(semilla = opt$seed,
              pathInput = opt$pathIn,
              pathOutputModel = opt$pathOut,
              pathOutput = opt$pathOut,
              nameOutputFile = opt$fileOut,
              tr = tr1,
              vl = vl_seleccionado)
      system(command = paste("java -jar ",getwd(),"/levels_ontology/dbotypes.jar ",getwd(),"/levels_ontology/dbpedia_3.9.owl ",paste(opt$pathOut,
                                                                                                                                     opt$fileOut,"_dl.ttl",sep = ""),sep=""))
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,
                                                      opt$fileOut,"_dl.ttl.extended.csv",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,
                                                       vl_seleccionado,sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }else if(opt$algorithm %in% c("RF")){
      app1_rf(semilla = opt$seed,
              pathInput = opt$pathIn,
              pathOutputModel = opt$pathOut,
              pathOutput = opt$pathOut,
              nameOutputFile = opt$fileOut,
              tr = tr1,
              vl = vl_seleccionado)
      system(command = paste("java -jar ",getwd(),"/levels_ontology/dbotypes.jar ",getwd(),"/levels_ontology/dbpedia_3.9.owl ",paste(opt$pathOut,
                                                                                                                                     opt$fileOut,"_rf.ttl",sep = ""),sep=""))
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,
                                                      opt$fileOut,"_rf.ttl.extended.csv",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,
                                                       vl_seleccionado,sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }else{
      print_help(opt_parser)
      stop("global approach (approach1) can just be executed with Naive Bayes, Deep Learning or Random Forest.", call.=FALSE)
    }
  }else if(opt$approach %in% c("multilevel_ap2")){
    if(opt$algorithm %in% c("C5.0")){
      app2_C50(semilla = opt$seed,
               pathInput = opt$pathIn,
               pathOutputModel = opt$pathOut,
               pathOutput = opt$pathOut,
               nameOutputFile = opt$fileOut,
               tr = tr1, vl = vl_seleccionado,
               tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
               tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
               tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
               tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,
                                                      opt$fileOut,"_c50.ttl",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,
                                                       vl_seleccionado,sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }else if(opt$algorithm %in% c("DL")){
      app2_DL(semilla = opt$seed,
              pathInput = opt$pathIn,
              pathOutputModel = opt$pathOut,
              pathOutput = opt$pathOut,
              nameOutputFile = opt$fileOut,
              tr = tr1, vl = vl_seleccionado,
              tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
              tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
              tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
              tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,
                                                      opt$fileOut,"_dl.ttl",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,
                                                       vl_seleccionado,sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }else if(opt$algorithm %in% c("RF")){
      app2_RF(semilla = opt$seed,
              pathInput = opt$pathIn,
              pathOutputModel = opt$pathOut,
              pathOutput = opt$pathOut,
              nameOutputFile = opt$fileOut,
              tr = tr1, vl = vl_seleccionado,
              tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
              tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
              tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
              tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,
                                                      opt$fileOut,"_rf.ttl",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,
                                                       vl_seleccionado,sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }else{
      print_help(opt_parser)
      stop("multilevel approach (approach2) can just be executed with C5.0, Deep Learning or Random Forest.", call.=FALSE)
    }
  }else if(opt$approach %in% c("cascade_ap3")){
    if(opt$algorithm %in% c("DL")){
      app3_DL(semilla = opt$seed,
              pathInput = opt$pathIn,
              pathOutputModel = opt$pathOut,
              pathOutput = opt$pathOut,
              nameOutputFile = opt$fileOut,
              tr = tr1, vl = vl_seleccionado,
              tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
              tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
              tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
              tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,
                                                      opt$fileOut,"_dl.ttl",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,
                                                       vl_seleccionado,sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }else if(opt$algorithm %in% c("RF")){
      app3_RF(semilla = opt$seed,
              pathInput = opt$pathIn,
              pathOutputModel = opt$pathOut,
              pathOutput = opt$pathOut,
              nameOutputFile = opt$fileOut,
              tr = tr1, vl = vl_seleccionado,
              tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
              tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
              tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
              tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,
                                                      opt$fileOut,"_rf.ttl",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,
                                                       vl_seleccionado,sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }else{
      print_help(opt_parser)
      stop("cascade approach (approach3) can just be executed with Deep Learning or Random Forest.", call.=FALSE)
    }
  }
}else{#five fold experiments
  
  folders <- c("fold1/","fold2/","fold3/","fold4/","fold5/")
  validating_test <- c("validating_test.csv","validating_test2.csv","validating_test3.csv","validating_test4.csv","validating_test5.csv")
  
  if(opt$algorithm %in% c("C5.0")){ #May be could be better use only 1 for loop above conditionals in order to save code lines, but in this way with 3 loops I think that can be read better.
    for(i in 1:length(folders)){
      dir.create(paste(opt$pathOut,folders[i],sep=""))
      app2_C50(semilla = opt$seed,
               pathInput = paste(opt$pathIn,folders[i],sep=""),
               pathOutputModel = paste(opt$pathOut,folders[i],sep=""),
               pathOutput = paste(opt$pathOut,folders[i],sep=""),
               nameOutputFile = opt$fileOut,
               tr = tr1, vl = validating_test[i],
               tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
               tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
               tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
               tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,folders[i],
                                                      opt$fileOut,"_c50.ttl",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,folders[i],
                                                       "reservatest.ttl",sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }
  }else if(opt$algorithm %in% c("DL")){
    for(i in 1:length(folders)){
      dir.create(paste(opt$pathOut,folders[i],sep=""))
      app2_DL(semilla = opt$seed,
              pathInput = paste(opt$pathIn,folders[i],sep=""),
              pathOutputModel = paste(opt$pathOut,folders[i],sep=""),
              pathOutput = paste(opt$pathOut,folders[i],sep=""),
              nameOutputFile = opt$fileOut,
              tr = tr1, vl = validating_test[i],
              tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
              tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
              tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
              tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,folders[i],
                                                      opt$fileOut,"_dl.ttl",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,folders[i],
                                                       "reservatest.ttl",sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }
  }else if(opt$algorithm %in% c("RF")){
    
    for(i in 1:length(folders)){
      dir.create(paste(opt$pathOut,folders[i],sep=""))
      app2_RF(semilla = opt$seed,
              pathInput = paste(opt$pathIn,folders[i],sep=""),
              pathOutputModel = paste(opt$pathOut,folders[i],sep=""),
              pathOutput = paste(opt$pathOut,folders[i],sep=""),
              nameOutputFile = opt$fileOut,
              tr = tr1, vl = validating_test[i],
              tr_l2 = tr_l2_1, vl_l2 = tr_l2_1,
              tr_l3 = tr_l3_1, vl_l3 = tr_l3_1,
              tr_l4 = tr_l4_1, vl_l4 = tr_l4_1,
              tr_l5 = tr_l5_1, vl_l5 = tr_l5_1)
      evalua_completo(pathDT_GeneradoCompleto = paste(opt$pathOut,folders[i],
                                                      opt$fileOut,"_rf.ttl",sep = ""),
                      pathDT_ReservadoCompleto = paste(opt$pathIn,folders[i],
                                                       "reservatest.ttl",sep = ""),
                      pathNivelesCompleto = paste(getwd(),"/levels_ontology/39/",sep=""),
                      pathSalida = paste(opt$pathOut,
                                         "evaluation_",
                                         opt$fileOut,".csv",sep = ""))
    }
  }else{
    print_help(opt_parser)
    stop("fiveFold test can just be executed with multilevel approach (approach2).", call.=FALSE)
  }
  
}

