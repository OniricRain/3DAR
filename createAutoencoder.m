function [autoencoder,mse_error_train,prediction_on_train] = createAutoencoder(train_set,layers,GPU_bool)
%createAutoencoder, function to create and train a multilayer autoencoder
%input:
%       -train_set: training data set 
%       -layers: array containing the number of neurons for each layer
%       -GPU_bool: specify if GPU is available for computation
%output:
%       -autoencoder: cell array containing the different autoencoders
%       layers, e.g. for an input layer [64,32] the autoencoder{1} will
%       be a network capable of encode input size to 64 and decode
%       viceversa; autoencoder{2} can encode 64 to 32 and decode 32 to 64

autoencoder = cell(1,length(layers));%cell i contains autoencoder of layer i
encoded = cell(1,length(layers));%cell i contains encoded features of layer i
decoded = cell(1,length(layers));
autoencoder{1} = trainAutoencoder(train_set,layers(1),'UseGPU',GPU_bool);
encoded{1} = encode(autoencoder{1},train_set);
for i = 2:length(layers)
    autoencoder{i} = trainAutoencoder(encoded{i-1},layers(i),'UseGPU',GPU_bool);
    encoded{i} = encode(autoencoder{i},encoded{i-1});
end

%decoding
decoded{end} = decode(autoencoder{end},encoded{end}); %deeper layer decode
for i = length(layers)-1:-1:1 %from the penultimate layer to the first with pace -1
    decoded{i} = decode(autoencoder{i},decoded{i+1});
end
prediction_on_train = decoded{1};
mse_error_train = mse(train_set-decoded{1});
end

