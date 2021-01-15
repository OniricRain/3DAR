function [prediction,mse_error_test] = testAutoencoder(test_set,autoencoder)
%testAutoencoder, function test autoencoder
%input:
%       -test_set: testing data set 
%       -autoencoder: cell array containing autoencoders
%output:
%       -prediction: estimated output of the autoencoder
%       -mse_error_test: mean squared error on test set


prediction = predict(autoencoder,test_set);
mse_error_test = mse(test_set-prediction);
end

