% Run from folder: Script/IntelligentSystemProject <----- IMPORTANT
cd Dataset;
filename = dir('*.mat');

startSample = 1999;
endSample = 8000;
people = length(filename);

data = zeros(40,40,endSample-startSample+1,people);
labels = zeros(40,2,people);
parfor i = 1:people 
	%assegno label
	labelTmp = load(filename(i).name,'labels'); %importo file
	labelTmp = cell2mat(struct2cell(labelTmp)); 
	labels(:,:,i) = labelTmp(:,1:2); % tolgo le ultime due colonne
		
	%assegno data
    dataTmp = load(filename(i).name,'data');
	dataTmp = cell2mat(struct2cell(dataTmp));
	data(:,:,:,i) = dataTmp(:,:,startSample:endSample);
end

cd ../;
clear people startSample endSample index name filename dataTmp labelTmp i;