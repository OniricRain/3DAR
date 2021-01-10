% Script for Multiple layer layer autoencoders
% This script trains different autoencoders of variable hidden size and multiple layers,
% then perform a prediction on the test sets fountain and tiso computing the MSE 
clc
clear all
close all

%% Load the training set and the test set
loadDataset;
%% autoencoding
architectures = {[32,16]}; %vector containing the hidden sizes used in the for cycle

GPU_bool = true;

mse_error_train = zeros(1,length(architectures));
mse_error_test_fount = zeros(1,length(architectures));
mse_error_test_tiso = zeros(1,length(architectures));
prediction_on_train = cell(1,length(architectures));

for i =1:length(architectures)
    layers = architectures{i};
    tic
    %training the autoencoder
    [autoencoder,mse_error_train(i),prediction_on_train{i}] = createAutoencoder(train_set,layers,GPU_bool);
    toc
    filename = strcat('autoencoder_',strjoin(string(architectures{i}),'_'));
    save(filename,'autoencoder');
    tic
    %prediction on test set 1 (fountain)
    [prediction_fountain,mse_error_test_fount(i)] = testAutoencoder(test_set_fountain,autoencoder);
    %prediction on test set 2 (tiso)
    [prediction_tiso,mse_error_test_tiso(i)] = testAutoencoder(test_set_tiso,autoencoder);
    toc
end

%% MSE PLOT
figure(1);
plot(1:2,mse_error_train);
hold on;
plot(1:2,mse_error_test_fount);
hold on;
plot(1:2,mse_error_test_tiso);
legend('Training set','Test set fountain','Test set tiso');
% xticks(flip(architectures));
grid on
xlabel('Architectures');
ylabel('MSE');