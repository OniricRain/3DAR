function [autoencoder,mse_error_train,prediction_on_train] = createAutoencoder(train_set,layers,GPU_bool)
%createAutoencoder, function to create and train an autoencoder
%input:
%       -train_set: training data set 
%       -layers: array containing the number of neurons for each layer
%       -GPU_bool: specify if GPU is available for computation
%output:
%       -autoencoder: cell array containing the autoencoder


autoencoder = trainAutoencoder(train_set,layers(1),'UseGPU',GPU_bool);

prediction_on_train = predict(autoencoder,train_set);
mse_error_train = mse(train_set-prediction_on_train);
end

