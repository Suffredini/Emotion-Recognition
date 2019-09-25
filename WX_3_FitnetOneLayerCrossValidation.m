
%Lo script testa le reti con i neuroni nell hidden layer indicati dal for e
% crea due variabili dove indica il numero di neuroni della rete che ha
% avuto un valore di regression maggiore relativamente ad all
PerformanceNeuronCV = 0;
PerformanceTestCV =3.7;
PerformanceRegressionCV = 0;
for repeat = 1:30
    hiddenLayerSize = 19;
    
    
    z = repeat
    x = arousalInput';
    t = arousalTarget';
%     x = valenceInput';
%     t = valenceTarget';
    trainFcn = 'trainbr';  

    % Create a Fitting Network

    net = fitnet(hiddenLayerSize,trainFcn);
    %net.trainParam.showWindow = 0; %<= Nasconde il pop-up !!!!!!!!!!!!!!!!!!!!!!!

    % Choose Input and Output Pre/Post-Processing Functions
    % For a list of all processing functions type: help nnprocess
    net.input.processFcns = {'removeconstantrows','mapminmax'};
    net.output.processFcns = {'removeconstantrows','mapminmax'};


    net.performFcn = 'mse';  % Mean Squared Error
    net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
        'plotregression', 'plotfit'};

    net.divideFcn = 'divideind';
    CVO = cvpartition(t,'KFold',4);

    for i = 1:CVO.NumTestSets
         trIdx = extractInput(CVO.training(i));
         teIdx = extractInput(CVO.test(i));
         net.divideParam.trainInd = trIdx;
         net.divideParam.testInd = teIdx;

         [net,tr] = train(net,x,t);      
    end

    % Test the Network
    y = net(x);
    e = gsubtract(t,y);
    performance = perform(net,t,y);
     stop = false;
    tmpTestPerformance = perform(net,t,y)
    if tmpTestPerformance < PerformanceTestCV
        PerformanceNeuronCV = repeat;
        PerformanceTestCV = tmpTestPerformance;
        [r,m,b] = regression(t,y); 
        PerformanceRegressionCV = r;        
         stop = true;
    end


    % Recalculate Training, Validation and Test Performance
    trainTargets = t .* tr.trainMask{1};
    valTargets = t .* tr.valMask{1};
    testTargets = t .* tr.testMask{1};
    trainPerformance = perform(net,trainTargets,y);
    valPerformance = perform(net,valTargets,y);
    testPerformance = perform(net,testTargets,y);  
     if stop == true 
         break;
    end
end


clear r m b valTargets x y testPerformance valPerformance trainFcn performance t i  hiddenLayerSize  e tr ;

function matrix = extractInput(selected)
    matrix = [];
    for i = 1:length(selected)
        if selected(i,1) == 1
            matrix = [matrix i];
        end    
    end
    matrix = matrix';
end
