clear all
close all
clc


% choose dataset
% dataset_name = 'portello'
dataset_name = 'tiso'
% dataset_name = 'castle'
% dataset_name = 'fountain'

% Load all the images to be used in the dataset
dir_files = strcat('data\', dataset_name,'\dataset');
imds = imageDatastore(dir_files);



models = ["autoencoder_2.mat", "autoencoder_16.mat", "autoencoder_8.mat", ...
          "autoencoder_4.mat", "autoencoder_2.mat", "autoencoder_1.mat"];

% load features
load(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'))

for i = 1:length(models)
    % load autoencoder
    load (models(i))
    reconstructFeaturesWithAutoencoder(dataset_name, imds, features, autoencoder);
end




