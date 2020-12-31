clc
clear all
close all


% Load all the images to be used in the dataset
dir_files = 'datasets\portelloDataset';
imds = imageDatastore(dir_files);

% load intrinsic parameters for camera
load(fullfile(dir_files, 'cameraPar.mat'));

%Define and apply the image order
% image_order=[ 1 2 3 4 5 6 7 8];
% imds.Files = imds.Files(image_order);

% Convert the images to grayscale.
images = cell(1, numel(imds.Files));
for i = 1:numel(imds.Files)
    I = readimage(imds, i);
    images{i} = rgb2gray(I);  %store images in the cell array
end


%% 
keypoints = cell(1, numel(imds.Files));
features = cell(1, numel(imds.Files));
%index_pairs = cell(numel(imds.Files),numel(imds.Files));

% Undistort the first image.
I = undistortImage(images{1}, cameraParams); 

% Detect features of the first image. 
keypoints{1,1} = detectSURFFeatures(I, 'NumOctaves', 8);
features{1,1} = extractFeatures(I, keypoints{1,1}, 'Upright', true);

% Write the keypoints location, scale and orientation in a .txt file
image_path = imds.Files{1};
writeFeatures(image_path, keypoints{1,1})

% repeat for all the other images and perform the matching
for i = 2:2%numel(images)
        
    % Undistort the first image.
    I = undistortImage(images{i}, cameraParams);

    % Detect keyoints using SURF and extract the descriptors
    keypoints{1,i} = detectSURFFeatures(I, 'NumOctaves', 8);
    features{1,i} = extractFeatures(I, keypoints{1,i}, 'Upright', true); %try set Upright to false

    % Write the keypoints location, scale and orientation in a .txt file
    % NB: COLMAP only supports 128-D descriptors for now, i.e. the cols
    % column must be 128 (even if i use SURF)
    image_path = imds.Files{i};
    writeFeatures(image_path, keypoints{1,i})

    % match features
    index_pairs = matchFeatures(features{1,i-1}, features{1,i}, 'MaxRatio', .7, 'Unique',  true);
    % QUESTO è SBAGLIATO
    % write match indexes
    
end