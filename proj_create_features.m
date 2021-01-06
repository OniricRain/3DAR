%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                     3D AUGMENTED REALITY PROJECT                        %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all

% choose dataset
% dataset_name = 'portello'
dataset_name = 'tiso'
% dataset_name = 'castle'
% dataset_name = 'fountain'
% dataset_name = 'mini_fountain'



%% Load the dataset and preprocess the images

% Load all the images to be used in the dataset
dir_files = strcat('data\', dataset_name,'\dataset');
imds = imageDatastore(dir_files);

% load intrinsic parameters for camera
% load(fullfile(dir_files, 'cameraPar.mat'));

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
    %I = undistortImage(images{i}, cameraParams);
    
    % save undistorted grayscale images (will be the COLMAP dataset)
    image_path = imds.Files{i};
    saveGrayImage(image_path, images{i}, dataset_name) % TODO: rename function (togli udistorted)

    % Detect keyoints using SURF and extract the descriptors
    keypoints{1,i} = detectSURFFeatures(images{i}, 'NumOctaves', 8);
    features{1,i} = extractFeatures(images{i}, keypoints{1,i}, 'Upright', false); 

    % Write the keypoints location, scale and orientation in a .txt file
    % NB: COLMAP only supports 128-D descriptors for now, i.e. the cols
    % column must be 128 (even if i use SURF)
    writeFeatures(image_path, keypoints{1,i}, dataset_name)   
end

%% Create .txt files that contain informations about the matching keypoints

% C contains the number of matching points between every image
C = zeros(length(images),length(images));
% this cell contains the matching points indexes between every image
matchings = cell(length(images),length(images));

for n = 1:length(images)
    for m = setdiff(1:length(images),n) % = for every image different from n
        
        % match features
        index_pairs = matchFeatures(features{1,n}, features{1,m}, 'MaxRatio', .7, 'Unique',  true);
        
        % allocate number of coupling features
        C(n,m) = size(index_pairs,1);
        
        % allocate the indices of the coupling points in matching cell
        matchings{n,m} = index_pairs;
    end
end
%%
% To fill the .txt file 
for n = 1:length(images)-1
    for m = n+1:length(images)
        image_path1 = imds.Files{n};
        image_path2 = imds.Files{m};
        
        A = matchings{n,m};
        B = matchings{m,n}; % I want to put the new couples of indexes of B in A
        
        B(:,[1 2]) = B(:,[2 1]); % swap the two columns
        % save indices of couples in B that are not found in A
        idx_new_couples = find(~ismember(B,A,'rows')); 
        % get the new couples by knoing their indices
        new_couples = B(idx_new_couples,:);
        
        % concatenate the two matrices of couples
        matching_couples = cat(1, A, new_couples);
        % sort indexes
        matching_couples = sortrows(matching_couples,1);
        matching_couples = matching_couples - 1; %subtract one for starting indexes from zero
        
        % save in the .txt file
        writeMatchingIndexes(image_path1, image_path2, matching_couples, dataset_name)   
    end
end

%% Save the features in the current directory
save(strcat('data/', dataset_name,'/', dataset_name, '_features.mat'), 'features');
