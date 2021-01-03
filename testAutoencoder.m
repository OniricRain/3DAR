function [prediction,mse_error_test] = testAutoencoder(test_set,autoencoder)
%createAutoencoder, function to create and train a multilayer autoencoder
%input:
%       -test_set: testing data set 
%       -autoencoder: cell array containing the different levels
%       autoencoders
%output:
%       -prediction: estimated output of the autoencoder
%       -mse_error_test: mean squared error on test set

encoded = cell(1,length(autoencoder));%cell i contains encoded features of layer i
decoded = cell(1,length(autoencoder));

encoded{1} = encode(autoencoder{1},test_set);
for i = 2:length(autoencoder)
    encoded{i} = encode(autoencoder{i},encoded{i-1});
end

%decoding
decoded{end} = decode(autoencoder{end},encoded{end});
for i = length(autoencoder)-1:-1:1
    decoded{i} = decode(autoencoder{i},decoded{i+1});
end
prediction = decoded{1};
mse_error_test = mse(test_set-prediction);
end

