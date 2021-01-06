% testing script for autoencoders
clc
clear all
close all

%% Load the training set and the test set
% training set
dataset_name = 'portello'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
features1 = feat2set(features);

dataset_name = 'castle'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
features2 = feat2set(features);

train_set = cat(2,features1,features2);


% test set
dataset_name = 'fountain'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
test_set1 = feat2set(features);

dataset_name = 'tiso'
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))
test_set2 = feat2set(features);


%normalization of the features
train_set = normalize(train_set);
test_set1 = normalize(test_set1);
test_set2 = normalize(test_set2);

%% autoencoding
N_iteration = [32,16,8,4,2];
layers = [N];
GPU_bool = true;

mse_error_train = zeros(1,length(N_iteration));
mse_error_test = zeros(1,length(N_iteration));
for i =1:length(N_iteration)
    tic
    [autoencoder,mse_error_train(i)] = createAutoencoder(train_set,layers,GPU_bool);
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