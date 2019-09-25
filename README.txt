Progetto di Intelligent Systems per il corso magistrale in Computer Engineering (Università di Pisa).

Insert in the main root a folder "Dataset" and put inside the given dataset.
More info on dataset inside the documentation.

W1_0_StartScript -> Copy the 32 dataset into 2 vector: data and labels, it also cut the start value of the sample
W2_0_StartScript -> The same of W1_0_StartScript but on two window
W3_0_StartScript -> The same of W1_0_StartScript but on three window

WX_1_FeaturesExtraction -> Extract the features, execute after StartScript
WX_1A_BalancingDataset -> Balancing the dataset on one window, create deletedArousal and deletedValence that can be used in WX_1B_DeleteIndex (after having extracted features on 3 windows) for balancing dataset
WX_1B_DeleteIndex -> Remove index for balancing dataset (see WX_1A_BalancingDataset)
WX_1C_selctInput -> Given the features selected, build the input vector (alternative of WX_1_FeaturesExtraction)

WX_2_FeaturesSelection -> Select the features

WX_3_FitnetOneLayer -> Training net with one hidden layer
WX_3_FitnetOneLayerCrossValidation -> Training net with 3-fold cross validation 
WX_3_FitnetTwoLayer -> Training net with 2 hidden layers
WX_3_RBF -> Training net with RBF

CX_1A_ExtractClass -> Extract class for patternet (Execute after WX_1_FeaturesExtraction)
CX_2_Patternnet ->  Launch patternet
