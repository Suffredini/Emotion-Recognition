% run after WX_1_FeaturesExtraction.m

arousalClasses = extractClass(arousalTarget);
valenceClasses = extractClass(valenceTarget);

function classMatrix = extractClass(t)
    class = 3;
    len = length(t(:,1));
    classMatrix = zeros(len,class);

    for i=1:len
       a=t(i,1)
       if t(i,1)< class
           classMatrix(i,1) = 1;
       elseif t(i,1) < class*2
           classMatrix(i,2) = 1;
       else
           classMatrix(i,3) = 1;
       end       
    end
end