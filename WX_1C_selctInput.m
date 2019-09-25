
selected = [2 19 35 65 69 95 122 177 220 244 252 258 301];
arousalInput = extractInput(extractedFeatures, selected);
clear selected;
function matrix = extractInput(features, selected)
    first = true; %il primo inserimento deve creare la matrice
    for i = 1:length(selected)
        if first
            matrix = features(:,selected(i)); 
            first = false;
        else
            matrix = [matrix features(:,selected(i))];
        end           
    end
end