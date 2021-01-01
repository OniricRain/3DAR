%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                     3D AUGMENTED REALITY PROJECT                        %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all

% choose dataset
dataset_name = 'portello'
% dataset_name = 'tiso'
% dataset_name = 'castle'
% dataset_name = 'fountain'



%% Load the dataset and preprocess the images

% Load all the images to be used in the dataset
dir_files = strcat('data\', dataset_name,'\dataset');
imds = imageDatastore(dir_files);

% load intrinsic parameters for camera
load(fullfile(dir_files, 'cameraPar.mat'));

% Convert the images to grayscale.
images = cell(1, numel(imds.Files));
for i = 1:numel(imds.Files)
    I = readimage(imds, i);
    images{i} = rgb2gray(I);  %store images in the cell array
end

%% Create .txt files which contain info about the keypoints descriptors

keypoints = cell(1, length(images));
features = cell(1, length(images));


% Compute for all the images the keypoints and the descriptors. By knowing
% the keypoints it's possible to write the location, scale and orientation
% information in .txt files (one file for every image)
for i = 1:length(images)
        
    % Undistort the first image.
    I = undistortImage(images{i}, cameraParams);
    
    % save undistorted grayscale images (will be the COLMAP dataset)
    image_path = imds.Files{i};
    saveGrayUndistortedImage(image_path, I, dataset_name)

    % Detect keyoints using SURF and extract the descriptors
    keypoints{1,i} = detectSURFFeatures(I, 'NumOctaves', 8);
    features{1,i} = extractFeatures(I, keypoints{1,i}, 'Upright', true); %try set Upright to false

    % Write the keypoints location, scale and orientation in a .txt file
    % NB: COLMAP only supports 128-D descriptors for now, i.e. the cols
    % column must be 128 (even if i use SURF)
    writeFeatures(image_path, keypoints{1,i}, dataset_name)   
end

%% Create .txt files that contain informations about the matching keypoints

% This matrix contains the number of matching points between every image
C = zeros(length(images),length(images));

for n = 1:length(images)
    for m = setdiff(1:length(images),n) % = for every image different from n
        
        % match features
        index_pairs = matchFeatures(features{1,n}, features{1,m}, 'MaxRatio', .7, 'Unique',  true);
        
        % allocate the indices of the coupling points in index_pairs cell
        C(n,m) = size(index_pairs,1);
        
        % append in the same .txt file the index pairs
        image_path1 = imds.Files{n};
        image_path2 = imds.Files{m};
        writeMatchingIndexes(image_path1, image_path2, index_pairs, dataset_name)
    end
end