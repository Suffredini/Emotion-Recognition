% Run from folder: Script/IntelligentSystemProject <----- IMPORTANT
cd Dataset;
startS = 2560;
endS = 8064;
middleS = startS+(endS-startS)/2;

filename = dir('*.mat');
people = length(filename)*2;
data = zeros(40,40,(endS-startS)/2,people);
labels = zeros(40,2,people);

parfor i = 1:people 
    if i>32
        tmp = i-32;
        s = middleS+1;
        e = endS;
    else
        tmp = i;
        s = startS+1;
        e = middleS;
    end
   
    %assegno label
	labelTmp = load(filename(tmp).name,'labels'); %importo file
	labelTmp = cell2mat(struct2cell(labelTmp)); 
	labels(:,:,i) = labelTmp(:,1:2); % tolgo le ultime due colonne
		
	%assegno data
    dataTmp = load(filename(tmp).name,'data');
	dataTmp = cell2mat(struct2cell(dataTmp));
	data(:,:,:,i) = dataTmp(:,:,s:e);

end

cd ../;

clear i e s tmp;
clear labelTmp ;
clear dataTmp;
clear filename;
clear name;
clear index;
clear people endS startS middleS;

