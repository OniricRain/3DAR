% testing script for autoencoders
clc
clear all
close all

% datasets
% dataset_name = 'portello' %training
% dataset_name = 'tiso' %testing
% dataset_name = 'castle' %training
% dataset_name = 'fountain' %testing



%% Load the dataset and preprocess the images

[images,cameraParams] = loadGrayData('portello');
%% processing SURF on train image

for i = 1:length(images)
    I = undistortImage(images{i}, cameraParams);
    keypoints{1,i} = detectSURFFeatures(I, 'NumOctaves', 8);
    features{1,i} = extractFeatures(I, keypoints{1,i}, 'Upright', true,'FeatureSize',128); %try set Upright to false
end

train_set = feat2set(features);


[images,cameraParams] = loadGrayData('tiso');
%% processing SURF on test image
for i = 1:length(images)
    I = undistortImage(images{i}, cameraParams);
    keypoints{1,i} = detectSURFFeatures(I, 'NumOctaves', 8);
    features{1,i} = extractFeatures(I, keypoints{1,i}, 'Upright', true,'FeatureSize',128); %try set Upright to false
end
test_set = feat2set(features);

mse_error_train = zeros(1,128);
mse_error_test = zeros(1,128);

save('data/train&test.mat','train_set','test_set');
%% autoencoding
load('data/train&test.mat')
layers = [64,32,16,8,4,2,1];
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