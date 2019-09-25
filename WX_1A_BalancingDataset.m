len = length(arousalTarget(:,1));
spacing = 0.5;
intervals = (9/spacing)-1;
targetCount = 32;%round(len/intervals);
arousalCount = zeros(1,intervals);
valenceCount = zeros(1,intervals);

for i = 1:len
    indexA = (floor(arousalTarget(i,1))*2)-1; % NB intervallo 17 prende solo valore 9
    resA = mod(arousalTarget(i,1),floor(arousalTarget(i,1)));
    if resA >= spacing
        indexA=indexA+1;
    end
    arousalCount(1,indexA) = arousalCount(1,indexA)+1;
    
    indexV = (floor(valenceTarget(i,1))*2)-1;
    resV = mod(valenceTarget(i,1),floor(valenceTarget(i,1)));
    if resV >= spacing
        indexV=indexV+1;
    end
    valenceCount(1,indexV) = valenceCount(1,indexV)+1;
    
end
extractedFeaturesArousal = extractedFeatures;
extractedFeaturesValence = extractedFeatures;
arousalTargetBalanced = arousalTarget;
valenceTargetBalanced = valenceTarget;
deletedValence = [];
deletedArousal = [];

for i=1:intervals 
    %mettere if per evitare di chiamare funzione per quelli buoni
    [extractedFeaturesArousal, arousalTargetBalanced, tmp] = deleteIndex(arousalTargetBalanced,extractedFeaturesArousal,arousalCount(i),i,targetCount);
    deletedArousal = [deletedArousal tmp]; 
    %sdoppiare extractedFeatures per valence e arousal
    [extractedFeaturesValence, valenceTargetBalanced, tmp] = deleteIndex(valenceTargetBalanced,extractedFeaturesValence,valenceCount(i),i,targetCount);
    deletedValence = [deletedValence tmp];
end

extractedFeaturesArousal = normalize(extractedFeaturesArousal);
extractedFeaturesValence = normalize(extractedFeaturesValence);

clear i len indexA indexV resA resV intervals spacing targetCount;

function [newFeatures, newTarget, toDelete]  = deleteIndex(target,features,count,index,targetCount)
    toDelete = [];
    newFeatures = features;
    newTarget = target;
    
    if count > targetCount
        endInterval = (index+2)/2;
        startInterval = endInterval-0.5;
        indexVector = zeros(1,count);
        posVector = 1;
        len = length(target(:,1));
        for i = 1:len
           if target(i,1)>=startInterval && target(i,1) < endInterval
               indexVector(1,posVector) = i; 
               posVector = posVector+1;
           end
        end

        toDelete = randsample(indexVector,(count-targetCount)); 
     end
    
end
