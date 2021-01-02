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
tic
for i = 1:128
%% training autoencoding
autoenc = trainAutoencoder(train_set,i,'UseGPU',true);
encoded_features = encode(autoenc,train_set);
recon_train = predict(autoenc,train_set);
mse_error_train(i) = mse(train_set-recon_train);


%% testing autoencoding

recon_test = predict(autoenc,test_set);
mse_error_test(i) = mse(test_set-recon_test);
end
toc
figure(1);
plot(1:128,mse_error_test);
hold on;
plot(1:128,mse_error_train);
legend;