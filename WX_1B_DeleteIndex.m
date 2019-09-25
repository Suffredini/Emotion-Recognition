window = 3;

extractedFeaturesArousal = extractedFeatures;
extractedFeaturesValence = extractedFeatures;
arousalTargetBalanced = arousalTarget;
valenceTargetBalanced = valenceTarget;

[extractedFeaturesArousal, arousalTargetBalanced] = deleteIndex(arousalTargetBalanced,extractedFeaturesArousal,deletedArousal, window);
[extractedFeaturesValence, valenceTargetBalanced] = deleteIndex(valenceTargetBalanced,extractedFeaturesValence,deletedValence, window);
 
extractedFeaturesArousal = normalize(extractedFeaturesArousal);
extractedFeaturesValence = normalize(extractedFeaturesValence);

clear i len indexA indexV resA resV intervals spacing targetCount window tmp;

function [toDelete]  = foundDeleteIndex(target,features,count,index,targetCount)
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
        toDelete = randsample(indexVector,(count-targetCount)); %ottengo un vettore con gli indici da eliminare
    end    
end


function [newFeatures, newTarget]  = deleteIndex(target,features,toDelete,window)
    len = length(target(:,1));
    newLen = len-(length(toDelete)*window);
    newFeatures = zeros(newLen,length(features(1,:)));
    newTarget = zeros(newLen,1);
    j = 1; % per scorrere i nuovi vettori
    
    offset3 = (len/window);
    offset2 = 2*(len/window);
    window3 = offset3+toDelete; %window 3 è quella centrale sofrapposta alla 1 (sx) e alla 2 (dx)
    window2 = offset2+toDelete;
    toDeleteTmp = [toDelete window3 window2];

    for i = 1:len            
        if isempty(find(toDeleteTmp == i)) %se non é da eliminare
            newFeatures(j,:) = features(i,:);
            newTarget(j,:) = target(i,:);
            j = j+1;
        end            
    end    
end
