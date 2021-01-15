clear all
close all
clc


% choose dataset
% dataset_name = 'portello'
% dataset_name = 'tiso'
% dataset_name = 'castle'
dataset_name = 'fountain'

% Load all the images to be used in the dataset
dir_files = strcat('data\', dataset_name,'\dataset');
imds = imageDatastore(dir_files);


method = "KAZE";
% method = "SURF";
if(method == "KAZE")
    models = ["KAZEautoencoder_32.mat", "KAZEautoencoder_16.mat", "KAZEautoencoder_8.mat", ...
              "KAZEautoencoder_4.mat", "KAZEautoencoder_2.mat", "KAZEautoencoder_1.mat"];
    % load features
    load(strcat('data/', dataset_name,'/', dataset_name, '_KAZEfeatures.mat'));
elseif(method == "SURF")
    models = ["SURFautoencoder_32.mat", "SURFautoencoder_16.mat", "SURFautoencoder_8.mat", ...
              "SURFautoencoder_4.mat", "SURFautoencoder_2.mat", "SURFautoencoder_1.mat"];

    load(strcat('data/', dataset_name,'/', dataset_name, '_SURFfeatures.mat'));
end


for i = 1:length(models)
    load (models(i));
    reconstructAndMatch(dataset_name, imds, features, autoencoder, method);
end




