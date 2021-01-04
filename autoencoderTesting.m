% testing script for autoencoders
clc
clear all
close all

%% Load the training set and the test set

dataset_name = 'portello'
% dataset_name = 'castle'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
train_set = feat2set(features);

dataset_name = 'tiso'
% dataset_name = 'fountain'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
test_set = feat2set(features);

%normalization of the features
train_set = normalize(train_set);
test_set = normalize(test_set);

mse_error_train = zeros(1,128);
mse_error_test = zeros(1,128);

%% autoencoding

layers = [32,16,8,4,2,1];
GPU_bool = true;

mse_error_train = zeros(1,length(layers));
mse_error_test = zeros(1,length(layers));
for i =1:length(layers)
    temp_layers = layers(1:i);
    tic
    [autoencoder,mse_error_train(i)] = createAutoencoder(train_set,temp_layers,GPU_bool);
    toc
    tic
    [prediction,mse_error_test(i)] = testAutoencoder(test_set,autoencoder);
    toc
end

figure(1);
plot(1:length(layers),mse_error_train);
hold on;
plot(1:length(layers),mse_error_test);
legend('train','test');