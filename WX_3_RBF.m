%%RBF Code
input = valenceInput';
target = valenceTarget'; 
mse = 3.3190;
spread = 0.1;
maxNeurons = 1000;
step = 270;

rbfnet = newrb(input,target,mse,spread,maxNeurons,step); 

view(rbfnet);
results = sim(rbfnet,input);
plot(input, target,'o');
hold on;
plot(input, results)
xlabel('input')
ylabel('target/result')
RegRBF = regression(target, results)
%%Codice per calcolo dell'MSE con funzione perform