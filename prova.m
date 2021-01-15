clc
clear all
close all

% A = [1,2,3,4,5]
% norma = norm(A)
% 
% n_A = A/norma
% 
% 
% n_A_1 = normalize(A)
% 
% somma = sum(n_A_1)






loadDataset;
layers = [ ...
    sequenceInputLayer(64)
    reluLayer
    fullyConnectedLayer(32)
    reluLayer
    fullyConnectedLayer(64)
    regressionLayer];

options = trainingOptions('rmsprop', ...
                          'MaxEpochs',15, ...
                          'Shuffle','every-epoch', ...
                          'Plots','training-progress', ...
                          'Verbose',true)

net = trainNetwork(train_set,train_set,layers,options);









