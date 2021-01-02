function [images,cameraParams] = loadGrayData(dataset_name)
% loadGrayData function, load all the images to be used in the dataset and
% compute surf on it.
% input: 
%        - dataset_name: name of the dataset (portello, castle...)
% output:
%        - images: set of gray images for running SURF on 
%        - cameraParams: the camera parameters obtained from dataset
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
end

