# Approach 3: ontology class hierarchy for type prediction *on cascade*
Approaches 2 and 3 are Local Classifiers Per Level (LCL), modified with extra binary models. 
These binary models are aimed at solving the *partial depth
problem*: to know, for each resource, which levels do not *produce* types. 
There are 11 models, 6 of them are multi-class, and the remaining 5 are binary models
(as shown in the next figure). The multi-class models are intended for predicting the
type for that level. The binary models predict if the type should be assigned to
the resource.
The third approach is also a multilevel approach. The features used by this
approach are depicted in the following picture. In this approach we add a *cascade process*, aimed at avoiding inconsistencies in the predicted types (non *logical*
paths).

<img src="http://es-ta.linkeddata.es/app3training.png" width="1200">
