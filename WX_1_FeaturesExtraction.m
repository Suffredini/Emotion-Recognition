people = length(data(1,1,1,:));
samples = length(data(1,1,:,1));
MatrixSqueezed = zeros(samples*40,40);
meanMatrix = []; 
minMatrix = [];
maxMatrix = [];
kurtosisMatrix = [];
skewnessMatrix = [];
medianMatrix = [];
meanFreqMatrix = []; 
medianFreqMatrix = []; 

for p =1:people    
   for c = 1:samples
         e = c*40;
         s = e-39;
         MatrixSqueezed(s:e,:) = data(:,:,c,p);
   end    
   %Accorpo sensori
   tmpMatrix = [];
   for v = 1: 40
       tmpMatrix = [tmpMatrix MatrixSqueezed(v:40:samples*40,:)];
   end    
   meanMatrix = [meanMatrix mean(tmpMatrix)]; 
   minMatrix = [minMatrix min(tmpMatrix)];
   maxMatrix = [maxMatrix max(tmpMatrix)];
   kurtosisMatrix = [kurtosisMatrix kurtosis(tmpMatrix)];
   skewnessMatrix = [skewnessMatrix skewness(tmpMatrix)];
   medianMatrix = [medianMatrix median(tmpMatrix)];
   meanFreqMatrix = [meanFreqMatrix meanfreq(tmpMatrix)]; 
   medianFreqMatrix = [medianFreqMatrix medfreq(tmpMatrix)];         
end

%Formatto le matrici per la features extraction
FMean = preExtraction(meanMatrix,people);
FMin = preExtraction(minMatrix,people);
FMax = preExtraction(maxMatrix,people);
FKurtosis = preExtraction(kurtosisMatrix,people);
FSkewness = preExtraction(skewnessMatrix,people);
FMedian = preExtraction(medianMatrix,people);
FMeanF = preExtraction(meanFreqMatrix,people);
FMedianF = preExtraction(medianFreqMatrix,people);  

%Accorpo per avere tutte le features su una riga
extractedFeatures = [FMean FMin FMax FKurtosis FSkewness FMedian FMeanF FMedianF];
%extractedFeatures = [FMean FMin FMax FMedian FMeanF];
%extractedFeatures = [FMean FMin FMax FKurtosis FSkewness FMedian];
%extractedFeatures = [FMeanF FMedianF];

extractedFeatures = normalize(extractedFeatures); % <-- fatta dopo il bilanciamento

%Estraggo Valence e Arousal
valence(:,:,:) = labels(:,1,:);
arousal(:,:,:) = labels(:,2,:);

%Preapro Valence e Arousal per la features extraction
arousalTarget = zeros(40*people,1);
valenceTarget = zeros(40*people,1);

for p = 1:people
    e = p*40;
    s = e-39; 
    arousalTarget(s:e,1) = arousal(:,1,p);
    valenceTarget(s:e,1) = valence(:,1,p);
end


clear c;
clear p;
clear v;
clear tmp;
clear s;
clear e;
clear index;
clear evalTmp;
clear tmpMatrix;
clear MatrixSqueezed;
clear meanMatrix;
clear minMatrix;
clear maxMatrix;
clear kurtosisMatrix;
clear skewnessMatrix;
clear medianMatrix;
clear FMean;
clear FMin;
clear FMax;
clear FKurtosis;
clear FSkewness;
clear FMedian;
clear valence;
clear arousal;
clear people;
clear samples FMeanF FMedianF meanFreqMatrix medianFreqMatrix;;



function ret = preExtraction(matrix,p)
    ret = zeros(40*p,40);
    for i = 1:40*p
        e = i*40;
        s = e-39;
        ret(i,:) = matrix(1,s:e);
    end
end