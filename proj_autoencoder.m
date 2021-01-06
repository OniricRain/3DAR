% testing script for autoencoders
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
train_set = normalize(train_set);
test_set_fountain = normalize(test_set_fountain);
test_set_tiso = normalize(test_set_tiso);

%% autoencoding
N_iteration = [32];

GPU_bool = true;

mse_error_train = zeros(1,length(N_iteration));
mse_error_test_fount = zeros(1,length(N_iteration));
mse_error_test_tiso = zeros(1,length(N_iteration));
prediction_on_train = cell(1,length(N_iteration));
% prediction_fountain = cell(1,length(N_iteration));
% prediction_tiso = cell(1,length(N_iteration));
% prediction_portello = cell(1,length(N_iteration));
% prediction_castle = cell(1,length(N_iteration));
for i =1:length(N_iteration)
    layers = N_iteration(i);
    tic
    %training the autoencoder
    [autoencoder,mse_error_train(i),prediction_on_train{i}] = createAutoencoder(train_set,layers,GPU_bool);
    toc
    save(strcat('autoencoder_',string(N_iteration(i))),'autoencoder');
    tic
    %prediction on portello
    prediction_portello = prediction_on_train{i}(1:num_features_portello);
    save(strcat('data/portello/portello_recon_features_',string(N_iteration(i))),'prediction_portello');
    %prediction on castle
    prediction_castle = prediction_on_train{i}(num_features_portello+1:end);
    save(strcat('data/castle/castle_recon_features_',string(N_iteration(i))),'prediction_castle');
    %prediction on test set 1 (fountain)
    [prediction_fountain,mse_error_test_fount(i)] = testAutoencoder(test_set_fountain,autoencoder);
    save(strcat('data/fountain/fountain_recon_features_',string(N_iteration(i))),'prediction_fountain');
    %prediction on test set 2 (tiso)
    [prediction_tiso,mse_error_test_tiso(i)] = testAutoencoder(test_set_tiso,autoencoder);
    save(strcat('data/fountain/fountain_recon_features_',string(N_iteration(i))),'prediction_fountain');
    toc
end

%%
figure(1);
plot(N_iteration,mse_error_train);
hold on;
plot(N_iteration,mse_error_test_fount);
hold on;
plot(N_iteration,mse_error_test_tiso);
legend('train','test fountain','test tiso');