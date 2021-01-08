% testing script for single layer autoencoders
% This script trains different autoencoders of variable hidden size,
% then perform a prediction on the test sets fountain and tiso computing the MSE 
clc
clear all
close all

%% Load the training set and the test set
% training set
dataset_name = 'portello'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
features1 = feat2set(features);
num_features_portello = length(features1);
dataset_name = 'castle'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
features2 = feat2set(features);

train_set = cat(2,features1,features2);


% test set
dataset_name = 'fountain'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
test_set_fountain = feat2set(features);

dataset_name = 'tiso'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
test_set_tiso = feat2set(features);


%normalization of the features
subtrain_set_portello = normalize(features1);
subtrain_set_castle = normalize(features2);
train_set = normalize(train_set);
test_set_fountain = normalize(test_set_fountain);
test_set_tiso = normalize(test_set_tiso);

%% autoencoding
hidden_size = [32,16,8,4,2,1]; %vector containing the hidden sizes used in the for cycle

GPU_bool = true;

mse_error_train = zeros(1,length(hidden_size));
mse_error_test_fount = zeros(1,length(hidden_size));
mse_error_test_tiso = zeros(1,length(hidden_size));
prediction_on_train = cell(1,length(hidden_size));

for i =1:length(hidden_size)
    layers = hidden_size(i);
    tic
    %training the autoencoder
    [autoencoder,mse_error_train(i),prediction_on_train{i}] = createAutoencoder(train_set,layers,GPU_bool);
    toc
    save(strcat('autoencoder_',string(hidden_size(i))),'autoencoder');
    tic
    %prediction on test set 1 (fountain)
    [prediction_fountain,mse_error_test_fount(i)] = testAutoencoder(test_set_fountain,autoencoder);
    %prediction on test set 2 (tiso)
    [prediction_tiso,mse_error_test_tiso(i)] = testAutoencoder(test_set_tiso,autoencoder);
    toc
end

%% MSE PLOT
figure(1);
plot(hidden_size,mse_error_train);
hold on;
plot(hidden_size,mse_error_test_fount);
hold on;
plot(hidden_size,mse_error_test_tiso);
legend('Training set','Test set fountain','Test set tiso');
xticks(flip(hidden_size));
grid on
xlabel('Hidden size');
ylabel('MSE');