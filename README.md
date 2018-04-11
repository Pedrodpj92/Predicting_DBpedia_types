# Predicting DBpedia types

This project contains the source code of the set of models for inferrying new types on DBpedia 3.9, exploiting its class hierarchy. The main script (main_predicting_DBpedia_types.R) allows to reproduce several experiments carried out. Check out http://es-ta.linkeddata.es/ to explore details and download data to test experiments.

## Getting Started
Clone or download the source code into your machine. Heed next section to find libraries and software used and how to install. 

### Prerequisites

* [R 3.4.3 (2017-11-30)](https://www.r-project.org/ ) or later
* [Java 1.7](https://www.java.com/es/download/) or later
* [H2O library](https://www.h2o.ai/) version 3.16.0.1 or later
* [C5.0 R library](https://cran.r-project.org/web/packages/C50/C50.pdf) version 0.1.0-24 or later
* [optparse](https://cran.r-project.org/web/packages/optparse/optparse.pdf) version 1.4.4 or later
* 64-bits machine


other dependencies...
* [RCurl](https://cran.r-project.org/web/packages/RCurl/RCurl.pdf) version 1.95-4.8 or later
* [jsonlite](https://cran.r-project.org/web/packages/jsonlite/jsonlite.pdf) version 1.5 or later
 
### Installing R packages
We recommend search last stable versions, but here you will find both last stable and what we used in Machine Learning(ML) libraries.
* Main common libraries and dependencies
```
#http://docs.h2o.ai/h2o/latest-stable/h2o-docs/faq/r.html
if (! ("methods" %in% rownames(installed.packages()))) { install.packages("methods") }
if (! ("statmod" %in% rownames(installed.packages()))) { install.packages("statmod") }
if (! ("stats" %in% rownames(installed.packages()))) { install.packages("stats") }
if (! ("graphics" %in% rownames(installed.packages()))) { install.packages("graphics") }
if (! ("RCurl" %in% rownames(installed.packages()))) { install.packages("RCurl") }
if (! ("jsonlite" %in% rownames(installed.packages()))) { install.packages("jsonlite") }
if (! ("tools" %in% rownames(installed.packages()))) { install.packages("tools") }
if (! ("utils" %in% rownames(installed.packages()))) { install.packages("utils") }
if (! ("optparse" %in% rownames(installed.packages()))) { install.packages("optparse") }
```

* Last ML versions
```
install.packages("h2o", type="source", repos=(c("http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R)))

if (! ("C50" %in% rownames(installed.packages()))) { install.packages("C5.0") }
```

* Used ML versions
```
url_h2o <- "https://cran.r-project.org/src/contrib/Archive/h2o/h2o_3.16.0.1.tar.gz"
install.packages(url_h2o, repos=NULL, type="source")

url_c50 <- "https://cran.r-project.org/src/contrib/Archive/C50/C50_0.1.0-24.tar.gz"
install.packages(url_c50, repos=NULL, type="source")
```
 
## Running experiments
Navigate with your prompt to source folder and execute -h or --help to see options. Use RScript command if you are under Windows (**watch out with PATH configuration**)
```
./main_predicting_DBpedia_types.R --help
Usage: ./main_predicting_DBpedia_types.R <options>
Description:
                           this software provides the possibility of reproduce experiments showed in paper "Inferring new types on large datasets applying ontology class hierarchy classifiers: the DBpedia case"
                           (currently under review at ISWC2018)

Options:
        -a CHARACTER, --approach=CHARACTER
                approach selected. <global_ap1 | multilevel_ap2 | cascade_ap3>
              global_ap1 - First approach, it learns from most specific type from each resource
              multilevel_ap2 - Second approach, Local Classifiers per Level with binary decisions per level aimed to solve partial depth issue
              cascade_ap3 - Third approach, Local Classifiers per Level with binary decisions per level and cascade process aimed to solve partial depth issue and reduce hierarchy inconcistencies

        -l CHARACTER, --algorithm=CHARACTER
                algorithm used for the approach selected. <NB | C5.0 | DL | RF>.
              NB - Naïve Bayes. Only in global approach
              C5.0 - Only in multilevel approach
              DL - Deep Learning
              RF - Random Forest

        -t CHARACTER, --test=CHARACTER
                dataset selected. <test1 | test10 | test25 | fiveFold>
              test1  - test with retained resources with at least 1 ingoing property
              test10 - test with retained resources with at least 10 ingoing properties
              test25 - test with retained resources with at least 25 ingoing properties
              fiveFold - test with cross validation wtih 5 fold. Only in multilevel approach

        -i CHARACTER, --pathIn=CHARACTER
                path to input files. Directory should exist previously. Check out http://es-ta.linkeddata.es/#inputs to download experiments

        -o CHARACTER, --pathOut=CHARACTER
                path to output files. Directory should exist previously

        -f CHARACTER, --fileOut=CHARACTER
                files' output identifier or name to track files about same experiment [default= output]

        -s SEED, --seed=SEED
                random number generator seed for algorithms that are dependent on randomization [default= 1234]

        -h, --help
                Show this help message and exit

Examples:
                             -> using multilevel approach (2) with Random Forest algorithm and fiveFold test. Check out input folder is the first path showed with -i flag and generated files will be located at second path, as -o flag shows. Look for files with 'output_ap2_5f_execution1' to find related outputs with your experiment.
                           ./main_predicting_DBpedia_types.R -a multilevel_ap2 -l RF -t fiveFold -i /home/myExperiments/aboutDBpedia_hierarchyClasssifiers/approach2/crossValidation/ -o /home/myExperiments/aboutDBpedia_hierarchyClasssifiers/approach2/crossValidation/output/ -f output_ap2_5f_execution1
                             -> using cascade approach (3) with Deep Learning algorithm and test 25 (resources with at least 25 ingoing properties). Watch out in this example where related paths are used instance of absolute paths.
                           ./main_predicting_DBpedia_types.R -a cascade_ap3 -l DL -t test25 -i ./data/ap3/t25/ -o ./output/ap3_t25/ -f out_ap3_t25_execution7


```

## About the authors
* **Mariano Rico**	*(mariano.rico@fi.upm.es)* Ontology Engineering Group, UPM
* **Idafen Santana-Perez**	*(isantana@fi.upm.es)* Ontology Engineering Group, UPM
* **Pedro del Pozo-Jiménez**	*(ppozo@fi.upm.es)* Ontology Engineering Group, UPM
* **Asunción Gomez-Pérez**	*(asun@fi.upm.es)* Ontology Engineering Group, UPM

## Acknowledgments
This work was partially funded by projects RTC-2016-4952-7, TIN2013-46238-C4-2-R and TIN2016-78011-C4-4-R, from the Spanish State Investigation Agency of the MINECO and FEDER Funds

