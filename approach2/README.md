# Approach 2: ontology class hierarchy for type prediction
Approaches 2 and 3 are Local Classifiers Per Level (LCL), modified with extra binary models. 
These binary models are aimed at solving the *partial depth
problem*: to know, for each resource, which levels do not `produce' types. 
There are 11 models, 6 of them are multi-class, and the remaining 5 are binary models
(as shown in the next figure). The multi-class models are intended for predicting the
type for that level. The binary models predict if the type should be assigned to
the resource.
The approach 2 was named *multilevel* because we have models
for each ontology class level. For this approach we used only one training method:
C5.0, an improved version of C4.5.

<img src="http://es-ta.linkeddata.es/app2training.png" width="1200">
