opt=statset('display','iter');
% [fs,history]=sequentialfs(@myfun,extractedFeatures,arousalTarget,'cv','none','opt', opt,'nfeatures', 2);

% [fs,history]=sequentialfs(@myfun,extractedFeaturesArousal,arousalTargetBalanced,'cv','none','opt', opt);
% arousalInput = extractInput(extractedFeaturesArousal,fs);

 [fs,history]=sequentialfs(@myfun,extractedFeaturesValence,valenceTargetBalanced,'cv','none','opt', opt);
 valenceInput = extractInput(extractedFeaturesValence,fs);

clear fs opt testPerformance history;

function perf = myfun(x,t)
    %create a network
    hiddenLayerSize=10;
    net=fitnet(hiddenLayerSize);
    net.trainParam.showWindow = 0; %<= Nasconde il pop-up !!!!!!!!!!!!!!!!!!!!!!!
    xx=x'; tt=t';
    % train the network
    [net,tr]=train(net,xx,tt);
    % test the network
    y=net(xx);
    perf=perform(net,tt,y);
end

function matrix = extractInput(features, selected)
    first = true; %il primo inserimento deve creare la matrice
    for i = 1:length(selected)
        if selected(1,i) == 1
            if first
                matrix = features(:,i); 
                first = false;
            else
                matrix = [matrix features(:,i)];
            end 
        end    
    end
end